#!/bin/bash

SERVER_IP=`ip route get 1 | awk '{print $NF;exit}'`
USERNAME=`whoami`
DEFAULT_OMFTHEME='bobthefish'
read -p "Enter the omf theme you want to use for $USERNAME ($DEFAULT_OMFTHEME): " OMFTHEME
OMFTHEME=${OMFTHEME:-$DEFAULT_OMFTHEME}

## Set up ssh keys
echo "Setting up SSH keys for $USERNAME..."
mkdir ~/.ssh
sudo chmod 700 ~/.ssh
sudo cp /root/.ssh/authorized_keys ~/.ssh/
sudo chmod 600 ~/.ssh/authorized_keys
echo "Restarting ssh server..."
systemctl restart ssh
echo "Done!"

## Add vim configuration file
cp conf/.vim ~/ -r

cd ~
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

echo "Congratulations.. Setup for $USERNAME is done!"
echo "You can now exit login to the server as: ssh $USERNAME@$SERVER_IP"
