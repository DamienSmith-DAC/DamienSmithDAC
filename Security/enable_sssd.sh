#!/bin/bash

# Script to enable SSSD on a single VMs (CentOS 7)
# See this link as reference material: https://nswdac.atlassian.net/wiki/spaces/TEC/pages/35750028/Security0

# Variables
BIND_USER=bind_user
DOMAIN_CONTROLLER=p-dc-101.dac.local
DC_HOSTNAME=P-DC-101
DOMAIN_OU=OU=Computers,OU=PE,OU=DAC,DC=DAC,DC=local
DOMAIN=DAC.LOCAL

# Install required libs
yum -y -q install sssd oddjob-mkhomedir authconfig sssd-krb5 sssd-ad sssd-tools libpam-sss libnss-sss libnss-ldap adcli

# Join domain 
adcli join dac.local --login-user="${BINDUSER}" -v --show-details --domain-controller=${DOMAIN_CONTROLLER} domain-ou=${DOMAIN_OU}

# Write SSSD config file

cat >> /etc/sssd/sssd.conf << EOF
[sssd]
## master & data nodes only require nss. Edge nodes can utilize pam to enable SSH login with a keytab.
services = nss, pam
config_file_version = 2
domains = ${DOMAIN}
override_space = _ 

[domain/${DOMAIN}]
debug_level = 10
id_provider = ldap
ad_server = ${DOMAIN_CONTROLLER} 
ad_backup_server = ${DOMAIN_CONTROLLER} 
ad_hostname = ${DC_HOSTNAME}
ad_domain = ${DOMAIN} #might need to be lower case
dns_discovery_domain = ${DOMAIN_CONTROLLER} 
auth_provider = ldap
enumerate = true
krb5_realm = ${DOMAIN}
krb5_server = ${DOMAIN_CONTROLLER} 
ldap_schema = ad
ldap_id_mapping = True
cache_credentials = True
ldap_access_order = expire
ldap_account_expire_policy = ad
fallback_homedir = /home/%u
default_shell = /bin/false
ldap_referrals = True
case_sensitive = False
#ldap_uri = ldap://${DOMAIN_CONTROLLER}:389
ldap_uri = ldaps://${DOMAIN_CONTROLLER}:636
ldap_tls_reqcert = never
ldap_default_bind_dn = ${BIND_USER}@${DOMAIN}
ldap_default_authtok = Changeit
ldap_default_authtok_type = password
ldap_schema = ad
ldap_idmap_range_min = 20000000
ldap_idmap_range_max = 2020000000
ldap_idmap_range_size = 2000000 

[nss]
memcache_timeout = 3600
override_shell = /bin/bash
# filters written with hadoop in mind
filter_users = root,lightdm,nslcd,dnsmasq,dbus,avahi,avahi-autoipd,backup,beagleindex,bin,daemon,games,gdm,gnats,haldaemon,hplip,irc,ivman,klog,libuuid,list,lp,mail,man,messagebus,mysql,news,ntp,openldap,polkituser,proxy,pulse,puppet,saned,sshd,sync,sys,syslog,uucp,vde2-net,www-data,ambari-qa,ambari,mysql,hive,zookeeper,yarn,hdfs,kafka,storm,ams,ranger
filter_groups = root,hadoop 

[pam]

EOF

chmod 0600 /etc/sssd/sssd.conf

# Start services 
service sssd restart
authconfig --enablesssd --enablesssdauth --enablemkhomedir --enablelocauthorize --update
chkconfig oddjobd on
service oddjobd restart
chkconfig sssd on
service sssd restart
sss_cache -E
