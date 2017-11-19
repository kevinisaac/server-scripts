#!/bin/bash

SERVER_IP=`ip route get 1 | awk '{print $NF;exit}'`

read -p "Enter the git repository's name: " REPO_NAME               # /var/git/$REPO_NAME.git
read -p "Enter the site's name ($REPO_NAME): " SITE_NAME            # /var/www/$SITE_NAME

REPO_DIR="/var/git/$REPO_NAME.git"
SITE_DIR="/var/www/${SITE_NAME:-$REPO_NAME}"


mkdir -p $REPO_DIR && cd $REPO_DIR && echo "Git repository directory set up at: $REPO_DIR"
mkdir $SITE_DIR && cd $REPO_DIR && echo "Site is located at: $SITE_DIR"

# Git stuff
echo 'Initializing bare Git repo..'
git init --bare

echo 'Create the post-receive hook..'
cd hooks
echo "
#!/bin/sh
git --work-tree=$SITE_DIR --git-dir=$REPO_DIR checkout -f
" > post-receive

chmod +x post-receive

echo 'Git repository set up successfully!'
echo "Now add the repository to you local repo like this - git remote add live ssh://$USER@$SERVER_IP$REPO_DIR"
