#!/usr/bin/bash
# BEGIN CONFIGURATION ==========================================================
BACKUP_DIR="/opt/mysql-backup/hourly/dump-files/"  # The directory in which you want backups placed
ZIP_DIR="/opt/mysql-backup/DBDUMP_ZIP/"  # The directory in which all dumpfiles stored in ZIP format
DUMP_MYSQL=true
MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PASSWD="hvdhjbvf hqwe"
# Construct Date
MONTH="month-$(date '+%m')_"
DAY="day-$(date '+%d')_"
HOUR="hour-$(date '+%H')_"
#MIN="min-$(date '+%M')_"
#SEC="sec-$(date '+%S')"
#Use the date construct
THE_DATE="$MONTH$DAY$HOUR"
MYSQL_PATH="$(which mysql)"
MYSQLDUMP_PATH="$(which mysqldump)"
FIND_PATH="$(which find)"
# END CONFIGURATION ============================================================
#Lets Get This Party Started
echo "Backup Started: $(date)"
# Create the backup dirs if they don't exist
  if [[ ! -d $BACKUP_DIR ]]
  then
  mkdir -p "$BACKUP_DIR"
  fi
# Create the ZIP dirs if they don't exist
  if [[ ! -d $ZIP_DIR ]]
  then
  mkdir -p "$ZIP_DIR"
  fi

 if [ "$DUMP_MYSQL" = "true" ]
  then
  mysqldump -u $MYSQL_USER -p2wsx1qaz  --databases database1 database2 database3 > $BACKUP_DIR$THE_DATE.sql
  cd $BACKUP_DIR
  zip $ZIP_DIR$THE_DATE.zip $THE_DATE.sql
 fi

cd $ZIP_DIR
find . -mtime 1 -delete
cd ~

cd $BACKUP_DIR
find . -mtime 1 -delete
cd ~

sshpass -p $MYSQL_PASSWD scp $ZIP_DIR$THE_DATE.zip  root@192.168.101.211:/opt/db-backup/

 echo "Backup is completed"
