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
pip install -r requirements.txt

# Setting up the service file

echo "Now add the repository to you local repo like this - git remote add live ssh://$USER@$SERVER_IP$REPO_DIR"
