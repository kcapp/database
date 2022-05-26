#!/bin/bash
# Script to backup database schema to file
# Make sure to set the correct $BACKUP_FOLDER, $DATABASE, $USERNAME and $PASSWORD
#
# Can be setup to run via cron like:
# 0 06,18 * * * /usr/local/bin/kcapp-backup

BACKUP_FOLDER="<BACKUP_FOLDER>"
BACKUP_FILE="kcapp-$(date +%Y-%m-%dT%H%M).sql.gz"
DATABASE="<DATABASE_HOSTNAME>"
USERNAME="kcapp"
PASSWORD="abcd1234"
SCHEMA="kcapp odds"

echo "Dumping $SCHEMA to $BACKUP_FOLDER/$BACKUP_FILE"
mysqldump --complete-insert --set-gtid-purged=OFF --add-drop-trigger --user=$USERNAME --host=$DATABASE --port=3306 -p$PASSWORD --databases $SCHEMA | gzip -9 > "$BACKUP_FOLDER/$BACKUP_FILE"

echo "Adding latest.sql.gz file"
cp $BACKUP_FOLDER/$BACKUP_FILE $BACKUP_FOLDER/latest.sql.gz

echo "Deleting files older than 7 days"
find $BACKUP_FOLDER -type f -mtime +7 -name '*.sql.gz' -delete
