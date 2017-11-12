#!/bin/bash

USERNAME=$1
OMFTHEME=$2

## Set up ssh keys
echo "Setting up SSH keys for $USERNAME..."
echo "Enter root password if asked.."
mkdir ~/.ssh
sudo chmod 700 ~/.ssh
sudo cp /root/.ssh/authorized_keys ~/.ssh/
sudo chmod 600 ~/.ssh/authorized_keys
echo "Done!"

## Add vim configuration file
cp conf/.vim ~/

# Install oh-my-fish for $USERNAME:
# -------------------
echo "Installing oh-my-fish.."
curl -L https://get.oh-my.fish | fish
# curl -L https://get.oh-my.fish > install
# fish install --path=/home/$USERNAME/.local/share/omf --config=/home/$USERNAME/.config/omf

# omf is installed. Choose an omf theme or leave it with the default theme.
# List all the omf themes.
# fish -c 'omf theme'

# Choose a theme and install it.
fish -c "omf install $OMFTHEME"

# Install fishmarks
#--------------------
echo "Installing fishmarks for $USERNAME..."
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish
