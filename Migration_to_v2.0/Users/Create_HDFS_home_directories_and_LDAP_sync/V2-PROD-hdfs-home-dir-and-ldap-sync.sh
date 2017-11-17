#PROD SCRIPT
#This script sync's ldap with ambari server, then creates a home directory for any new users synced through ldap. Output can be found at /var/log/onboardingautomatino/create-hdfs-home-dir-and-ldap-sync.log

LDAP_PASSWORD="/etc/onboardingautomation/ldapsync.conf"
EXISTING_HDFS_USERS="/etc/onboardingautomation/existing-hdfs-users.txt"
USER_DIFFERENCES="/etc/onboardingautomation/user-differences.txt"

MYSQL_PASSWORD_FILE="/etc/onboardingautomation/sqlpassword.conf" #This is stored on the mysql server
SQLQUERY='use ambari;select user_name from users;'
SQL_USER_LIST="/etc/onboardingautomation/sql-user-list.txt"
MYSQL_PASSWORD_FILE='/etc/onboardingautomation/sqlpassword.conf'
MYSQL_PASSWORD=`ssh a-mysql-02 "cat $MYSQL_PASSWORD_FILE"`

#NOTE A-MYSQL-02 IS THE PRIMARY DB, AND LOGIN IS HIVE. SQL PASSWORD STORED ON SQL SERVER

exec &>> /var/log/onboardingautomation/create-hdfs-home-dir-and-ldap-sync.log
echo "$(date +'%h %d %H:%M:%S')"

/usr/sbin/ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt --ldap-sync-admin-name=admin --ldap-sync-admin-password=$(< "$LDAP_PASSWORD")
if [ $? -ne 0 ]; then
        exit
fi

sleep 30

ssh a-mysql-02 'mysql -u hive -p'"'"$MYSQL_PASSWORD"'"' -N -e '"'"$SQLQUERY"'" > $SQL_USER_LIST
if [ $? -ne 0 ]; then
        exit
fi

sleep 30

kinit hdfs-dace2@DAC.LOCAL -kt /etc/security/keytabs/hdfs.headless.keytab
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

while read LDAPUSER;
        do
                        hdfs dfs -mkdir /user/$LDAPUSER
                        hdfs dfs -chown $LDAPUSER:hdfs /user/$LDAPUSER
        done < $USER_DIFFERENCES

if [ $? -ne 0 ]; then
        exit
fi
echo 'Exiting, user directories created'
