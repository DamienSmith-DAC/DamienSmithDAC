#!/bin/bash

# Used to develop hadoop master, data and edge nodes
# This post-build.sh script is run after the VM is built to add further configurations
# Add file under '--name-user' flag in 'openstack create server command' 

# Copy public key to root and remove root login blocking code
cat /home/centos/.ssh/authorized_keys > /root/.ssh/authorized_keys

# Change hostname from hostname.gls.local to hostname.dac.local
sed -i 's/gls/dac/g' /etc/hostname
sed -i 's/gs/dac/g' /etc/hostname
sed -i 's/- set_hostname/#- set_hostname/g' /etc/cloud/cloud.cfg
sed -i 's/- update_hostname/#- update_hostname/g' /etc/cloud/cloud.cfg

# Mount /hadoop/log 
mkdir -p /hadoop/log
umount /mnt
umount /logs
sed -i '/^\/dev\/vdb/d' /etc/fstab
mkfs.ext4 /dev/vdb
echo "/dev/vdb /hadoop/log ext4 defaults 0 2" >> /etc/fstab
mount /dev/vdb /hadoop/log

# Reduce swapiness to 0
echo 0 > /proc/sys/vm/swappiness

# Disable IPv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6 
echo 1 > /proc/sys/net/ipv6/conf/lo/disable_ipv6 

# Instantiate changes
sysctl -p
