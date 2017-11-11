#!/bin/bash

############################################################################
# The TITAN_HOME variable indicates where is the Titan/Cassandra instalation
# Change the variable below
############################################################################
 
TITAN_HOME=/home/freeth/Softwares/apache-cassandra-2.0.8
 
############################################################################
TITAN_DATA=/home/freeth/db/cassandra/data
TITAN_BACKUP=${TITAN_HOME}/backup
 
# Test if keyspace parameter was typed
if [ "${1}" == "" ]
then
   echo "Use: ${0} <snapshot keyspace> [destination keyspace]"
   echo
   echo "Existing snapshots"
   echo "------------------"
   for a in `ls ${TITAN_BACKUP}|grep -v @`
   do
      echo $a: `ls ${TITAN_BACKUP}/${a}/edgestore`
   done
   exit 1
fi
 
# Test if Titan service is down
if [ `ps -ef|grep titan1|grep -v grep | wc -l` -gt 0 ]
then
   echo "#######################################################"
   echo "#  Turn off the Titan before run the restore process  #"
   echo "#######################################################"
   echo
   ps -ef|grep titan|grep -v grep|cut -c1-120
   exit 1
fi
 
# Find existing snapshot of keyspace
SNAPSHOT=`ls ${TITAN_BACKUP}/${1}/edgestore`
# Test if snapshot of keyspace exists
if [ "$SNAPSHOT" == "" ]
then
   echo "No snapshots for informed keyspace"
   exit 1
fi
 
echo "Found snapshot: ${SNAPSHOT}"
 
# Test if the keyspace already exists
SOURCEKEYSPACE="$1"
TARGETKEYSPACE="$2"
if [ "$TARGETKEYSPACE" == "" ]
then
   TARGETKEYSPACE="$1"
fi
 
if [ -d "${TITAN_DATA}/${TARGETKEYSPACE}" ]
then
   read -p "Target keyspace ${TARGETKEYSPACE} alread exists. Do you want override? [y/n]: " typed
   response=`echo "$typed"|cut -c1-1|tr a-z A-Z`
   if [ "$response" != "Y" ]
   then
      exit
   fi
   # Move active keyspace to backup folder
   echo "${TITAN_DATA}/${TARGETKEYSPACE} saved in ${TITAN_BACKUP}/${TARGETKEYSPACE}@restored_"`date +"%d-%m-%Y_%H-%m"`
   mv    ${TITAN_DATA}/${TARGETKEYSPACE}          ${TITAN_BACKUP}/${TARGETKEYSPACE}@restored_`date +"%d-%m-%Y_%H-%m"`
fi
 
# Do restore
echo "Restoring ${TARGETKEYSPACE} from ${TITAN_BACKUP}/${SOURCEKEYSPACE}"
mkdir ${TITAN_DATA}/${TARGETKEYSPACE}
for a in `find ${TITAN_BACKUP}/${SOURCEKEYSPACE} -name "${SNAPSHOT}"`
do
   DIRNAME=`dirname $a`
   TABLE=`basename ${DIRNAME}`
   echo
   echo "Creating $TABLE:"
   mkdir ${TITAN_DATA}/${TARGETKEYSPACE}/${TABLE}
    
   for f in `ls $a`
   do
      FROM=${a}/${f}
      TO=${TITAN_DATA}/${TARGETKEYSPACE}/${TABLE}/`echo $f | sed -e "s/${SOURCEKEYSPACE}/${TARGETKEYSPACE}/"`
      echo "Processing ${f} file..."
      cp ${FROM} ${TO}
   done
done
