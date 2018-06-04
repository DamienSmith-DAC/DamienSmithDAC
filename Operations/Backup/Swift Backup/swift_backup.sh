#!/bin/bash
#########################################################################################
# 											#
#	This script compresses and encrypts backups under /analytics/ then		#
#	sends them to the swift container DAC_BACKUP for long-life storage.		#
#				AUTHOR = TIMOTHY HEYES					#
#18/05/2018										#
#########################################################################################


DATE=$(date +"%Y_%m_%d")
ZIPCOUNT=0 #This is a counter used to track the amount of retries for zipping the data.
SENDCOUNT=0 #This is a counter used to track the amount of retries for sending the data to openstack.
ENCRYPTCOUNT=0 #This is a counter used to track the amount of retries for encrypting the data.

while read BACKUP; do
	
	if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
		#find /analytics/dataproducts_cold_backup/full/ -mindepth 3 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #same as below for dp.
		find /root/testdir/encrypt/dp/full/ -mindepth 3 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt 
		echo "dp found, backing it up..."
	else
		find /root/testdir/encrypt/$BACKUP/ -mindepth 1 -maxdepth 1 -type d -mtime +14 -mtime -28 > ${DATE}_backup_directory_list.txt #create list all 2+week old folders
	fi

	while read FOLDER; do #loops through all the directories in $DATE_backup_directory_list.txt	
		BASEFILE="$(basename $FOLDER)"
		echo -e "zipping $FOLDER into $BASEFILE.tar.gz and creating list file...\n"
		ls $FOLDER > $BASEFILE.list #creating list with same name of backup.tar which hold all files being backed up in that tar.
		tar -czf $BASEFILE.tar.gz -C $FOLDER . #compress all the files inside $FOLDER
	
		while [ "$?" -ne 0 -a "$ZIPCOUNT" -le 4 ]; do #check if previous command was successful
			echo "zipping failed $ZIPCOUNT time(s). Retrying..."
			ZIPCOUNT=`expr $ZIPCOUNT +1`
			tar -czf $BASEFILE.tar.gz -C $FOLDER . #retry compress all the files inside $FOLDER
		done	
	
		if [ "$ZIPCOUNT" -ge 4 ]; then
			echo "zipping of $FOLDER failed. Exiting script."
                	exit 1
		else
			echo "$FOLDER successfully zipped."
                	ZIPCOUNT=0
		fi
		
		echo -e "encrypting $BASEFILE.tar.gz here using aes256...\n"
		#openssl enc -aes256 -in $BASEFILE.tar.gz -out $BASEFILE.tar.gz.enc #encrypt the zipped folder.
		openssl enc -aes256 -in $BASEFILE.tar.gz -out $BASEFILE.tar.gz.enc -pass file:/root/.backup.d/pass.key

		while [ "$?" -ne 0 -a "$ENCRYPTCOUNT" -le 4 ]; do #check if ecrypting was sucessful.
                	echo "encrypting failed $ENCRYPTCOUNT time(s). Retrying..."
                	ENCRYPTCOUNT=`expr $ENCRYPTCOUNT +1`
			#openssl enc -aes256 -in $BASEFILE.tar.gz -out $BASEFILE.tar.gz.enc #retry encrypt the zipped folder.
			openssl enc -aes256 -in $BASEFILE.tar.gz -out $BASEFILE.tar.gz.enc -pass file:/root/.backup.d/pass.key
		done

        	if [ "$ENCRYPTCOUNT" -ge 4 ]; then
                	echo "encrypting of $BASEFILE.tar.gz failed. Exiting script."
                	exit 1
        	else
                	echo "$BASEFILE.tar.gz successfully encrypted. Removing $BASEFILE.tar.gz locally."
                	ENCRYPTCOUNT=0
			rm -f $BASEFILE.tar.gz #remove local zip file after it has been encrypted.
        	fi
        	
                echo -e "Sending backup to swift container. \n"
		
		if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
			DP="$(echo $FOLDER | sed 's/^.//')"
			openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
		else
			echo "sending backup to swift..."
			openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
		fi

		while [ "$?" -ne 0 -a "$SENDCOUNT" -le 4 ]; do
			echo "sending backup to swift failed $SENDCOUNT time(s). Retrying..."
			SENDCOUNT=`expr $SENDCOUNT + 1`
			if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
				echo "sending backup to swift failed $SENDCOUNT time(s). Retrying..."
				openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
                        else
        	        	echo "sending backup to swift failed $SENDCOUNT time(s). Retrying..."
				openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.tar.gz.enc #sends zipped, encrypted file to openstack container.
                	fi
		done

		if [ "$SENDCOUNT" -ge 4 ]; then #exits script if sending of data fails 4 times, else resets counter for next file.
			echo "sending of $BASEFILE.tar.gz.enc to swift failed. Exiting script."
			exit 1
		else
			echo -e "Sending list file to swift container. \n"
			if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
				openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                        else
                                openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                        fi
		fi
			while [ "$?" -ne 0 -a "$SENDCOUNT" -le 4 ]; do
                        	echo "sending list to swift failed $SENDCOUNT time(s). Retrying..."
                        	SENDCOUNT=`expr $SENDCOUNT + 1`
                        	if [ "$BACKUP" == "dataproducts_cold_backup" ]; then
                                	echo "sending list to swift failed $SENDCOUNT time(s). Retrying..."
					openstack --insecure object create DAC_BACKUP/$DP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                        	else
                                	echo "sending list to swift failed $SENDCOUNT time(s). Retrying..."
					openstack --insecure object create DAC_BACKUP/analytics/$BACKUP $BASEFILE.list #sends zipped, encrypted file to openstack container.
                       		fi

	                done

			echo "$BASEFILE.tar.gz.enc successfully sent to swift container. Removing $BASEFILE.tar.gz.enc and list file locally."
			SENDCOUNT=0
			rm -f $BASEFILE.tar.gz.enc #delete encrypted file after it has been uploaded to swift container.
			rm -f $BASEFILE.list

	done < ${DATE}_backup_directory_list.txt

done < /root/.backup.d/backup_list.txt

rm -f ${DATE}_backup_directory_list.txt
