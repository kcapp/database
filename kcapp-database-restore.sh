#!/bin/bash
# Script to get latest, and restore a database backup from file
# Make sure to set all the below local variables

HOST=localhost
REMOTE_DIR=backup/kcapp
LOCAL_DIR=/home/thord/Backup/sql/kcapp

LOCAL_DB=localhost
LOCAL_DB_USER=kcapp
LOCAL_DB_PASSWORD=abcd1234

DATE=`date +%Y-%m-%d`
FILENAME="kcapp-$DATE.sql"

if [ ! -z $1 ] ; then
    echo "Generating latest dump from $HOST"
    ssh $HOST /usr/local/bin/kcapp-backup
fi

echo "Getting latest dump from $HOST"
scp -pq $HOST:$REMOTE_DIR/latest.sql.gz $LOCAL_DIR/$FILENAME.gz

echo "Extracting $FILENAME.gz"
gzip -fd $FILENAME.gz

echo "Inserting all data"
mysqlsh -u $LOCAL_DB_USER -p$LOCAL_DB_PASSWORD $LOCAL_DB:3306/kcapp --sql < $FILENAME
