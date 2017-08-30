#!/bin/bash

# This post-build.sh script is run after the VM is built to add further configurations
# Add file under '--name-user' flag in 'openstack create server command' 

# Copy public key to root and remove root login blocking code
cat /home/centos/.ssh/authorized_keys > /root/.ssh/authorized_keys

# Umount /mnt causing it to rename as /logs
umount /mnt

# Reduce swapiness to 0
echo 0 > /proc/sys/vm/swappiness

# Disable IPv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6 
echo 1 > /proc/sys/net/ipv6/conf/lo/disable_ipv6 

# Instantiate changes
sysctl -p
