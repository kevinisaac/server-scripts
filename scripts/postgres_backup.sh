# Note: Works only for a single database

LOG_FILE='/var/log/postgres_backup.log'
echo "Postgres Backup script started on `date`" | tee -a $LOG_FILE

# USERNAME=postgres
# PASSWORD=todo
# DBHOST=localhost
DBNAMES="listino"
BACKUP_DIR="/var/backups/postgres"
TIMESTAMP=`date +%d-%m-%Y_%H-%M-%S`
BACKUP_FILE="$BACKUP_DIR/$DBNAMES_$TIMESTAMP.sql"

CREATE_DATABASE=true

# 1. Create the backup directory
mkdir -p $BACKUP_DIR

# 2. Backup the database
echo "Backup of database(s) \'$DBNAMES\' started..." | tee -a $LOG_FILE
pg_dump $DBNAME > $BACKUP_DIR
echo "Backup of database(s) \'$DBNAMES\' completed on `date`!" | tee -a $LOG_FILE
