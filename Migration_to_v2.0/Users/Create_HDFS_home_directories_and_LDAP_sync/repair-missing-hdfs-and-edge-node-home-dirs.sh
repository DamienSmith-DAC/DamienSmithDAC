#!/bin/bash

# This script sync's ldap on the ambari server, then creates any LDAP accounts 
# synced a home directory in HDFS. Error output can be found at 
# /var/log/onboardingautomation/repair-missing-hdfs-and-edge-node-home-dirs.log

LDAP_PASSWORD="/etc/onboardingautomation/ldapsync.conf"

MYSQL_PASSWORD_FILE="/etc/onboardingautomation/sqlpassword.conf" #this password is stored on the sql server
SQLQUERY='use ambari;select user_name from users;'
SQL_USER_LIST="/etc/onboardingautomation/sql-user-list.txt"
MYSQL_PASSWORD_FILE='/etc/onboardingautomation/sqlpassword.conf'
MYSQL_PASSWORD=`ssh  np-a-mysql-01 "cat $MYSQL_PASSWORD_FILE"`

EDGE_NODE_HOST_LIST="/etc/onboardingautomation/edge_node_host_list.txt"

exec &>> /var/log/onboardingautomation/repair-missing-hdfs-and-edge-node-home-dirs.log
echo "$(date +'%h %d %H:%M:%S')"

# Sync LDAP with Ambari
/usr/sbin/ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt --ldap-sync-admin-name=admin --ldap-sync-admin-password=$(< "$LDAP_PASSWORD")
if [ $? -ne 0 ]; then
	exit 
fi

sleep 30

# Get list of users from HortonWork's metadata DB
ssh np-a-mysql-01 'mysql -u root -p'"'"$MYSQL_PASSWORD"'"' -N -e '"'"$SQLQUERY"'" > $SQL_USER_LIST
if [ $? -ne 0 ]; then
	exit
fi

sleep 30

kinit hdfs-npdace2@DAC.LOCAL -kt /etc/security/keytabs/hdfs.headless.keytab
if [ $? -ne 0 ]; then
	exit
fi

# Loop through all users (stored in file specified by SQL_USER_LIST)
while read LDAPUSER <&3; do

	# Check if user is missing a hdfs home dir
	if ! hdfs dfs -test -d /user/$LDAPUSER; then
		# Create the HDFS home directories for these users
		hdfs dfs -mkdir /user/$LDAPUSER
		hdfs dfs -chown $LDAPUSER:hdfs /user/$LDAPUSER
	fi

	# Loop through all edge nodes (stored in file specified by EDGE_NODE_HOST_LIST)
	while read EDGE_NODE_HOSTNAME <&4; do

		# Check if user is missing an edge node home dir	
		if ! ssh $EDGE_NODE_HOSTNAME "[ -d /home/${LDAPUSER} ]"; then
			# Create the np-edge node home directories for these users.
			ssh -n $EDGE_NODE_HOSTNAME "mkdir -p /home/${LDAPUSER}/.ssh"
			ssh -n $EDGE_NODE_HOSTNAME "cp ~/.ssh/authorized_keys /home/${LDAPUSER}/.ssh/"
			ssh -n $EDGE_NODE_HOSTNAME "touch /home/${LDAPUSER}/.bashrc"
			ssh -n $EDGE_NODE_HOSTNAME "cat ~/.bashrc >> /home/${LDAPUSER}/.bashrc"
			ssh -n $EDGE_NODE_HOSTNAME "touch /home/${LDAPUSER}/.bash_profile"
			ssh -n $EDGE_NODE_HOSTNAME "cat ~/.bashrc >> /home/${LDAPUSER}/.bash_profile"
			ssh -n $EDGE_NODE_HOSTNAME "cd /home; chown -R ${LDAPUSER}:domain_users ${LDAPUSER};"
			ssh -n $EDGE_NODE_HOSTNAME "chmod 700 /home/${LDAPUSER}"
			ssh -n $EDGE_NODE_HOSTNAME "chmod 600 /home/${LDAPUSER}/.ssh/authorized_keys"
		fi

	done 4<$EDGE_NODE_HOST_LIST

done 3<$SQL_USER_LIST

if [ $? -ne 0 ]; then
	exit
fi
echo 'Exiting, user directories in HDFS and edge node created'

