#!/bin/bash
#to backup another directory, mimic the structure of hdfs/hive backups and simply add that directory to the backup_list.txt file in /root/backup.d/
#########################################################################################
# 											#
#	This script compresses and encrypts backups under /analytics/ then		#
#	sends them to the swift container DAC_BACKUP for long-life storage.		#
#				AUTHOR = TIMOTHY HEYES					#
#18/05/2018										#
#########################################################################################


DATE=$(date +"%Y_%m_%d")
LOG_PATH="/analytics/log/SWIFT_$(date +%a%Y%m%d).log"

# Log function
function log_info()
{
    log_time=`date "+%Y-%m-%d:%H:%M:%S"`
    echo -e "$* $log_time" >> ${LOG_PATH}
}

while read BACKUP; do
	
	if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
		find /analytics/dataproducts_cold_backup/full/ -mindepth 3 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #same as below for dp.
		#find /root/testdir/encrypt/dp/full/ -mindepth 3 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt 
	else
		find /analytics/$BACKUP/ -mindepth 1 -maxdepth 1 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #create list all 2+week old folders
	fi

	while read FOLDER; do #loops through all the directories in $DATE_backup_directory_list.txt	
		BASEFILE="$(basename $FOLDER)"
		echo -e "zipping $FOLDER into $BASEFILE.tar.gz and creating list file...\n"
		ls $FOLDER > $BASEFILE.list #creating list with same name of backup.tar which hold all files being backed up in that tar.
		tar -czf $BASEFILE.tar.gz -C $FOLDER . #compress all the files inside $FOLDER
	
		if [ "$?" -ne 0 ]; then #check if previous command was successful
			log_info "Error: zipping of $BASEFILE.tar.gz failed."
			exit 1
		fi	
	
		log_info  "Info: $FOLDER successfully zipped."
		
		echo -e "encrypting $BASEFILE.tar.gz using aes256...\n"
		openssl enc -aes256 -in $BASEFILE.tar.gz -out $BASEFILE.tar.gz.enc -pass file:/root/.backup.d/pass.key

		if [ "$?" -ne 0 ]; then #check if ecrypting was successful.
                	log_info "Error: encrypting of $BASEFILE.tar.gz failed."
			exit 1
		fi

                log_info "Info: $BASEFILE.tar.gz successfully encrypted. Removing $BASEFILE.tar.gz locally."
		rm -f $BASEFILE.tar.gz #remove local zip file after it has been encrypted.
        	
                echo -e "Sending $BASEFILE.tar.gz.enc to swift container. \n"
		
		if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
			DP="$(echo $FOLDER | sed 's/^.//')"
			openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
		else
			openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
		fi

		if [ "$?" -ne 0 ]; then
			log_info "Error: sending $BASEFILE.tar.gz.enc to DAC_BACKUP failed."
			exit 1
		fi
	
		log_info "Info: $BASEFILE.tar.gz.enc sent to DAC_BACKUP. Removing $BASEFILE.tar.gz.enc locally."
		rm -f $BASEFILE.tar.gz.enc #delete encrypted file after it has been uploaded to swift container.

		if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
			openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                else
                        openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                fi
		
		if [ "$?" -ne 0 ]; then
                        log_info "Error: sending $BASEFILE.list to DAC_BACKUP failed."
                        exit 1
		fi

		log_info "Info: $BASEFILE.list sent to DAC_BACKUP. Removing $BASEFILE.list locally."
		rm -f $BASEFILE.list

	done < ${DATE}_backup_directory_list.txt

done < /root/.backup.d/backup_list.txt

rm -f ${DATE}_backup_directory_list.txt
