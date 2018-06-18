#!/bin/bash
#to backup another directory, mimic the structure of hdfs/hive backups and simply add that directory to the backup_list.txt file in /analytics/config/
#########################################################################################
# 											#
#	This script compresses and encrypts backups under /analytics/ then		#
#	sends them to the swift container DAC_BACKUP for long-life storage.		#
#				AUTHOR = TIMOTHY HEYES					#
#18/05/2018										#
#########################################################################################

SEGMENTSIZE=5368709120 #size of each segment for uploading of files over 5gb (5gb is file size limit for a single file)
DATE=$(date +"%Y_%m_%d")
LOG_PATH="/analytics/log/SWIFT_$(date +%a%Y%m%d).log"
EMAILADDRESS="Indu.Neelakandan@treasury.nsw.gov.au,dacsupport@treasury.nsw.gov.au" #email adress to send error notification to.
exec 2> $LOG_PATH #send all standard error to the log file.
# Log function
function log_info()
{
    log_time=`date "+%Y-%m-%d:%H:%M:%S"`
    echo -e "$* $log_time" >> ${LOG_PATH}
}

while read BACKUP; do
	
	if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
		find /analytics/dataproducts_cold_backup/full/ -mindepth 3 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #same as below for dp.
		#find /root/testdir/encrypt/dp/full/ -mindepth 3 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #test environment
	else
		find /analytics/$BACKUP/ -mindepth 1 -maxdepth 1 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #create list all 2+week old folders
		 #find /root/testdir/encrypt/$BACKUP/ -mindepth 1 -maxdepth 1 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #test environment
	fi

	while read FOLDER; do #loops through all the directories in $DATE_backup_directory_list.txt	
		BASEFILE="$(basename $FOLDER)"
		echo -e "zipping $FOLDER into $BASEFILE.tar.gz and creating list file...\n"
		ls $FOLDER > $BASEFILE.list #creating list with same name of backup.tar which hold all files being backed up in that tar.
		tar -czf $BASEFILE.tar.gz -C $FOLDER . #compress all the files inside $FOLDER
	
		if [ "$?" -ne 0 ]; then #check if previous command was successful
			log_info "Error: zipping of $BASEFILE.tar.gz failed."
		(
                        echo To: $EMAILADDRESS
                        echo Subject: "[SWIFT BACKUP] Error: zipping of $BASEFILE.tar.gz failed."
                        echo "Mime-Version: 1.0"
                        echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                        echo ""
                        echo "--GvXjxJ+pjyke8COw"
                        echo "Content-Type: text/html"
                        echo "Content-Disposition: inline"
                        echo ""
                        echo "File zipping failed. Check log file under /analytics/log for more information."
                        echo "--GvXjxJ+pjyke8COw"
                        echo "Content-Type: application/text/html"
                        echo "Content-Transfer-Encoding: base64"
                        echo ""
                ) | /usr/sbin/sendmail -t
			exit 1
		fi	
	
		log_info  "Info: $FOLDER successfully zipped."
		
		echo -e "encrypting $BASEFILE.tar.gz using aes256...\n"
		openssl enc -aes256 -in $BASEFILE.tar.gz -out $BASEFILE.tar.gz.enc -pass file:/analytics/config/pass.key

		if [ "$?" -ne 0 ]; then #check if ecrypting was successful.
                	log_info "Error: encrypting of $BASEFILE.tar.gz failed."
		(
                	echo To: $EMAILADDRESS
                	echo Subject: "[SWIFT BACKUP] Error: encrypting of $BASEFILE.tar.gz failed."
                	echo "Mime-Version: 1.0"
                	echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                	echo ""
                	echo "--GvXjxJ+pjyke8COw"
                	echo "Content-Type: text/html"
                	echo "Content-Disposition: inline"
                	echo ""
                	echo "File excryption failed. Check log file under /analytics/log for more information."
                	echo "--GvXjxJ+pjyke8COw"
                	echo "Content-Type: application/text/html"
                	echo "Content-Transfer-Encoding: base64"
                	echo ""
        	) | /usr/sbin/sendmail -t
			exit 1
		fi

                log_info "Info: $BASEFILE.tar.gz successfully encrypted. Removing $BASEFILE.tar.gz locally."
		rm -f $BASEFILE.tar.gz #remove local zip file after it has been encrypted.
        	
                echo -e "Sending $BASEFILE.tar.gz.enc to swift container. \n"

		BACKUPSIZE=$(wc -c <"$BASEFILE.tar.gz.enc")

		if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
			DP="$(echo $FOLDER | sed 's/^.//')"
			if [ "$BACKUPSIZE" -ge "$SEGMENTSIZE" ]; then
                        	swift upload DAC_BACKUP/$DP -S "$SEGMENTSIZE" $BASEFILE.tar.gz.enc
				echo "SEGMENTING FILE"
			else
				swift upload DAC_BACKUP/$DP $BASEFILE.tar.gz.enc
                	fi

			#openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
		else
			if [ "$BACKUPSIZE" -ge "$SEGMENTSIZE" ]; then
                        	swift upload DAC_BACKUP/analytics/$BACKUP -S "$SEGMENTSIZE" $BASEFILE.tar.gz.enc
			else
				swift upload DAC_BACKUP/analytics/$BACKUP $BASEFILE.tar.gz.enc
	                fi

			#openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
		fi

		if [ "$?" -ne 0 ]; then
			log_info "Error: sending $BASEFILE.tar.gz.enc to DAC_BACKUP failed."
		(
                        echo To: $EMAILADDRESS
                        echo Subject: "[SWIFT BACKUP] Error: sending $BASEFILE.tar.gz.enc to DAC_BACKUP failed."
                        echo "Mime-Version: 1.0"
                        echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                        echo ""
                        echo "--GvXjxJ+pjyke8COw"
                        echo "Content-Type: text/html"
                        echo "Content-Disposition: inline"
                        echo ""
                        echo "File sending failed. Check log file under /analytics/log for more information."
                        echo "--GvXjxJ+pjyke8COw"
                        echo "Content-Type: application/text/html"
                        echo "Content-Transfer-Encoding: base64"
                        echo ""
                ) | /usr/sbin/sendmail -t	
			exit 1
		fi
	
		log_info "Info: $BASEFILE.tar.gz.enc sent to DAC_BACKUP. Removing $BASEFILE.tar.gz.enc locally."
		rm -f $BASEFILE.tar.gz.enc #delete encrypted file after it has been uploaded to swift container.

		if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
			swift upload DAC_BACKUP/$DP $BASEFILE.list
			#openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                else
                        swift upload DAC_BACKUP/analytics/$BACKUP $BASEFILE.list
			#openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                fi
		
		if [ "$?" -ne 0 ]; then
                        log_info "Error: sending $BASEFILE.list to DAC_BACKUP failed."
                (
                        echo To: $EMAILADDRESS
                        echo Subject: "[SWIFT BACKUP] Error: sending $BASEFILE.list to DAC_BACKUP failed."
                        echo "Mime-Version: 1.0"
                        echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                        echo ""
                        echo "--GvXjxJ+pjyke8COw"
                        echo "Content-Type: text/html"
                        echo "Content-Disposition: inline"
                        echo ""
                        echo "List file sending failed. Check log file under /analytics/log for more information."
                        echo "--GvXjxJ+pjyke8COw"
                        echo "Content-Type: application/text/html"
                        echo "Content-Transfer-Encoding: base64"
                        echo ""
                ) | /usr/sbin/sendmail -t
			exit 1
		fi

		log_info "Info: $BASEFILE.list sent to DAC_BACKUP. Removing $BASEFILE.list locally."
		rm -f $BASEFILE.list
		rm -rf $FOLDER

	done < ${DATE}_backup_directory_list.txt

done < /analytics/config/backup_list.txt

rm -f ${DATE}_backup_directory_list.txt
