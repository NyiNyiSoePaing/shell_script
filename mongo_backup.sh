#!/bin/bash
 
######################################################################
##   MongoDB Database Backup Script 
######################################################################
 
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`
DB_BACKUP_PATH='/backups/mongodb'
MONGO_HOST='localhost'
MONGO_PORT='27017'
 
# If MongoDB is protected with a username password.
# Set AUTH_ENABLED to 1 
 
AUTH_ENABLED=0
MONGO_USER='test'
MONGO_PASSWD='test'
 
 
# Set DATABASE_NAMES to "ALL" to backup all databases.
# or specify databases names separated with space to backup 
# specific databases only.
 
DATABASE_NAMES='ALL'
#DATABASE_NAMES='mydb db2 newdb'
 
## Number of days to keep a local backup copy
BACKUP_RETAIN_DAYS=14 
 
######################################################################
 
mkdir -p ${DB_BACKUP_PATH}/${TODAY}
 
AUTH_PARAM="1"

 
if [ ${AUTH_ENABLED} -eq 1 ]; then
 AUTH_PARAM=" --username ${MONGO_USER} --password ${MONGO_PASSWD} "
fi
 
if [ ${DATABASE_NAMES} = "ALL" ]; then
 echo "You have choose to backup all databases"
 mongodump --uri="mongodb://localhost:27017"  --username ${MONGO_USER} --password ${MONGO_PASSWD} --out ${DB_BACKUP_PATH}/${TODAY}/
else
 echo "Running backup for selected databases"
 for DB_NAME in ${DATABASE_NAMES}
 do
 mongodump --uri="mongodb://localhost:27017" --db ${DB_NAME} --username ${MONGO_USER} --password ${MONGO_PASSWD} --out ${DB_BACKUP_PATH}/${TODAY}/
 done
fi
 
 
######## Remove backups older than {BACKUP_RETAIN_DAYS} days  ########
 
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi
 
######################### End of script ##############################