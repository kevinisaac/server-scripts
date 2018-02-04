#!/bin/bash

DATETIME=`date +%y-%m-%d_%H-%M-%S`
SRC=$1
DST=$2
GIVENNAME=$3

showhelp() {
    echo "\n\n############################################"
    echo "# bkupscript.sh                            #"
    echo "############################################"
    echo "\nThis script will backup files/folders into a single compressed file and will store it in the current folder."
    echo "In order to work, this script needs the following three parameters in the listed order: "
    echo "\t- The full path for the folder or file you want to backup."
    echo "\t- The name of the Space where you want to store the backup at."
    echo "\t- The name for the backup file (timestamp will be added to the beginning of the filename)\n"
    echo "Example: sh bckupscript.sh ./testdir testSpace backupdata\n"<^>
}

tarandzip() {
    echo "\n##### Gathering files #####\n"
      if tar -czvf $GIVENNAME-$DATETIME.tar.gz $SRC; then
        echo "\n##### Done gathering files #####\n"
        return 0
    else
        echo "\n##### Failed to gather files #####\n"
        return 1
    fi
}
