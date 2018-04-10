#!/bin/bash
####################################################################################################
# Back up script for Hortonworks meta store MySQL databases
# backup shell script to be run by OS user mysqlbackup
# MySQL back up user is backup_admin
#
####################################################################################################
# Version: 1.1
# Developer: Indu N
####################################################################################################
# Revision History
# Version 1: First cut
# Version 1.1: Changed email address to dacsupport@treasury.nsw.gov.au
####################################################################################################
# set up local variables
BACKUP_DIR="/db/hw_mysql_backup"
# Password for user is read from my.cnf file
MYSQL_USER="backup_admin"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump
MYSQLDUMP_CONFIG="/db/hw_mysql_backup/config"
DAY=$(date +"%a%Y%m%d")
TODAYS_DIR=HW_MYSQL_$DAY
EMAIL_ADDRESS="dacsupport@treasury.nsw.gov.au"
REMOTE_HOST="10.74.12.108"
REMOTE_DIR="/analytics/hw_mysql_backup"

#create directory for today
mkdir $BACKUP_DIR/$TODAYS_DIR


#get all database names except information schema and performance schema
databases=`$MYSQL --user=$MYSQL_USER -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|ndbinfo)"`

# now loop through the databases and generate sql file for each database
for db in $databases;
do
#`$MYSQLDUMP --user=$MYSQL_USER --databases $db > /$BACKUP_DIR/$TODAYS_DIR/$db.sql`

 `$MYSQLDUMP --user=$MYSQL_USER --routines --events --log_error=/$BACKUP_DIR/$TODAYS_DIR/$db.log --databases $db > /$BACKUP_DIR/$TODAYS_DIR/$db.sql`
done

# Copy files to backup-master01
rsync --remove-source-files -avzhe ssh $BACKUP_DIR/$TODAYS_DIR root@$REMOTE_HOST:$REMOTE_DIR > /$BACKUP_DIR/HW_MYSQL_$DAY.log

# Delete empty directory from source
rmdir /$BACKUP_DIR/$TODAYS_DIR
