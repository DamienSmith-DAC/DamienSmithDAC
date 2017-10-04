#!/bin/bash

# Install RStudio Server (freemium version) to CentOS 7

yum -y install epel-release
yum -y install R R-devel libcurl-devel openssl-devel 
yum -y update R
R -e "print(1+1)" #test if R is running
yum -y remove epel-release
wget https://download2.rstudio.org/rstudio-server-rhel-1.0.153-x86_64.rpm
yum -y install --nogpgcheck rstudio-server-rhel-1.0.153-x86_64.rpm
yum -y remove epel-release
