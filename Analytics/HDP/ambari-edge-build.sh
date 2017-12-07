# Instructions for installing Ambari Views on an Edge Node

# DO NOT MAKE THIS FILE EXECUTABLE
# IT NEEDS FURTHER DEV TO AUTOMATE THE BUILD FOR AMBARI VIEWS ON AN EDGE NODE

# Pre-flight checklist
	# Added host to DNS
	# Executed hadoop-vm-post-build.sh
	# Executed ambari-agent-build.sh

# In the edge node
mkdir /etc/security/serverKeys
mkdir /etc/security/keytabs

# From Ambari Server Master, transfer truststore, certs, the Ambari Keytab, and kerb config
scp -r /etc/security/serverKeys root@np-ambari-edge-test:/etc/security/
scp /etc/security/keytabs/ambari.server.keytab root@np-ambari-edge-test:/etc/security/keytabs/
scp /etc/krb5.conf root@np-ambari-edge-test:/etc/

# In the edge node
chmod 755 /etc/security/serverKeys/
chmod 444 /etc/security/serverKeys/*

# Install Ambari Server on the edge node
yum -y install ambari-server
yum -y install mysql-connector-java

# In the external metastore server 
mysql -u ambari -p -e "create database ambariviews01;"
mysql -u ambari -p -D ambariviews01 < Ambari-DDL-MySQL-CREATE.sql

# Execute the setup command
ambari-server setup 
# The first time you'll need to state that you have an external metastore
# Select the type, provide the name of a new db for your Ambari Views (e.g. ambariviews01 )
# The last question will ask if you've run a DDL against that db, select 'no' or 'n'
# This DDL is call Ambari-DDL-MySQL-CREATE.sql for MySQL

# Set up security
ambari-server setup-security
# Select and configure [3] Setup Ambari kerberos JAAS configuration.
# Select and configure [4] Setup truststore using /etc/security/serverKeys/all.jks 

# Enable SSSD
./enable_sssd.sh

# Go to your 
# Start Ambari Server 
ambari-server start

# Sync AD and new Ambari Edge
# From Ambari Server Master, transfer ldap sync configs
scp /etc/ambari-server/conf/groups.txt np-ambari-edge-test:/etc/ambari-server/conf/
scp /etc/ambari-server/conf/password.dat np-ambari-edge-test:/etc/ambari-server/conf/
scp /etc/ambari-server/conf/ambari.properties np-ambari-edge-test:/etc/ambari-server/conf/

# In the edge node
ambari-server setup-ldap # you may or may not need to run this
ambari-server restart
/usr/sbin/ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt

# Go to http://<AmbariEdgeIP>:8080/views/ADMIN_VIEW/2.5.2.0/INSTANCE/#/remoteClusters
# Register the 'remote' cluster
