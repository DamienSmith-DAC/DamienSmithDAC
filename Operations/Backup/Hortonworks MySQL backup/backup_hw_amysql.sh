#!/bin/bash
####################################################################################################
# Back up script for Hortonworks meta store MySQL databases
# backup shell script to be run by OS user mysqlbackup
# MySQL back up user is backup_admin
#
####################################################################################################
# Version: 1.0
# Developer: Indu N
####################################################################################################
# set up local variables
BACKUP_DIR="/db/hw_mysql_backup"
# Password for user is read from my.cnf file
MYSQL_USER="backup_admin"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump
MYSQLDUMP_CONFIG="/db/hw_mysql_backup/config"
DAY=$(date +"%Y%m%d")
EMAIL_ADDRESS="indu.neelakandan@treasury.nsw.gov.au"

#create directory for today
mkdir $BACKUP_DIR/HW_MYSQL_BACKUP$DAY


#get all database names except information schema and performance schema
databases=`$MYSQL --user=$MYSQL_USER -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|ndbinfo)"`

# now loop through the databases and generate sql file for each database
for db in $databases;
do
#`$MYSQLDUMP --user=$MYSQL_USER --databases $db > /$BACKUP_DIR/HW_MYSQL_BACKUP$DAY/$db.sql`

 `$MYSQLDUMP --user=$MYSQL_USER --routines --events --log_error=/$BACKUP_DIR/HW_MYSQL_BACKUP$DAY/$db.log --databases $db > /$BACKUP_DIR/HW_MYSQL_BACKUP$DAY/$db.sql`
done
