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

# After completing step 1 & 2, login as the new user and move on to Step 3.

# Step 3:
# -------
# Update, Upgrade and install all the required packages.

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ssh vim wget unzip tar git curl ufw

# Install fish:
# -------------
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_8.0/ /' | sudo tee -a /etc/apt/sources.list.d/fish.list
wget -qO - http://download.opensuse.org/repositories/shells:fish:release:2/Debian_8.0/Release.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install fish
sudo usermod freeth -s /usr/bin/fish

# Install oh-my-fish:
# -------------------
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish

# omf is installed. Choose an omf theme or leave it with the default theme.
# List all the omf themes.
fish -c 'omf theme'

# Choose a theme and install it.
fish -c 'omf install scorphish'

# Step 4:
# -------
# Block all the ports except 22.
# By default, ufw blocks incoming to all the ports.
# Allow access to ssh port. If the default port for ssh is changed,
# then replace 'ssh' with the respective port number in the command.
# Example: sudo ufw allow port_number/tcp
sudo ufw allow ssh/tcp

# To make sure if the rule is added, use,
sudo ufw show added

# The above command will list all the rules that are added.
# Enable ufw using,
sudo ufw enable

# This will start the ufw service and enab les it in startup.
# Make sure ufw service is running using
sudo service ufw status

# Don't exit your user session, until you make sure that the port 22 is open.
# To check that, open a new terminal and try to login.
# If it doesn't work, then there is something is wrong in your rule. 

# Step 5:
# -------
# Create directories to store configuration files and scripts.
mkdir conf scripts logs

# Clone the freeth configuration remote repository.
# git clone https://bitbucket.org/freeth-in/freeth-conf.git 

# Step 6:
# -------
# Configure the server's time.
sudo dpkg-reconfigure tzdata

# Select the required time zone. UTC is adviceable.
# Install ntp daemon
sudo apt-get install ntp

# Step 7:
# -------
# Install zabbix agent to collect monitoring metrics about the server.
sudo apt-get install zabbix-agent


# Thats it for the initial setup of server. This setup is common for every machines# Next steps depends on the server's role. 
# Follow the instructions in the files that is specific for the server's role.

# Thank you! Have a nice day!.
