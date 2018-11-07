#!/bin/sh

NOW=$(date '+%H:%M:%S')
DAY=$(date '+%Y-%m-%d')
MTH=$(date '+%Y-%m')
LOG=/tmp/mysqlbackup-$MTH.log
IP='10.74.31.105'
BKUPFILE=/db/mysql_backup/siradp-mysql-s01-$DAY.tar.gz

echo "[$DAY $NOW] bakcup started" >> $LOG
mysqldump --defaults-extra-file=/root/mysqlbackup/my.conf --all-databases | gzip -c | ssh $IP "cat > $BKUPFILE"
echo "[$DAY $NOW] bakcup completed" >> $LOG

