#!/bin/bash

# Script used to install RStudio Server on CentOS 7
# This script requires active inputs (i.e. the license key and installation of sparklyr)

# Setup
yum -y install epel-release
yum -y install R R-devel libcurl-devel openssl-devel
yum -y update R
R -e "print(1+1)" #test if R is running


# Install free, open-source version
# should you choose this option you will not need the below
# sans some of the configs (possibly)
# wget https://download2.rstudio.org/rstudio-server-rhel-1.0.153-x86_64.rpm
# yum -y install --nogpgcheck rstudio-server-rhel-1.0.153-x86_64.rpm


# Install enterprise edition
yum -y install wget
wget https://download2.rstudio.org/rstudio-server-rhel-pro-1.0.153-x86_64.rpm
yum -y install --nogpgcheck rstudio-server-rhel-pro-1.0.153-x86_64.rpm


# Activate RStudio Server Pro 
OLDIFS=$IFS
echo "Please enter your RStudio Server Pro license key followed by Ctrl + D:"
IFS="   "
PEM=`cat`
RKEY=`mktemp -p /tmp rstudio_license-XXXX`
echo $PEM > $RKEY
IFS=$OLDIFS
rstudio-server license-manager activate `cat $RKEK`
rstudio-server restart


# Install requirement for Kerberos
yum -y install pam_krb5


# Config files
cat >> /etc/rstudio/rserver.conf <<EOF
auth-stay-signed-in-days=7
auth-pam-sessions-profile=rstudio-session
auth-pam-sessions-use-password=1
auth-pam-sessions-close=1
EOF

cat >> /etc/pam.d/rstudio <<EOF
auth       sufficient     pam_krb5.so debug
account    required       pam_krb5.so debug
session    requisite      pam_krb5.so debug
EOF

cat >> /etc/pam.d/rstudio-session <<EOF
auth        required      pam_krb5.so debug
auth        optional      pam_mount.so use_first_pass
account     [default=bad success=ok user_unknown=ignore] pam_krb5.so debug
password    sufficient    pam_krb5.so use_authtok debug
session     requisite     pam_krb5.so debug
EOF

echo "readenv=1" >> /etc/environment


# Install sparklyr (execute manually to select CRAN mirror)
yum -y install libxml2-devel
echo "Install sparklyr with following command (execute manually to select CRAN mirror)"
echo "R -e \"install.packages('sparklyr')\""


# Remove some packages and files
yum -y remove epel-release
rm -f $RKEY

