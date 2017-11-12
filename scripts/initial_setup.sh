#!/bin/bash
# Thing to do in every server machine
# -----------------------------------

# 1. Create a new user named freeth.
# 2. Disable root user ssh access.
# 3. Login as new user and install the necessary packages. 
# 4. Block access to all the ports except 22(ssh).
# 5. Create necessary directories. 
# 6. Configure time and install ntp.
# 7. Install Zabbix agent.

# Either, you follow the instructions given here and do everything manually
# Or, just execute the file using,
#         ./initial_setup.sh
# Make sure the file has executable permission.

# Steps 1 & 2:
# ------------
# For steps 1 & 2, follow the instructions in, 
# https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-14-04


SERVER_IP=`ip route get 1 | awk '{print $NF;exit}'`
DEFAULT_USERNAME='zephony'
DEFAULT_GROUPNAME='dev'
DEFAULT_OMFTHEME='bobthefish'
DEFAULT_ROOT_OMFTHEME='batman'
DEFAULT_PACKAGES='fish'

## Create users and groups
read -p "Enter the name of the user ($DEFAULT_USERNAME): " USERNAME
USERNAME=${USERNAME:-DEFAULT_USERNAME}
read -p "Enter the developers group name ($DEFAULT_GROUPNAME): " GROUPNAME
GROUPNAME=${GROUPNAME:-DEFAULT_GROUPNAME}
read -p "Enter the omf theme you want to use for root ($DEFAULT_ROOT_OMFTHEME): " ROOT_OMFTHEME
ROOT_OMFTHEME=${ROOT_OMFTHEME:-DEFAULT_ROOT_OMFTHEME}
read -p "Enter the omf theme you want to use for $USERNAME ($DEFAULT_OMFTHEME): " OMFTHEME
OMFTHEME=${OMFTHEME:-DEFAULT_OMFTHEME}


# Create group and user
groupadd $GROUPNAME
useradd $USERNAME -G sudo,$GROUPNAME -m


# Set passwords for root and $USERNAME
echo "Enter root password below.."
passwd
# echo "Enter password for $USERNAME below.."
echo "Enter password for $USERNAME below.."
passwd $USERNAME

# Update, Upgrade and install all the required packages.
apt-get update
apt-get upgrade
apt-get install $DEFAULT_PACKAGES

# Install oh-my-fish for root user:
# -------------------
echo "Installing oh-my-fish for root user..."
# curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
curl -L https://get.oh-my.fish | fish

# omf is installed. Choose an omf theme or leave it with the default theme.
# List all the omf themes.
# fish -c 'omf theme'

# Choose a theme and install it.
fish -c "omf install $ROOT_OMFTHEME"

# Add vim configuration file to root user
sudo cp conf/.vim /root/

# Block all the ports except 22.
# By default, ufw blocks incoming to all the ports.
# Allow access to ssh port. If the default port for ssh is changed,
# then replace 'ssh' with the respective port number in the command.
# Example: sudo ufw allow port_number/tcp
echo "Setting up UFW (firewall)..."
ufw allow ssh/tcp
# Enable ufw using,

# To make sure if the rule is added, use,
# sudo ufw show added

sudo ufw enable
echo "Only allowed port now is 22."

# This will start the ufw service and enables it in startup.
# Make sure ufw service is running using
# sudo service ufw status
echo "Done setting up UFW (firewall)!"

# Don't exit your user session, until you make sure that the port 22 is open.
# To check that, open a new terminal and try to login.
# If it doesn't work, then there is something is wrong in your rule. 

# Create directories to store configuration files and scripts.
# mkdir conf scripts logs

# Clone the freeth configuration remote repository.
# git clone https://bitbucket.org/freeth-in/freeth-conf.git 

# Step 6:
# -------
# Configure the server's time.
# sudo dpkg-reconfigure tzdata

# Select the required time zone. UTC is adviceable.
# Install ntp daemon
# sudo apt-get install ntp

# Step 7:
# -------
# Install zabbix agent to collect monitoring metrics about the server.
# sudo apt-get install zabbix-agent

# Change to $USERNAME
# echo "Changing to user '$USERNAME'..."
# su - $USERNAME

# Set up SSH key for $USERNAME - Assuming the key is setup for the root account
su $USERNAME -c "./_initial_user_setup.sh $USERNAME $OMFTHEME"


echo "Changing default shell to fish for root and $USERNAME..."
sudo usermod root -s /usr/bin/fish
sudo usermod $USERNAME -s /usr/bin/fish
echo "Done!"

## Set up SSH server
echo "Configuring SSH server..."
vim /etc/ssh/sshd_config
echo "Restarting ssh server..."
systemctl restart ssh

echo "Congratulations.. Your initial server setup is done!"
echo "You can now exit login to the server as: ssh $USERNAME@$SERVER_IP"

# Thats it for the initial setup of server. This setup is common for every machine
# Next steps depends on the server's role. 
# Follow the instructions in the files that is specific for the server's role.

# Thank you! Have a nice day!.
