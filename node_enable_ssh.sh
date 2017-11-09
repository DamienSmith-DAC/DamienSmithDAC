#!/bin/sh

# We use this os that we can test on a copy of the config files
BASEDIR="/tmp/fcc"

umask 027

# This script enables username/password login
# within the DAC Platform

# We need the epel repo for 'crudini' which can edit '.ini' files
# The EPEL repository is added in a disabled state because some of the RPMs can cause hassles
yum -y install epel-release
yum -y --enablerepo=epel install crudini

# Modify the sshd config so that it allows kerberised password logins

export CONF="$BASEDIR"'/etc/ssh/sshd_config'
export CONF_BCK="$CONF".`date +%Y%m%d`'-'`date +%s`
export CONF_NEW=`mktemp -p /tmp sshd_config.XXXXX`

cp -f $CONF $CONF_BCK
egrep -v 'KerberosAuthentication|KerberosOrLocalPasswd|PasswordAuthentication' $CONF >>$CONF_NEW

echo KerberosAuthentication yes >>$CONF_NEW
echo KerberosOrLocalPasswd yes >>$CONF_NEW
echo PasswordAuthentication yes >>$CONF_NEW

mv -f $CONF_NEW $CONF
 
# Update the sssd pam option
crudini --set "$BASEDIR"/etc/sssd/sssd.conf 'sssd' services 'nss, pam'
 
service sssd restart
service sshd restart
 
sss_cache -E
