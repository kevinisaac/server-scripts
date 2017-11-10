#!/bin/bash
############################################################################
# The TITAN_HOME variable indicates where is the Titan/Cassandra instalation
# Change the variable below
############################################################################
 
TITAN_HOME=/home/freeth/Softwares/apache-cassandra-2.0.8 

############################################################################
TITAN_DATA=/home/freeth/db/cassandra/data
TITAN_BACKUP=${TITAN_HOME}/backup
 
if [ "${1}" == "" ]
then
   echo "Use: ${0} <keyspace>"
   exit
fi
 
if [ ! -d "${TITAN_DATA}/${1}" ]
then
   echo "Keyspace ${1} not exists"
   exit
else
   # Clear old snapshots and create a new snapshot of cassandra
   ${TITAN_HOME}/bin/nodetool -h localhost -p 7199 clearsnapshot
   ${TITAN_HOME}/bin/nodetool -h localhost -p 7199 snapshot ${1}
 
   if [ ! -d "${TITAN_BACKUP}" ]
   then
      mkdir "${TITAN_BACKUP}"
   fi
 
   # Delete .old folder, if exist.
   if [ -d "${TITAN_BACKUP}/${1}.old" ]
   then
      rm -rf "${TITAN_BACKUP}/${1}.old"
   fi

   # Save the last backup as .old
   if [ -d "${TITAN_BACKUP}/${1}" ]
   then
      mv "${TITAN_BACKUP}/${1}" "${TITAN_BACKUP}/${1}.old"
   fi
 
   mkdir "${TITAN_BACKUP}/$(hostname)-${1}-$(date '+%d-%b-%Y')"
   cd ${TITAN_DATA}/${1}
   for a in `find . -name snapshots`
   do
       echo "Backuping ${a}..."
       cp -R ${a} ${TITAN_BACKUP}/$(hostname)-${1}-$(date '+%d-%b-%Y')/`echo $a | sed -e "s/\/snapshots//"`
   done
   rsync -ra ${TITAN_BACKUP}/ freeth@198.211.99.58:${TITAN_BACKUP}
   rm -r ${TITAN_BACKUP}
fi
