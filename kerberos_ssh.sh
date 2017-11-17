#!/bin/sh

# This script enables kerberos ssh logins on a machine
# within the DAC Platform


# Grab all the RPMS we need.
# The EPEL repository is added in a disabled state because some of the RPMs can cause hassles
yum -y install epel-release
yum -y --enablerepo=epel install pam_krb5.x86_64 nss-pam-ldapd samba-common-tools realmd oddjob sssd krb5-workstation crudini


# Joing the Kerberose realm
echo 'Enter the Kerberos bind_user password'
realm join -U bind_user DAC.LOCAL
 
 
# MOdify the sshd config so that it allows kerberised password logins

export CONF='/etc/ssh/sshd_config'
export CONF_BCK="$CONF".`date +%Y%m%d`
export CONF_NEW="$CONF".new
 
cp -f $CONF $CONF_BCK
egrep -v 'KerberosAuthentication|KerberosOrLocalPasswd|PasswordAuthentication' $CONF  >$CONF_NEW
 
echo KerberosAuthentication yes >>$CONF_NEW
echo KerberosOrLocalPasswd yes >>$CONF_NEW
echo PasswordAuthentication yes >>$CONF_NEW
mv -f $CONF_NEW $CONF
 
# Enable the authentication methods we want
authconfig --enablesssd --enablesssdauth --enablelocauthorize --update
authconfig --enablekrb5 --krb5kdc=P-DC-101.dac.local --krb5adminserver=P-DC-101.dac.local --update
authconfig --enablemkhomedir --update
 
# Update the sssd kerberos options
crudini --set /etc/sssd/sssd.conf 'domain/dac.local' fallback_homedir '/home/%u'
crudini --set /etc/sssd/sssd.conf 'domain/dac.local' use_fully_qualified_names False
crudini --set /etc/sssd/sssd.conf 'domain/dac.local' krb5_ccname_template 'FILE:/tmp/krb5cc_%U_XXXXXX'
 
# restart all the services we have updated
chkconfig oddjobd on
chkconfig sssd on

sss_cache -E
 
service oddjobd restart
service sssd restart
service sshd restart
 
 


