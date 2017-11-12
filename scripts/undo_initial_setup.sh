read -p "Enter the name of user to delete: " USERNAME
read -p "Enter the name of group to delete: " GROUPNAME

userdel $USERNAME
groupdel $USERNAME
rm /home/$USERNAME -vr
rm /root/.config/fish -vr
rm /root/.vim -vr
