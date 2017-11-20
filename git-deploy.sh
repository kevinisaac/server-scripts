#!/bin/bash

SERVER_IP=`ip route get 1 | awk '{print $NF;exit}'`
USERNAME=`whoami`
# Getting the secondary group (the developer group) of the user
GROUPNAME=`groups | awk '{print $NF}'`

read -p "Enter the git repository's name: " REPO_NAME               # /var/git/$REPO_NAME.git
read -p "Enter the site's name ($REPO_NAME): " SITE_NAME            # /var/www/$SITE_NAME

REPO_DIR="/var/git/$REPO_NAME.git"
SITE_DIR="/var/www/${SITE_NAME:-$REPO_NAME}"


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
echo "
#!/bin/sh
git --work-tree=$SITE_DIR --git-dir=$REPO_DIR checkout -f
" > post-receive

sudo chmod +x post-receive

echo 'Git repository set up successfully!'
echo 'Setting up virtualenv for repo $REPO_DIR...'
cd $SITE_DIR
virtualenv venv -p `which python3`
. venv/bin/activate

echo "Push your local repo code and then proceed (Press enter to continue): "
read -s -n 1 key

if [[ $key != "" ]]; then 
    echo "Tasks left: push your code, set up systemd service file and start the service."
fi

pip install -r requirements.txt

# Setting up the service file
NEW_SERVICE_FILE_NAME=${SITE_NAME:-$REPO_NAME}.service
NEW_SERVICE_FILE_PATH=/etc/systemd/system/$NEW_SERVICE_FILE_NAME
echo "Setting up the service file $NEW_SERVICE_FILE_PATH..."
sudo cp /home/$USERNAME/server-scripts/conf/flask_app.service $NEW_SERVICE_FILE_PATH
sudo vim $NEW_SERVICE_FILE_PATH

# Enabling and restarting the service
echo "Enabling and restarting the service..." && \
sudo systemctl daemon-reload && \
sudo systemctl enable $NEW_SERVICE_FILE_NAME && \
sudo systemctl restart $NEW_SERVICE_FILE_NAME && \
echo 'Done!'

# TODO: Nginx setup

echo "Now add the repository to you local repo like this - git remote add live ssh://$USER@$SERVER_IP$REPO_DIR"
