#!/bin/bash

set -e

BUCKET="day3-bucket-taimoor"
BACKUP_SRC="/home/ec2-user/important_data"
TMP_DIR="/tmp/s3_backup"
LOGFILE="/home/ec2-user/ec2-s3-backup-script/backup-log.txt"

mkdir -p "$TMP_DIR"

timestamp=$(date +%Y%m%d_%H%M%S)
filename="backup_${timestamp}.tar.gz"
filepath="$TMP_DIR/$filename"

echo "📦 Creating compressed backup..."
tar -czf "$filepath" -C "$BACKUP_SRC" . || { echo "❌ Backup failed!"; exit 1; }

echo "⬆️  Uploading $filename to S3..."
aws s3 cp "$filepath" "s3://$BUCKET/" || { echo "❌ Upload failed!"; exit 1; }

echo "✅ Backup complete!"

# Log the successful backup
echo "$(date) - Backup $filename uploaded to S3." >> "$LOGFILE"

