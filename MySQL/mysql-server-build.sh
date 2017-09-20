#!/bin/bash

# Used to develop landing zone VMs

# This build script is run after the VM is built to add further configurations
# Add file under '--name-user' flag in 'openstack create server command' 

# Update OS
yum -y update
 
#Add useful tools
yum -y install nano
yum -y install vim
yum -y install unzip
yum -y install wget
yum -y install tar
yum -y install createrepo
yum -y install ntp
yum -y install epel-release
yum -y install pssh
yum -y remove epel-release
 
# Start ntpd
service ntpd start
chkconfig ntpd on
 
# Configure NTP conf to use government servers
#back up ntp conf file
cp /etc/ntp.conf /etc/ntp.conf.backup
#comment out default ntp servers
sed -i 's/^server [0-3].centos.pool.ntp.org iburst/#&/' /etc/ntp.conf
#add in the GovDC ntp servers with a comment
sed -i 's/^#server 3.centos.pool.ntp.org iburst/&\n\n#GovDC NTP servers\nserver 143.119.99.5\nserver 143.119.225.5/' /etc/ntp.conf
 
# Enable root login
sed -i 's/^\#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
#Copy and edit centos' authorised keys into root authorized_keys file
cat /home/centos/.ssh/authorized_keys > /root/.ssh/authorized_keys
#restart SSH daemon
systemctl restart sshd
#Change permissions of .ssh to root only
chmod go-rwx -R /root/.ssh/

# Change hostname from hostname.gls.local to hostname.dac.local
sed -i 's/gls/dac/g' /etc/hostname
sed -i 's/gs/dac/g' /etc/hostname
sed -i 's/- set_hostname/#- set_hostname/g' /etc/cloud/cloud.cfg
sed -i 's/- update_hostname/#- update_hostname/g' /etc/cloud/cloud.cfg

# This tells the dhcpclient to not get DNS information from DNS so the default /etc/resolv.conf will be used
sed -i 's/PEERDNS=\"yes\"/PEERDNS=\"no\"/g' /etc/sysconfig/network-scripts/ifcfg-eth0
#Add dac.local to /etc/resolv.conf
sed -i 's/gls/dac/g' /etc/resolv.conf 

# Mount /db
umount /mnt
sed -i '/^\/dev\/vdb/d' /etc/fstab
mkdir -p /db
mkfs.ext4 /dev/vdb
echo "/dev/vdb /db ext4 defaults 0 2" >> /etc/fstab
mount /dev/vdb /db

# Install MySQL Cluster
#sleep 120
#wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.5/mysql-cluster-community-7.5.7-1.el7.x86_64.rpm-bundle.tar
#tar xvf mysql-cluster-community-7.5.7-1.el7.x86_64.rpm-bundle.tar
#yum -y install perl-Data-Dumper
#yum -y remove mariadb-libs-5.5.52-1.el7.x86_64
#yum -y install mysql-cluster-community-common-7.5.7-1.el7.x86_64.rpm
#yum -y install mysql-cluster-community-libs-7.5.7-1.el7.x86_64.rpm

# Check for latest package of perl-Class-MethodMaker
#yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/p/perl-Class-MethodMaker-2.20-1.el7.x86_64.rpm
#yum -y install mysql-cluster-community-client-7.5.7-1.el7.x86_64.rpm
#yum -y install mysql-cluster-community-server-7.5.7-1.el7.x86_64.rpm

# Configure cluster
#cd /db
#mkdir -p /var/lib/mysql-cluster
#cd /var/lib/mysql-cluster
#vi config.ini
#Start mysql, get root password, grant user
#service mysqld start
#search mysql log for secret
#retrieve password cat ~/.mysql_secre
#mysql_secure_installation
