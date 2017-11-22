DEFAULT_USERNAME='zephony'
read -p "Enter the name of the user ($DEFAULT_USERNAME): " USERNAMES
USERNAME=${USERNAMES:-$DEFAULT_USERNAME}

install_user() {
    echo $1
}

for user in $USERNAMES
do
    install_user $user
done
