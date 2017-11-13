#NON PROD SCRIPT
#This script sync's ldap on the ambari server, then creates any LDAP accounts synced a home directory in HDFS. Error output can be found at /var/log/onboardingautomation/create-hdfs-user-dir-and-sync-ldap.log

LDAP_PASSWORD="/etc/onboardingautomation/ldapsync.conf"
EXISTING_HDFS_USERS="/etc/onboardingautomation/existing-hdfs-users.txt"
USER_DIFFERENCES="/etc/onboardingautomation/user-differences.txt"

MYSQL_PASSWORD_FILE="/etc/onboardingautomation/sqlpassword.conf" #this password is stored on the sql server
SQLQUERY='use ambari;select user_name from users;'
SQL_USER_LIST="/etc/onboardingautomation/sql-user-list.txt"
MYSQL_PASSWORD_FILE='/etc/onboardingautomation/sqlpassword.conf'
MYSQL_PASSWORD=`ssh  np-a-mysql-01 "cat $MYSQL_PASSWORD_FILE"`


exec &>> /var/log/onboardingautomation/create-hdfs-user-dir-and-sync-ldap.log
echo "$(date +'%h %d %H:%M:%S')"

ssh np-a-mysql-01 'mysql -u root -p'"'"$MYSQL_PASSWORD"'"' -N -e '"'"$SQLQUERY"'" > $SQL_USER_LIST

ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt --ldap-sync-admin-name=admin --ldap-sync-admin-password=$(< "$LDAP_PASSWORD")
if [ $? -ne 0 ]; then
        exit
fi

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
