#!/bin/bash

# This script contains the instructions and the commands to push
# the application from the local repository to the remote repository.

# WARNING: 
# --------
# Exceute the commands given in this file, only in the 
# local machine which has the local repository of the application.
# Do not run it in the server.

# If you are in this file means that you have completed the steps given in 
# `webserver_node_setup.sh` file. If not, do not continue.

# Steps:
# ------
# 1.Add the remote URL to the git config variable.
# 2.Push the application from local to remote repository.

# Step 1:
# -------
# Add the remote bare git repository to the to the local git config,
# using `git remote` command.
# Make sure you are executing the commanf from inside the repository directory.

# Usage:
# ------
# git remote add <local_name> ssh://freeth@<remote_ip_or_domain>/home/freeth/freeth/freeth.git

# To check if the URL is add to git config, run
# 	git config -l

# Step 2:
# -------
# Checkout to the branch which has to be pushed using
#	git checkout <branch>
# Now, push the branch to remote master branch
#	git push <local_name> master
# Don't try to push to any other branch than master, because the remote 
# repository itself will not allow you to push as we have enabled a hook.


# Local repository is pushed to the remote. Now, you are good to move on with
# the instructions given in `appserver_setup.sh`.

# Thats it. Thank you!. Have a nice day!.
