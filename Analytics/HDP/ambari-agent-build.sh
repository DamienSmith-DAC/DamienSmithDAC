#!/bin/bash

# Script to install new node up to point where Ambari Wizard can take over
# Use when developing new master, data, or edge node that does not host ambari-server

# Pre-flight checklist
	# Pleas manually add host to DNS

# Install ambari-agent
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.1.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
yum repolist # to confirm
yum -y install ambari-agent
AMBARI_MASTER_SERVER=master02.dac.local
sed -i "s/^hostname.*$/hostname=$AMBARI_MASTER_SERVER/g" /etc/ambari-agent/conf/ambari-agent.ini
sed -i "s:^logdir.*$:logdir=/hadoop/log/ambari-agent:g" /etc/ambari-agent/conf/ambari-agent.ini
sed -i "/;\ ignore.*$/a public_hostname_script=\/var\/lib\/ambari-agent\/public_hostname.sh" \/etc/ambari-agent/conf/ambari-agent.ini

touch /var/lib/ambari-agent/public_hostname.sh
cat >> /var/lib/ambari-agent/public_hostname.sh << EOF
#!/bin/bash
echo `hostname -f`
EOF

# Final instructions
echo "Please update the following when this ends"
echo "Go to Ambari Master and add host"
echo "# scp -r /etc/security/serverKeys <node>:/etc/security/"
echo "# ssh <node>"
echo "# chmod 755 /etc/security/serverKeys/"
echo "# chmod 444 /etc/security/serverKeys/*"
echo "Please reboot this server"
