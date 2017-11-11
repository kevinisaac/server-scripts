#!/bin/bash

# This script contains the instructions and the commands to setup
# the web server node.

# 1.Install and start nginx(web server, reverse proxy and load balancer).
# 2.Open public access to port 80 in the firewall.
# 3.Set up the bare git repository and configure it.
# 4.Push the application from local repository to remote bare git repository.

# Either, you follow the instructions given here and do everything manually
# Or, just execute the file using,
#         ./webserver_node_setup.sh
# Make sure the file has executable permission.

# Step 1:
# -------
# Install and start nginx
# nginx is available in the debian apt repository.
# Install it from the debian official package repository, using
sudo apt-get install nginx

# nginx is installed and started automatically.
# To verify if nginx is running, run,
#	sudo service nginx status

# Step 2:
# -------
# Now, nginx is running but is not accessible to public.
# By default, nginx listens for clients in port 80.
# But, access to port 80 is block by the firewall.
# So, allow public access to port 80.
# To allow access, run the following command,
sudo ufw allow 80/tcp

# If you are using SSL for connection, allow access to port 443.
# Run the following command to open port 443,
#	sudo ufw allow 443/tcp

# Verify if the rules are added using
#	sudo ufw show added
# Or,
#	sudo ufw status verbose

# Step 3:
# -------
# Create a bare git repository for our application, and,
# configure it to strore the data in the working tree.
# Also, make the master branch as default and restrict permission for creating
# new branches.
mkdir freeth/freeth.git -p
cd freeth/freeth.git
git init --bare

# A new bare git repository is created without working tree.
# Next, Configure the repository to have a working tree in different location.
# Checkout master branch by default and deny creating new branches.
# Do so, by creating hooks `post-receive` and `post-update`
echo "#!/bin/bash
git --work-tree=/var/www/freeth.in --git-dir=/home/freeth/freeth/freeth.git checkout master -f" > hooks/post-receive

# Give executable permission to the `post-receive` hook.
chmod +x hooks/post-receive

# Verify that the executable permission is applied using
#	 ls -l hooks/post-receive
# Change the permission and ownership of the work-tree directory.
sudo chown freeth:freeth /var/www -R

# Add project description to the repository.
echo "freeth.in" > description

# Create a branch named 'master'
git branch master

# To Deny creating new branch, enable the `update` hook file.
cp hooks/update.sample hooks/update
git config --bool hooks.denycreatebranch true

# Check if the config is added using
#	git config -l

# Step 4:
# -------
# A bare git repository with seperate working tree directory is created for
# our application. Now, push the application from the local repository to 
# the newly created remote bare repository's master branch.
# For pushing data from local to remote repository, follow the instructions
# given in push_to_remote.sh file.


# After pushing the local repository to remote, follow the instructions
# in `appserver_setup.sh` file to setup the application server and its 
# related application.


# Thats it. Thank you!. Have a nice day!.
