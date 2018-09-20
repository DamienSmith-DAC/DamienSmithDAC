#This script sync's ldap on the ambari server, then creates any LDAP accounts synced a home directory in HDFS. Error output can be found at /var/log/onboardingautomation/create-hdfs-user-dir-and-sync-ldap.log

LDAP_PASSWORD="/etc/onboardingautomation/ldapsync.conf"
EXISTING_HDFS_USERS="/etc/onboardingautomation/existing-hdfs-users.txt"
USER_DIFFERENCES="/etc/onboardingautomation/user-differences.txt"

MYSQL_PASSWORD_FILE="/etc/onboardingautomation/sqlpassword.conf" #this password is stored on the sql server
SQLQUERY='use ambari;select user_name from users;'
SQL_USER_LIST="/etc/onboardingautomation/sql-user-list.txt"
MYSQL_PASSWORD_FILE='/etc/onboardingautomation/sqlpassword.conf'
MYSQL_PASSWORD=`ssh  np-a-mysql-01 "cat $MYSQL_PASSWORD_FILE"`

EDGE_NODE_HOSTNAME="np-anaconda.dac.local"

exec &>> /var/log/onboardingautomation/create-hdfs-home-dir-and-ldap-sync.log
echo "$(date +'%h %d %H:%M:%S')"

/usr/sbin/ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt --ldap-sync-admin-name=admin --ldap-sync-admin-password=$(< "$LDAP_PASSWORD")
if [ $? -ne 0 ]; then
	exit 
fi

sleep 30

ssh np-a-mysql-01 'mysql -u root -p'"'"$MYSQL_PASSWORD"'"' -N -e '"'"$SQLQUERY"'" > $SQL_USER_LIST

sleep 30

kinit hdfs-npdace2@DAC.LOCAL -kt /etc/security/keytabs/hdfs.headless.keytab
if [ $? -ne 0 ]; then
	exit
fi

hdfs dfs -ls /user | cut -d '/' -f 3 | tail -n +2 > $EXISTING_HDFS_USERS
if [ $? -ne 0 ]; then
	exit
fi

grep -Fxvf $EXISTING_HDFS_USERS $SQL_USER_LIST > $USER_DIFFERENCES
if [ $? -ne 0 ]; then
	echo 'Exiting, no user directories created'
	exit
fi

#Loop through user_differences.txt 
while read LDAPUSER;
        do
		# Create the HDFS home directories for these users
		hdfs dfs -mkdir /user/$LDAPUSER
		hdfs dfs -chown $LDAPUSER:hdfs /user/$LDAPUSER

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
			
        done < $USER_DIFFERENCES

if [ $? -ne 0 ]; then
        exit
fi
echo 'Exiting, user directories in HDFS and edge node created'

