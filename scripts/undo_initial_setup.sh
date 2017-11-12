DEFAULT_USERNAME='zephony'
# DEFAULT_GROUPNAME='dev'

read -p "Enter the name of user to delete ($DEFAULT_USERNAME): " USERNAME
USERNAME=${USERNAME:-$DEFAULT_USERNAME}
# read -p "Enter the name of group to delete ($DEFAULT_GROUPNAME): " GROUPNAME
# GROUPNAME=${GROUPNAME:-$DEFAULT_GROUPNAME}

userdel $USERNAME
groupdel $USERNAME
rm /home/$USERNAME -vr
rm /root/.config/fish -vr
rm /root/.vim -vr
