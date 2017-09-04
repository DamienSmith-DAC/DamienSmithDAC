#!/bin/bash

# Used to develop landing zone VMs, which leverage the landing zone base image that includes 
# the formated /landing directory mounted on 300gb of 'ephemeral' disk

# This post-build.sh script is run after the VM is built to add further configurations
# Add file under '--name-user' flag in 'openstack create server command' 

# Update OS
yum -y update

# Copy public key to root and remove root login blocking code
cat /home/centos/.ssh/authorized_keys > /root/.ssh/authorized_keys
