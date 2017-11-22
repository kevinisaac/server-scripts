#!/bin/bash

SERVER_IP=`ip route get 1 | awk '{print $NF;exit}'`
USERNAME=`whoami`
DEFAULT_OMFTHEME='bobthefish'
read -p "Enter the omf theme you want to use for $USERNAME ($DEFAULT_OMFTHEME): " OMFTHEME
OMFTHEME=${OMFTHEME:-$DEFAULT_OMFTHEME}

cd ~
echo "Cloning kevinisaac/server-scripts"
git clone https://github.com/kevinisaac/server-scripts.git

# Install oh-my-fish for $USERNAME:
# -------------------
echo "Installing oh-my-fish.."
curl -L https://get.oh-my.fish | fish
# curl -L https://get.oh-my.fish > install
# fish install --path=/home/$USERNAME/.local/share/omf --config=/home/$USERNAME/.config/omf

# Choose a theme and install it.
fish -c "omf install $OMFTHEME"

# Install fishmarks
#--------------------
echo "Installing fishmarks for $USERNAME..."
curl -L https://github.com/techwizrd/fishmarks/raw/master/install.fish | fish

echo "Owning home directory..."
sudo chown $USERNAME:$USERNAME ~ -R

echo "Congratulations.. Setup for $USERNAME is done!"
echo "You can now exit login to the server as: ssh $USERNAME@$SERVER_IP"
