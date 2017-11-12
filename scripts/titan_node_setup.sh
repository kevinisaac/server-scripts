#!/bin/bash

# This script contains the instructions and command to setup a full stack
# titan graph server with rexster, cassandra and elasticsearch.

# Steps:
# ------
# 1.Install JDK.
# 1.Download and configure cassandra cluster.
# 2.Download and configure elasticsearch.
# 3.Download and configure rexster and titan.
# 4.Daemonize cassandra, elasticsearch and rexster.

# Step 1:
# -------
# Install the JDK from the Debian official repository. 
# Oracle JDk is not in the repository insted openJDK is there.
sudo apt-get install openjdk-7-jdk

# Step 2:
# -------
# Download the cassandra .tar.gz file from the offcial website and extract it.
mkdir Softwares
cd Softwares
wget http://archive.apache.org/dist/cassandra/2.0.8/apache-cassandra-2.0.8-bin.tar.gz
tar -xzvf apache-cassandra-2.0.8-bin.tar.gz

# Create the necessary directories
cd
mkdir -p conf/titan/cassandra logs/titan/cassandra scripts/titan/cassandra db/cassandra/data

# Copy the configuration files `cassandra.yaml` and `log4j-server.properties`
# from the cloned git repo to the user home's `conf/titan/cassandra` directory.
cd freeth-conf/conf/titan/cassandra/
cp cassandra.yaml log4j-server.properties ~/conf/titan/cassandra

# Make the necessary changes in the configuration files and copy it to the
# cassandra's home directory(~/Softwares/apache-cassandra-2.0.8-bin.tar.gz).

# Step 3:
# -------
# Download the elasticsearch .tar.gz file from the elasticsearch's official website
# and extract it.
cd ~/Softwares
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.2.1.tar.gz
tar -xzvf elasticsearch-1.2.1.tar.gz

# Create the necessary directories.
cd
mkdir -p conf/titan/elasticsearch logs/titan/elasticsearch scripts/titan/elasticsearch

# Copy the configuration files `elasticsearch.yml` and `logging.yml` from the
# cloned git repository to the user home's `conf/titan/elasticsearch` directory. 
cd freeth-conf/conf/titan/elasticsearch
cp elasticsearch.yml logging.yml ~/conf/titan/elasticsearch

# Make the necessary changes in the configuration files and copy it to the
# elasticsearch's home directory(~/Softwares/elasticsearch-1.2.1.tar.gz).

# Step 4:
# -------
# Download titan and rexster from their official website, extract them and 
# copy the titan jar file into rexster.
cd ~/Softwares
wget http://s3.thinkaurelius.com/downloads/titan/titan-0.5.4-hadoop1.zip
unzip titan-0.5.4-hadoop1.zip

wget http://tinkerpop.com/downloads/rexster/rexster-server-2.5.0.zip
unzip rexster-server-2.5.0.zip

mkdir rexster-server-2.5.0/ext/titan
cp titan-0.5.4-hadoop1/lib/*.* rexster-server-2.5.0/ext/titan

# Remove the lucene core library from rexster as it is required by neo4j.
rm rexster-server-2.5.0/lib/lucene-core-3.6.2.jar

# Copy the files `rexster.xml`, `log4j.properties` and `rexster.sh` from the 
# git repo to the user home's `conf/titan/rexster` directory.
cd 
mkdir -p conf/titan/rexster logs/titan/rexster scripts/titan/rexster
cd freeth-conf/conf/titan/rexster
cp rexster.xml log4j.properties rexster.sh ~/conf/titan/rexster

# Make the necessary changes in the configuration files and copy it to the
# respective folders in rexster's home directory(~/Softwares/rexster-server-2.5.0.zip).

# Step 5:
# -------
# Copy all the daemonization scripts of cassandra, elasticsearch and rexster to
# the `conf/systemd` directory.
mkdir ~/conf/systemd
cd ~/freeth-conf/conf/systemd
cp cassandra.service elasticsearch.service rexster.service ~/conf/systemd

# Make the necessary changes and copy it to the `/etc/systemd/system` directory.
cd ~/conf/systemd
sudo cp cassandra.service elasticsearch.service rexster.service /etc/systemd/system/

# Enable the services at startup but do not start the service until you are 
# sure that all the configurations are made.
sudo systemctl enable cassandra.service elasticsearch.service rexster.service

# After all the configurations are mode, reload the systemd daemon and 
# start the services.
# Make sure to add the necessary firewall rules for cassandra to communicate 
# to the cluster.


# That is it. Thank you! Have a nice day!
