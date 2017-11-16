#This script syncs the ambari server with ldap. It uses the password stored in /etc/onboardingautomation/ldapsync.conf

LDAP_PASSWORD="/etc/onboardingautomation/ldapsync.conf"

exec 2>> /var/log/ldapsync/ldapsync.log
echo "$(date +'%h %d %H:%M:%S')"

/usr/sbin/ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt --ldap-sync-admin-name=admin --ldap-sync-admin-password=$(< "$LDAP_PASSWORD")
if [ $? -ne 0 ]; then
        exit
fi
