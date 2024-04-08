#!/bin/bash
#----------------------------------------
# OPTIONS
#----------------------------------------
USER='root'       # MySQL User
PASSWORD='password' # MySQL Password
DAYS_TO_KEEP=7    # 0 to keep forever
GZIP=1            # 1 = Compress
BACKUP_PATH='/root/backup/mysql' #backup directory
DBHOST=1.1.1.1 #database host ip
DBPORT=3306      #database port no
#----------------------------------------

# Create the backup folder
if [ ! -d $BACKUP_PATH ]; then
  mkdir -p $BACKUP_PATH
fi

# Get list of database names
databases=`mysql -u $USER -p$PASSWORD --host=$DBHOST --port=$DBPORT -e "SHOW DATABASES;" | tr -d "|" | grep -v Database`

for db in $databases; do

  if [ $db == 'information_schema' ] || [ $db == 'performance_schema' ] || [ $db == 'mysql' ] || [ $db == 'sys' ]; then
    echo "Skipping database: $db"
    continue
  fi

  date=$(date -I)
  if [ "$GZIP" -eq 0 ] ; then
    echo "Backing up database: $db without compression"
    mysqldump -u $USER -p$PASSWORD --host=$DBHOST --port=$DBPORT --databases $db > $BACKUP_PATH/$date-$db.sql
  else
    echo "Backing up database: $db with compression"
    mysqldump -u $USER -p$PASSWORD --host=$DBHOST --port=$DBPORT --databases $db | gzip -c > $BACKUP_PATH/$date-$db.gz
  fi
done

# Delete old backups
if [ "$DAYS_TO_KEEP" -gt 0 ] ; then
  echo "Deleting backups older than $DAYS_TO_KEEP days"
  find $BACKUP_PATH/* -mtime +$DAYS_TO_KEEP -exec rm {} \;
fi
# Permission Backups
echo "Set Permission on backup files"
find $BACKUP_PATH  -type f -exec chmod 600 {} \;
echo "Set Permission on script"
chmod 700 /root/mysql_auto_backup.sh