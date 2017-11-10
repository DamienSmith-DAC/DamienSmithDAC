#!/bin/bash

# Script used to install RStudio Server on CentOS 7

# Setup
yum -y install epel-release
yum -y install R R-devel libcurl-devel openssl-devel
yum -y update R
R -e "print(1+1)" #test if R is running

# Install free, open-source version
#wget https://download2.rstudio.org/rstudio-server-rhel-1.0.153-x86_64.rpm
#yum -y install --nogpgcheck rstudio-server-rhel-1.0.153-x86_64.rpm

# Install enterprise edition
wget https://download2.rstudio.org/rstudio-server-rhel-pro-1.0.153-x86_64.rpm
yum -y install --nogpgcheck rstudio-server-rhel-pro-1.0.153-x86_64.rpm
yum -y remove epel-release

# Install requirement for Kerberos
yum -y install pam_krb5

# Config files
echo "readenv=1" >> /etc/environment

# Install sparklyr (execute manually to select CRAN mirror)
yum -y install libxml2-devel
echo "Install sparklyr with following command (execute manually to select CRAN mirror)"
echo "R -e \"install.packages('sparklyr')\""
