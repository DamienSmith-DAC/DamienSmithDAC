#!/bin/bash

# Used to develop landing zone VMs, which leverage the landing zone base image that includes 
# the formated /landing directory mounted on 300gb of 'ephemeral' disk

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

# This tells the dhcpclient to not get DNS information from DNS so the default /etc/resolv.conf will be used
sed -i 's/PEERDNS=\"yes\"/PEERDNS=\"no\"/g' /etc/sysconfig/network-scripts/ifcfg-eth0
#Add dac.local to /etc/resolv.conf
sed -i 's/search gls.local/search gls.local dac.local/g' /etc/resolv.conf 

# Mount /landing
umount /mnt
sed -i '/^\/dev\/vdb/d' /etc/fstab
mkdir -p /landing
mkfs.ext4 /dev/vdb
echo "/dev/vdb /landing ext4 defaults 0 2" >> /etc/fstab
mount /dev/vdb /landing

