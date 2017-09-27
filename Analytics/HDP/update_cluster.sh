!#/bin/bash

# Script used to update Hadoop cluster with require configs

hosts=( np-data01 np-data02 np-data03 np-data04 np-master02 np-master01 )


for h in "${hosts[@]}"
do
  echo "#####################################################################"
  echo "Hostname: "
  #n="$(echo $h | cut -c5-6)"
  #echo $n  
  ssh $h "hostname -f"
  echo ' '

  # ATTACH DISKS FOR DATANODES
  #ssh $h 'mkdir -p /hadoop/data/disk01'  
  #ssh $h "echo -e '\nhadoop = {\nfeatures = has_journal,extent,huge_file,flex_bg,uninit_bg,dir_nlink,extra_isize\ninode_ratio = ssh $h '131072\nreserved_ratio = 0\ndefault_mntopts = acl,user_xattr\n}' >> /etc/mke2fs.conf"
  #ssh $h "mke2fs -t ext4 -T hadoop /dev/vdc1"
  #ssh $h "echo -e '# hdfs options: inode_readahead_blks=128,data=writeback,noatime,nodev,nobarrier,nodiratime\n/dev/vdc1     /hadoop/data/disk01     ext4  rw,nodev,noatime,inode_readahead_blks=128,data=writeback,nobarrier,nodiratime     1     2' >> /etc/fstab"
  #ssh $h "mount /dev/vdc1 /hadoop/data/disk01"


  # CORRECT MASTER NODE MOUNTS
  #ssh $h umount /hadoop/log
  #ssh $h mount /dev/vdb /hadoop  
  #ssh $h "sed -i s'/\/hadoop\/log/\/hadoop/'g /etc/fstab"
  
  # INITIAL SETUP
  #ssh $h "ulimit -Sn"
  #ssh $h "ulimit -Hn"  
  #ssh $h "chkconfig chronyd on"
  #ssh $h "service chronyd start"
  

  # ADD public_hostname.sh TO ALL NODES
  #scp /var/lib/ambari-agent/public_hostname.sh $h:/var/lib/ambari-agent/
  #ssh $h "ls -alt /var/lib/ambari-agent/"
  #ssh $h "sed -i s'/system_resource_overrides=\/etc\/resource_overrides/system_resource_overrides=\/etc\/resource_overrides\npublic_hostname_script=\/var\/lib\/ambari-agent\/public_hostname.sh/'g /etc/ambari-agent/conf/ambari-agent.ini"
  #ssh $h "chmod 700 /var/lib/ambari-agent/public_hostname.sh"
  #ssh $h "sed -i s'/logdir=\/var\/log\/ambari-agent/logdir=\/hadoop\/log\/ambari-agent/'g /etc/ambari-agent/conf/ambari-agent.ini"
  #ssh $h "ambari-agent restart"
  #ssh $h "ambari-agent status"


  # SCP serverKeys AND SET PERMISSIONS
  #scp -r /etc/security/serverKeys $h:/etc/security/
  #ssh $h "chmod 755 /etc/security/serverKeys/"
  #ssh $h "chown yarn:hadoop /etc/security/serverKeys/*.jks"
  #ssh $h "chmod 444 /etc/security/serverKeys/*.jks"
  #ssh $h "ls alt /etc/security/serverKeys/"
  

  # SCP http_secert TO ALL NODES (ENABLE SPENAGO)   
  #scp /etc/security/http_secret $h:/etc/security/
  #chmod 440 /etc/security/http_secret
  #ssh $h "chown hdfs:hadoop /etc/security/http_secret"
  #ssh $h "ls -altr /etc/security/"


  # OTHER COMMANDS
  #ssh $h "usermod -G hadoop ambari"
  #ssh $h "echo 'ambari ALL=(ALL) NOPASSWD:SETENV: /bin/mkdir, /bin/cp, /bin/chmod, /bin/rm' >> /etc/sudoers"
  #ssh $h "sed -i s'/ambari ALL=(ALL) NOPASSWD:SETENV: \/bin\/mkdir, \/bin\/cp, \/bin\/chmod, \/bin\/rm//'g /etc/sudoers"
  #ssh $h "cat /etc/sudoers"
  #ssh $h "lsblk"
  #ssh $h "cat /etc/ambari-agent/conf/ambari-agent.ini"
  #echo "/hadoop/data/disk$n" 
  #ssh $h "mkdir -p /hadoop/data/disk$n"
  #ssh $h "umount /mnt" 
  #ssh $h "mount --source /dev/vdb --target /hadoop/logs" 
  #ssh $h "sed -i 's/- set_hostname/#- set_hostname/g' /etc/cloud/cloud.cfg"
  #ssh $h "sed -i 's/- update_hostname/#- update_hostname/g' /etc/cloud/cloud.cfg"
  #ssh $h "sed -i 's/gs/dac/g' /etc/hostname"
  #ssh $h "reboot"
  #ssh $h "hostname -f"
  #ssh $h "ambari-agent reset master02.dac.local"
  #ssh $h "ambari-agent start"
  #ssh $h "ambari-agent restart"
  #ssh $h "ls /home/hdfs/"
  #scp /etc/security/http_secret $h:/etc/security/
  #ssh $h "chown hdfs:hadoop /etc/security/http_secret"
  #ssh $h "chmod 440 /etc/security/http_secret"
  #ssh $h "yum -y -q install sssd oddjob-mkhomedir authconfig sssd-krb5 sssd-ad sssd-tools libpam-sss libnss-sss libnss-ldap adcli"
  #ssh $h "adcli join dac.local --login-user="bind_user" -v --show-details --domain-controller=p-dc-101.dac.local --domain-ou=OU=Computers,OU=PE,OU=DAC,DC=DAC,DC=local"
  #scp ./sssd.conf $h:/etc/sssd/
  #ssh $h "chmod 0600 /etc/sssd/sssd.conf"
  #ssh $h "service sssd restart"
  #ssh $h "authconfig --enablesssd --enablesssdauth --enablemkhomedir --enablelocauthorize --update"
  #ssh $h "chkconfig oddjobd on"
  #ssh $h "service oddjobd restart"
  #ssh $h "chkconfig sssd on"
  #ssh $h "service sssd restart"
  #ssh $h "sss_cache -E"
  #ssh $h "id doej"
  #ssh $h "mkdir /etc/security/serverKeys/"
  #scp /etc/security/serverKeys/* $h:/etc/security/serverKeys/
  #ssh $h "chown yarn:hadoop /etc/security/serverKeys/*.jks; chmod 440 /etc/security/serverKeys/"
  #ssh $h "chown root:root /etc/security/serverKeys/; chmod 755 /etc/security/serverKeys/"
  #ssh $h "chmod 444 /etc/security/serverKeys/*"

  echo ' '
done
