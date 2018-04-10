#!/bin/bash
export LC_ALL=C

DEFAULTS=/db/mysql_backup/config/backup_incr
host=$(hostname | cut -d"." -f 1)

##remote_server=$(grep "^remote_server=" $DEFAULTS | cut -d"=" -f 2)
##remote_path=$(grep "^remote_path=" $DEFAULTS | cut -d"=" -f 2)
#remote_user=$(grep "^remote_user=" $DEFAULTS | cut -d"=" -f 2)
#local_path=$(grep "^local_path=" $DEFAULTS | cut -d"=" -f 2)
db_user=$(grep "^db_user=" $DEFAULTS | cut -d"=" -f 2)
db_pass=$(grep "^db_pass=" $DEFAULTS | cut -d"=" -f 2)
#thread_count=$(grep "^parallelism=" $DEFAULTS | cut -d"=" -f 2)
xtrabackup=$(grep "^xtrabackup=" $DEFAULTS | cut -d"=" -f 2)


local_path=/db/mysql_backup
conf_file=/etc/my.cnf
socket=/db/mysql/mysql.sock
lockfile=$local_path/inc_inprogress.lock
full_lockfile=$local_path/FS_inprogress.lock
local_err=/tmp/pdbincrbckerr.$$
encryption_key_file="/db/mysql_backup/config/encryption_key"

backup_path=$local_path/incr/
log_file=$local_path/mysql_incremental_backup.log
lsn_dir=$local_path/lsn_incr


emailAddress="dacsupport@treasury.nsw.gov.au"
backup_owner="mysqlbackup"


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





[ -f $lockfile ] && exit 1      # already in progress
[ -f $full_lockfile ] && exit 0 # full in progress


trap 'rm -f $lockfile $local_err' 0
touch $lockfile

file_time=$(date "+%Y%m%d_%H%M")
backup_file="inc.$file_time.xbs.gz"
date_path=$(date "+%Y/%m/%d")

todays_dir=$backup_path/$date_path
backup_type="Incremental"

[ ! -d $lsn_path ] && mkdir $lsn_path
[ ! -d $backup_path ] && mkdir -p $backup_path
[ ! -d $backup_path/$date_path ] && mkdir -p $backup_path/$date_path

#ssh -q -i $key $remote_user@$remote_server "mkdir -p $remote_path/$date_path"
#--parallel=4

innobackupex --defaults-file=$conf_file --skip-secure-auth --no-version-check --incremental --slave-info --no-timestamp --ibbackup=/usr/bin/xtrabackup  --socket=$socket --user=$db_user --password=$db_pass --tmpdir=$local_path/tmp --compress --stream=xbstream --encrypt=AES256 --encrypt-key-file=${encryption_key_file} --extra-lsndir=$lsn_dir --incremental-basedir=$lsn_dir  $backup_path 2>>$log_file | pigz >  $backup_path/$date_path/delta_$backup_file 2>>$local_err


#status=0
#if [ -s $local_err ]
#then
#        echo "STREAMING ERROR DETECTED!"
#        cat $local_err
#        status=1
#fi >> $log_file
#exit $status



# Check success and print message

#if tail -1 "${log_file}" | grep -q "completed OK"; then
  #  printf "Backup successful!\n"
  #  printf "Backup created at %s/%s-%s\n" "${todays_dir}" "${backup_type}" "${now}"

        #(
             #   echo To: $emailAddress
             #   echo Subject: "Successful backup created at " "${todays_dir}" "${backup_type}" "${now}"
            #    echo "Mime-Version: 1.0"
           #     echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
          #      echo ""
         #       echo "--GvXjxJ+pjyke8COw"
        #        echo "Content-Type: text/html"
       #         echo "Content-Disposition: inline"
      #          echo ""
     #           echo "Check log file at ${log_file} for more information"
    #            echo ""
   #             echo "--GvXjxJ+pjyke8COw"
  #              echo "Content-Type: application/text/html"
  #              echo "Content-Transfer-Encoding: base64"
  #              echo "Content-Disposition: attachment; filename=$file_name"
 #               echo ""
 #               base64 $attachment
 #       ) | /usr/sbin/sendmail -t

#else
   # error "Backup failure! Check ${log_file} for more information"

       # (
               # echo To: $emailAddress
               # echo Subject: "Backup failure Check ${log_file} for more information"
               # echo "Mime-Version: 1.0"
              #  echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
             #   echo ""
            #    echo "--GvXjxJ+pjyke8COw"
           #     echo "Content-Type: text/html"
          #      echo "Content-Disposition: inline"
         #       echo ""
        #        echo "Check log file at ${log_file} for more information"
       #         echo ""
      #          echo "--GvXjxJ+pjyke8COw"
     #           echo "Content-Type: application/text/html"
    #            echo "Content-Transfer-Encoding: base64"
  #              echo "Content-Disposition: attachment; filename=$file_name"
   #             echo ""
  #              base64 $attachment
 #       ) | /usr/sbin/sendmail -t

#fi

if tail -1 "${log_file}" | grep -q "completed OK"; then

  echo "Backup successful for `date "+%Y%m%d_%H%M"`" > /db/mysql_backup/mail.txt
  echo "$backup_type Backup created at $todays_dir $now" >> /db/mysql_backup/mail.txt
  echo "`ls -lh $todays_dir`" >> /db/mysql_backup/mail.txt
 mail -s "Successful backup created for `hostname` at `date`" $emailAddress < /db/mysql_backup/mail.txt

else
    echo "Backup failure! Check $log_file for more information" > /db/mysql_backup/failure.txt
 mail -s "Backup failed for `hostname` at `date`"  $emailAddress  < /db/mysql_backup/failure.txt
fi
