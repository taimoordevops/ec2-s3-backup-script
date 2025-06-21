#!/bin/bash

LOGFILE="/home/ec2-user/backup-log.txt"
echo "[$(date)] Backup started" >> $LOGFILE

timestamp=$(date +%Y%m%d_%H%M%S)
filename="backup_${timestamp}.txt"
echo "This is a backup file created on ${timestamp}" > $filename

if aws s3 cp $filename s3://day3-bucket-taimoor/; then
  echo "[$(date)] Backup completed successfully ✅" >> $LOGFILE
else
  echo "[$(date)] Backup failed ❌" >> $LOGFILE
fi

