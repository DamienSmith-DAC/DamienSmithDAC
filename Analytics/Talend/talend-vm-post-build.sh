#!/bin/bash

# Used to develop talend orchestration VMs, which leverage the talend base image that includes 
# the formated /talend directory mounted on 300gb of 'ephemeral' disk

# This post-build.sh script is run after the VM is built to add further configurations
# Add file under '--name-user' flag in 'openstack create server command' 

# Update OS
yum -y update

# Copy public key to root and remove root login blocking code
cat /home/centos/.ssh/authorized_keys > /root/.ssh/authorized_keys

# Change hostname from hostname.gls.local to hostname.dac.local
sed -i 's/gls/dac/g' /etc/hostname
sed -i 's/gs/dac/g' /etc/hostname
sed -i 's/- set_hostname/#- set_hostname/g' /etc/cloud/cloud.cfg
sed -i 's/- update_hostname/#- update_hostname/g' /etc/cloud/cloud.cfg

# Install Java (Oracle jdk-8u141-linux-x64.rpm)
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.rpm"
export PATH=/usr/java/jdk1.8.0_141/bin:$PATH
echo "export PATH=/usr/java/jdk1.8.0_141/bin:$PATH >> .bash_profile"
export JAVA_HOME=/usr/java/jdk1.8.0_141
echo "export JAVA_HOME=/usr/java/jdk1.8.0_141 >> .bash_profile"
