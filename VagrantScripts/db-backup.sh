#!/bin/bash
DATE=$(date +%s)

## Check for Database backup folder
if [ ! -d "/vagrant/Backups" ]; then
  echo "Directory doesn't exist, making Backups Folder"
  mkdir /vagrant/Backups
else
  echo "Backup folder exists, adding in database backup file"
fi

##Check for mysql installation
if ! mysql --version; then
  echo "MySQL not installed, existing"
  exit
else
  echo "MySQL database found, beginning backup."
fi

## Backup all current Databases

mysqldump --all-databases > /vagrant/Backups/${DATE}-dbbackup.sql
## Verify file is saved in correct folder