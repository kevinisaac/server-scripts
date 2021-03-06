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

# Install jinja2
sudo pip3 install jinja2

sudo mkdir -p $REPO_DIR && cd $REPO_DIR && echo "Git repository directory set up at: $REPO_DIR"
sudo mkdir $SITE_DIR && cd $REPO_DIR && echo "Site is located at: $SITE_DIR"

echo "Setting up group for the directories.."
sudo chown $USERNAME:$GROUPNAME $REPO_DIR -R
sudo chown $USERNAME:$GROUPNAME $SITE_DIR -R

# TODO - Check if g+sw works
sudo find $REPO_DIR -type d -exec chmod g+sw {} +
sudo find $SITE_DIR -type d -exec chmod g+sw {} +

# Git stuff
echo 'Initializing bare Git repo..'
git init --bare

echo 'Create the post-receive hook..'

cd hooks
# Create the post-receive file

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
sudo systemctl restart nginx && echo 'Done!'

# Setting fish marks
echo "Setting fish marks..."
cat "export DIR_g$REPO_NAME=\"$REPO_DIR\"" >> ~/.sdirs
cat "export DIR_$REPO_NAME=\"$SITE_DIR\"" >> ~/.sdirs
echo "Done!"

echo "Setting permissions for directories..."
sudo chown $USERNAME:$USERNAME ~ -R && echo "Done!"

# Allow port 80 via firewall
echo "Allowing 'Nginx Full' on Nginx..."
sudo ufw allow 'Nginx Full' && echo 'Done!'

