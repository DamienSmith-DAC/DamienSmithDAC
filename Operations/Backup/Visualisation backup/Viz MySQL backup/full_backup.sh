#!/bin/bash

export LC_ALL=C

#set -x
DEFAULTS=/db/mysql_backup/config/backup_full
##remote_server=$(grep "^remote_server=" $DEFAULTS | cut -d"=" -f 2)
##remote_path=$(grep "^remote_path=" $DEFAULTS | cut -d"=" -f 2)
#remote_user=$(grep "^remote_user=" $DEFAULTS | cut -d"=" -f 2)
#local_path=$(grep "^local_path=" $DEFAULTS | cut -d"=" -f 2)
db_user=$(grep "^db_user=" $DEFAULTS | cut -d"=" -f 2)
db_pass=$(grep "^db_pass=" $DEFAULTS | cut -d"=" -f 2)
#thread_count=$(grep "^parallelism=" $DEFAULTS | cut -d"=" -f 2)
xtrabackup=$(grep "^xtrabackup=" $DEFAULTS | cut -d"=" -f 2)
purge_user=$(grep "^purge_user=" $DEFAULTS | cut -d"=" -f 2)
purge_pass=$(grep "^purge_pass=" $DEFAULTS | cut -d"=" -f 2)

local_path=/db/mysql_backup
conf_file=/etc/my.cnf
socket=/db/mysql/mysql.sock
lockfile=$local_path/FS_inprogress.lock
inc_lockfile=$local_path/inc_inprogress.lock
local_err=/tmp/pdbfullbckerr.$$
encryption_key_file="/db/mysql_backup/config/encryption_key"

backup_path=$local_path/full/
log_file=$local_path/mysql_full_backup.log
lsn_dir=$local_path/lsn_incr



emailAddress="indu.neelakandan@treasury.nsw.gov.au,dacsupport@treasury.nsw.gov.au"
#emailAddress="rkumar@pythian.com"
backup_owner="mysqlbackup"
file_name="$(date +%a%Y%m%d)/backup-progress.log"


sanity_check () {
    # Check user running the script
    if [ "$USER" != "$backup_owner" ]; then
        error "Script can only be run as the \"$backup_owner\" user"
    fi

    # Check whether the encryption key file is available
    if [ ! -r "${encryption_key_file}" ]; then
        error "Cannot read encryption key at ${encryption_key_file}"
    fi
}

# Use this to echo to standard error
error () {
    printf "%s: %s\n" "$(basename "${BASH_SOURCE}")" "${1}" >&2

    (
                echo To: $emailAddress
                echo Subject: "Error"
                echo "Mime-Version: 1.0"
                echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                echo ""
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: text/html"
                echo "Content-Disposition: inline"
                echo ""
                echo "${1}"
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: application/text/html"
                echo "Content-Transfer-Encoding: base64"
                echo ""
                base64 $attachment
    ) | /usr/sbin/sendmail -t

    exit 1
}
trap 'error "An unexpected error occurred."' ERR

[ -f $lockfile ] && exit 1      # already in progress
while [ -f $inc_lockfile ]
do
        sleep 600               # wait for incremental to complete
done
trap 'rm -f $lockfile $local_err' 0
touch $lockfile

# get last LSN to purge tracking files later
last_lsn=$(fgrep -h last_lsn $local_path/lsn*/xtrabackup_checkpoints | tr -d "[ ]" | cut -d"=" -f 2 | sort -n | tail -1)

file_time=$(date "+%Y%m%d_%H%M")
backup_file="$file_time.xbs.gz"
date_path=$(date "+%Y/%m/%d")
todays_dir=$backup_path/$date_path
backup_type="Full"

[ ! -d $lsn_path ] && mkdir $lsn_path
[ ! -d $backup_path ] && mkdir -p $backup_path
[ ! -d $backup_path/$date_path ] && mkdir -p $backup_path/$date_path

#ssh -q -i $key $remote_user@$remote_server "mkdir -p $remote_path/$date_path"

innobackupex --defaults-file=$conf_file --skip-secure-auth --parallel=4 --no-version-check --slave-info --ibbackup=/usr/bin/$xtrabackup  --socket=$socket --user=$db_user --password=$db_pass --tmpdir=$local_path/tmp --compress --stream=xbstream --encrypt=AES256 --encrypt-key-file=${encryption_key_file} --extra-lsndir=$lsn_dir $backup_path 2>>$log_file | pigz >  $backup_path/$date_path/FS_$backup_file 2>>$local_err


#| pigz | ssh -q -i $key $remote_user@$remote_server "cat > $remote_path/$date_path/FS_$backup_file" 2>>$local_err


# Check success and print message

if tail -1 "${log_file}" | grep -q "completed OK"; then

  echo "Backup successful for `date "+%Y%m%d_%H%M"`" > /db/mysql_backup/mail.txt
  echo "$backup_type Backup created at $todays_dir $now" >> /db/mysql_backup/mail.txt
  echo "`ls -lh $todays_dir`" >> /db/mysql_backup/mail.txt
 mail -s "Successful backup created for `hostname` at `date`" $emailAddress < /db/mysql_backup/mail.txt

else
    echo "Backup failure! Check $log_file for more information" > /db/mysql_backup/failure.txt
#echo "Subject: Backup failed for "${now}"" | sendmail -v rkumar@pythian.com
 mail -s "Backup failed for `hostname` at `date`"  $emailAddress  < /db/mysql_backup/failure.txt
fi



status=0
if [ -s $local_err ]
then
        echo "STREAMING ERROR DETECTED!"
        cat $local_err
        status=1
else
        echo "PURGE CHANGED_PAGE_BITMAPS BEFORE $(expr $last_lsn + 1)" | mysql -A -u $purge_user -h localhost -p$purge_pass
fi >> $log_file
exit $status
