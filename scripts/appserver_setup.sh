#!/bin/bash

# This script contains the instructions and commands to setup the application
# server and to configure nginx to reverse proxy the request to the appserver.

# Steps:
# ------
# 1.Install all the system wide packages required for the application.
# 2.Create a virtual environment and install all the required tools for the application to run inside it.
# 3.Configure postgresql database, as per the application requirements.
# 4.Configure gunicorn application server.
# 5.Configure celery task queue
# 6.Configure nginx to reverse proxy the request to the application server.
# 7.Daemonize and start gunicorn and celery.

# Either, you follow the instructions given here and do everything manually
# Or, just execute the file using,
#         ./webserver_node_setup.sh
# Make sure the file has executable permission.

# Step 1:
# -------
# Install the system wide dependencies for the application to run.
sudo apt-get install gcc python3-dev python3.4-venv libffi6 libffi-dev libjpeg-dev libpq-dev postgresql postgresql-client rabbitmq-server

# gcc: to compile c libraries
# python3-dev: includes all the development tools for Python 3.4
# python3.4-venv: to create Python 3.4 virtual environment
# libffi6, libffi-dev, libjpeg-dev, libpq-dev: application library dependencies
# postgresql, postgresql-client: application database
# rabbitmq-server: message broker required by Celery task queue 

# Step 2:
# -------
# Create a virtual environment and install all the libraries and tools 
# required for the application to run.
cd /var/www/freeth.in
pyvenv-3.4 venv
. venv/bin/activate

# New virtual environment is created and is activated.
# Now install all the required tools inside the environment.
# `requirements.txt` file in the application folder contains all the required
# packages. Install it using `pip` as follows
pip install -r requirements.txt

# Step 3:
# -------
# Configure postgresql as per the application requirements.
# Create a user called `freeth` and a database called `Freeth`.
# By default, postgrsql server creates a user called 'postgres'.
# Login in to the `postgres` user and create new user.
# 	sudo -i -u postgres
# It will ask for the password, just type your sudo password.
# Now you are logged in as `postgres` user. Create the new user using
# 	createuser --interactive
# Or, execute the command as the `postgres` user from the current user shell.
sudo su -c "createuser --interactive" postgres

# It will ask for the new user's name and some few other questions.
# Make sure you give administrative privilege to the new user.
# A new database with the new user's name will be created by default.
# But create a database with name that application uses using,
createdb Freeth

# Now a new database is created. Exit the postgres user and try to login
# as new user to the new database, using,
#	 psql -d Freeth
# Exit the psql shell using `\q`

# Step 4:
# -------
# Configure the gunicorn server.
# The configuration file for the gunicorn server is in `freeth-conf/conf/gunicorn` 
# directory. 
# The configuration file named `gunicorn.conf.py` has been written based on our 
# server requirements. I would recommend to change the content of the file only if # it is necessary. Once the content in the file is changed, do not forget to push
# the changes to the online repository. 
# Copy the configuration file from the local git repository and place it in the 
# users home directory because the repository will be deleted after the server is 
# setup.
cd
mkdir conf/gunicorn logs/gunicorn scripts/gunicorn
cp freeth-conf/conf/gunicorn/gunicorn.conf.py conf/gunicorn/

# Edit the configuration file in `conf/gunicorn` directory as per the server 
# requirements. Change the value of the variables like bind address, application 
# environment.

# Step 5:
# -------
# Configure the celery task queue.
# The same instructions of gunicorn is applicable for celery too.
# The configuration file is in `freeth-conf/conf/celery` directory. Copy it to 
# `conf/celery` directory.
mkdir conf/celery logs/celery scripts/celery
cp freeth-conf/conf/celery/celery.conf conf/celery

# Edit the configuration file in `conf/celery` directory as per the server 
# requirements. Change the value of the variables like number of nodes, 
# application environment.

# Step 6:
# -------
# Configure nginx as per the server infrastructure.
# Sample nginx configuration file is given in the repository directory under
# `nginx` directory with some basic static file serving, load balancing and 
# reverse proxying.
mkdir conf/nginx logs/nginx scripts/nginx
cp freeth-conf/conf/nginx/nginx.conf conf/nginx

# Edit the nginx.conf file and copy it to `/etc/nginx/` directory.
# Then restart nginx for changes to take effect.

# Step 7:
# -------
# Daemonize gunicorn and celery.
# systemd is used to daemonize process. The systemd unit files for gunicorn and 
# celery is in the configuration repository's `conf/systemd` directory.
# Just copy the files from repository directory to local `conf/systemd` directory,
# make changes and copy it to `/etc/systemd/system/` directory
mkdir conf/systemd
cp freeth-conf/conf/systemd/gunicorn.service freeth-conf/conf/systemd/celery.service conf/systemd
sudo cp conf/systemd/gunicorn.service conf/systemd/celery.service /etc/systemd/system/

# Enable the services, reload systemd daemon and start the services
sudo systemctl enable gunicorn.service celery.service
sudo systemctl daemon-reload
sudo systemctl start gunicorn.service celery.service

# View the status of the services using
# 	sudo systemctl status gunicorn.service celery.service
# If something goes wrong, check the log files to figure out the issues.


# A single web server node is setup and configured. Delete the cloned repository
sudo rm -r freeth-conf/


# That is it. Thank You! Have a nice day!
