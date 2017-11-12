# Set up the system to install and deploy a flask web server

DEFAULT_PACKAGES='nginx python3-pip virtualenv'
DEFAULT_DATABASE='postgresql'

# Ask which database to install - mysql, postgresql, mongodb

# Install the packages
apt-get install $DEFAULT_PACKAGES

