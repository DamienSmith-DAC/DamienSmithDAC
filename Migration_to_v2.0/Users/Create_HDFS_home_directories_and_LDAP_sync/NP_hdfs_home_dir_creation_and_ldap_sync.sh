# NON PROD SCRIPT
# This script automates some of the user onboarding process. It:
#         1. Sync's LDAP entires in Ambari
#         2. Creates home directories for synced users in HDFS
#         3. Makes the user the owner of their home directory, and belong to the hdfs group
#         4. Logs the output of this script in /var/log/hdfs-user-dir-creatino/hdfs-user-dir-creation.log

#Log all errors from code below to hdfs-user-dir-creation.log, include a time stamp.
exec 2>> /var/log/hdfs-user-dir-creation/hdfs-user-dir-creation.log
echo "$(date +'%h %d %H:%M:%S')"

#Sync LDAP groups and send error output to /var/log/ldapsync/ldapsync.log
ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt --ldap-sync-admin-name=admin --ldap-sync-admin-password=$(< /root/ldapsyncconfig.txt)

#ssh to mysql server and pull list of users from ambari metastore to a txt file, scp this back to master
ssh np-a-mysql-01 'mysql -u root -p$(< /tmp/sqllogin.txt) -N -e "use ambari;select user_name from users;" > /tmp/user_list.txt; scp /tmp/user_list.txt root@np-master02:/root'

#Kerberos authentication for HDFS commands below
kinit hdfs-npdace2@DAC.LOCAL -kt /etc/security/keytabs/hdfs.headless.keytab

#List all user's home directories in /user, then output only the name of the home directory of each user (easier to compare)
hdfs dfs -ls /user | awk '{print $8}' | awk '{gsub("/user/", "");print}' | tail -n +2 > existing-hdfs-users.txt

#Compare the list of existing HDFS home directories with the all the users pulled from the ambari metastore DB. Output the difference (home dir's to create) to user_differences.txt
grep -Fxvf existing-hdfs-users.txt user_list.txt > user_differences.txt


#Loop through user_differences.txt and create the HDFS home directories for these users.
while read LDAPUSER;
        do
                        hdfs dfs -mkdir /user/$LDAPUSER
                        hdfs dfs -chown $LDAPUSER:hdfs /user/$LDAPUSER
        done < user_differences.txt
