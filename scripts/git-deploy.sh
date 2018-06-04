#!/bin/bash

SERVER_IP=`ip route get 1 | awk '{print $NF;exit}'`
USERNAME=`whoami`
# Getting the secondary group (the developer group) of the user
GROUPNAME=`groups | awk '{print $NF}'`

read -p "Enter the git repository's name: " REPO_NAME               # /var/git/$REPO_NAME.git
read -p "Enter the site's name ($REPO_NAME): " SITE_NAME            # /var/www/$SITE_NAME
read -p "Enter the checkout branch (demo/live): " CO_BRANCH         # demo/live

REPO_DIR="/var/git/$REPO_NAME.git"
SITE_DIR="/var/www/${SITE_NAME:-$REPO_NAME}"
SERVICE_NAME=${SITE_NAME:-$REPO_NAME}
NEW_SERVICE_FILE_NAME=$SERVICE_NAME.service


sudo mkdir -p $REPO_DIR && cd $REPO_DIR && echo "Git repository directory set up at: $REPO_DIR"
sudo mkdir $SITE_DIR && cd $REPO_DIR && echo "Site is located at: $SITE_DIR"

echo "Setting up group for the directories.."
sudo chown $USERNAME:$GROUPNAME /var/git -R
sudo chown $USERNAME:$GROUPNAME /var/www -R

# Git stuff
echo 'Initializing bare Git repo..'
git init --bare

echo 'Create the post-receive hook..'
cd hooks
echo "#!/bin/sh
git --work-tree=$SITE_DIR --git-dir=$REPO_DIR checkout $CO_BRANCH -f

# Install the required Python packages
cd $SITE_DIR
. venv/bin/activate
pip install -r requirements.txt

cd $REPO_DIR

COMMIT_USER=\`git log -1 | sed -n 2p | awk '{print $2}'\`
COMMIT_ID=\`git log -1 | sed -n 1p | awk '{print \$2}' | cut -c 28-\`
COMMIT_MESSAGE=\`git log -1 | sed -n 5p\`
CURRENT_BRANCH=\`git branch | awk '{print \$2}'\`
APP_NAME=\"Alibalance\"
APP_SNAME=\"alibalance\"
APP_URL=\"alibalance.getpreview.io\"
SLACK_CHANNEL=\"#kevin_private\"
SLACK_APP_URL=\"https://hooks.slack.com/services/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\"

# Restart the application server
echo 'Restarting service $NEW_SERVICE_FILE_NAME...'
if sudo systemctl restart $NEW_SERVICE_FILE_NAME; then
    echo 'Service restarted successfully!'

    curl --header 'Content-type: application/json' \
        --request POST \
        --data \"{
            'channel': '$SLACK_CHANNEL',
            'text': 'Someone has deployed \$APP_NAME to the servers! (\$APP_URL)',
            'attachments': [
                {
                    'color': '#3AA3E3',
                    'title': 'Latest Commit',
                    'title_link': 'https://github.com/Zephony/\$APP_SNAME/commits/demo',
                    'fields': [
                        {
                            'value': '\`\$COMMIT_ID\`: \$COMMIT_MESSAGE',
                        },
                        {
                            'title': 'Status',
                            'value': 'success',
                            'short': true,
                        },
                        {
                            'title': 'Branch',
                            'value': 'demo',
                            'short': true,
                        }
                    ],
                    'author_name': '\$COMMIT_USER',
                    'author_icon': 'https://i.imgur.com/1xkPK57.png',
                    'footer': 'Deployed to DigitalOcean',
                    'footer_icon': 'https://img.stackshare.io/service/295/DO_Logo_icon_blue.png'
                }
            ]
        }\" \
    \"\$SLACK_APP_URL\"

else
    echo 'ERROR: Service not restarted'

    curl --header 'Content-type: application/json' \
        --request POST \
        --data \"{
            'channel': '$SLACK_CHANNEL',
            'text': 'Look at the mess you have made, deploying broken apps! ($APP_URL)',
            'attachments': [
                {
                    'color': '#C91D12',
                    'title': 'Latest Commit',
                    'title_link': 'https://github.com/Zephony/$APP_SNAME/commits/demo',
                    'fields': [
                        {
                            'value': '\`$COMMIT_ID\`: $COMMIT_MESSAGE',
                        },
                        {
                            'title': 'Status',
                            'value': 'error',
                            'short': true,
                        },
                        {
                            'title': 'Branch',
                            'value': 'demo',
                            'short': true,
                        }
                    ],
                    'author_name': '$COMMIT_USER',
                    'author_icon': 'https://i.imgur.com/1xkPK57.png',
                    'footer': 'Deployed to DigitalOcean',
                    'footer_icon': 'https://img.stackshare.io/service/295/DO_Logo_icon_blue.png'
                }
            ]
        }\" \
    '$SLACK_APP_URL'
fi
" > post-receive

sudo chmod +x post-receive

echo 'Git repository set up successfully!'
echo 'Setting up virtualenv for repo $REPO_DIR...'
cd $SITE_DIR
virtualenv venv -p `which python3`
. venv/bin/activate

echo "Now add the repository to you local repo like this - git remote add $CO_BRANCH ssh://$USER@$SERVER_IP$REPO_DIR"
echo "Then, push your local repo code and then proceed (Press enter to continue): "
read -s -n 1 key

if [[ $key != "" ]]; then 
    echo "Tasks left: push your code, set up systemd service file and start the service."
fi

pip install -r requirements.txt

# Setting up the service file
NEW_SERVICE_FILE_PATH=/etc/systemd/system/$NEW_SERVICE_FILE_NAME
echo "Setting up the service file $NEW_SERVICE_FILE_PATH..."
sudo cp /home/$USERNAME/server-scripts/conf/systemd/flask_app.service $NEW_SERVICE_FILE_PATH
sudo vim $NEW_SERVICE_FILE_PATH

# Enabling and restarting the service
echo "Enabling and restarting the service..." && \
sudo systemctl daemon-reload && \
sudo systemctl enable $NEW_SERVICE_FILE_NAME && \
sudo systemctl restart $NEW_SERVICE_FILE_NAME && \
echo 'Done!'

echo "Allowing group $GROUPNAME to restart $NEW_SERVICE_FILE_NAME..."
sudo echo "%$GROUPNAME ALL= NOPASSWD: /bin/systemctl stop $SERVICE_NAME*
%$GROUPNAME ALL= NOPASSWD: /bin/systemctl restart $SERVICE_NAME*
%$GROUPNAME ALL= NOPASSWD: /bin/systemctl start $SERVICE_NAME*
" > /etc/sudoers.d/$GROUPNAME && echo 'Done!'

# Nginx setup
NEW_NGINX_FILE_NAME=${SITE_NAME:-$REPO_NAME}.conf
NEW_NGINX_FILE_PATH=/etc/nginx/sites-available/$NEW_NGINX_FILE_NAME
echo "Setting up the nginx config file $NEW_NGINX_FILE_PATH..."
sudo cp /home/$USERNAME/server-scripts/conf/nginx/flask_app.conf $NEW_NGINX_FILE_PATH
sudo vim $NEW_NGINX_FILE_PATH

# Enabling and restarting the service
echo "Enabling the site and restarting nginx..." && \
sudo ln -s /etc/nginx/sites-available/$NEW_NGINX_FILE_NAME /etc/nginx/sites-enabled/$NEW_NGINX_FILE_NAME
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx && echo 'Done!'

# Setting fish marks
echo "Setting fish marks..."
cat "export DIR_g$REPO_NAME=\"$REPO_DIR\"" >> ~/.sdirs
cat "export DIR_$SITE_NAME=\"$SITE_DIR\"" >> ~/.sdirs
echo "Done!"

echo "Setting permissions for directories..."
sudo chown $USERNAME:$USERNAME ~ -R && echo "Done!"

# Allow port 80 via firewall
echo "Allowing 'Nginx Full' on Nginx..."
sudo ufw allow 'Nginx Full' && echo 'Done!'
