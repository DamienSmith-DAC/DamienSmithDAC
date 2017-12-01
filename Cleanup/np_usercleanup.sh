#!/bin/bash

# Script to remove users that have been marked as inactive
# Script is located in the non-production external metastore server

BASE_DIR=/etc/usercleanup
MYSQL_PASSWORD=`cat /etc/onboardingautomation/sqlpassword.conf` 
USER_TO_DELETE=${BASE_DIR}/users_to_delete.txt

# Logging 
exec &>> /var/log/usercleanup/usercleanup.log
echo ' '
echo "$(date +'%h %d %H:%M:%S')"

# Backup Ambari Database
echo 'Backing up Ambari database...'
mysqldump -u root -d ambari -p${MYSQL_PASSWORD} > ${BASE_DIR}/ambari.sql.backup


# Find Inactive Users and Remove User Directories
echo 'Creating users_to_delete.txt...'
mysql -u root -D ambari -p${MYSQL_PASSWORD} -e "select user_id from users where active = 0;" > ${USER_TO_DELETE}


# If file is not zero size
if [ -s ${USER_TO_DELETE} ]; then

	while read USER_ID; do

		USER_ID_STRING=user_id
		if [ $USER_ID != $USER_ID_STRING ]; 
			
			
			then
			
			# Find User Name
			USER_NAME_TMP=`mysql -u root -D ambari -p${MYSQL_PASSWORD} -e "select user_name from users where user_id = ${USER_ID}"`
			PREFIX="user_name "
			USER_NAME=`echo $USER_NAME_TMP | sed -e "s/$PREFIX//"`
			echo Removing ${USER_NAME} directories...

			# Remove HDFS Directory 
			ssh -n np-master02.dac.local "kinit hdfs-npdace2@DAC.LOCAL -kt /etc/security/keytabs/hdfs.headless.keytab; hdfs dfs -rm -r /user/${USER_NAME}" 
			
			# Remove Edge Node(s) Directories 
			ssh -n np-edge.dac.local "cd /home; rm -rfv ${USER_NAME};"
			
			
			else
			
			echo 'No directories removed.' 

		fi

	done < ${USER_TO_DELETE}

	# Remove Inactive Users from Ambari Database
	echo 'Removing inactive user(s) from Ambari database...'
	mysql -u root -D ambari -p${MYSQL_PASSWORD} -e "delete from members where user_id in (select user_id from users where active = 0); delete from users where active = 0;"

fi
