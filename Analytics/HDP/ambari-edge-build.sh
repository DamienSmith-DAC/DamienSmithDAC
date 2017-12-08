# Instructions for installing Ambari Views on an Edge Node

# DO NOT MAKE THIS FILE EXECUTABLE
# IT NEEDS FURTHER DEV TO AUTOMATE THE BUILD FOR AMBARI VIEWS ON AN EDGE NODE

# Pre-flight checklist
	# Executed and follow instructions in ambari-agent-build.sh

# In the target edge node, copy over certs, keytabs, and kerb config 
# from master or other ambari edge
mkdir /etc/security/serverKeys
scp -r root@ambari-edge-01:/etc/security/serverKeys /etc/security/ 
scp root@ambari-edge-01:/etc/security/keytabs/ambari.server.keytab /etc/security/keytabs/
scp root@ambari-edge-01:/etc/krb5.conf /etc/ 
chmod 755 /etc/security/serverKeys/
chmod 444 /etc/security/serverKeys/*
chown -R yarn:hadoop /etc/security/serverKeys/

# Install Ambari Server on the edge node
yum -y install ambari-server
yum -y install mysql-connector-java

# In the external metastore server 
mysql -u ambariviews0x -p -e "create database ambariviews01;"

# Create new credentials for ambariviews0x
# Follow this guide https://github.com/DFSI-DAC/Platform/blob/master/MySQL/install-external-mysql-service.sh
# For example:
	# CREATE USER 'ambariviews02'@'%' IDENTIFIED BY 'password';
	# GRANT ALL privileges on *.* to 'ambariviews02'@'%' WITH GRANT OPTION;
	# CREATE USER 'ambariviews02'@'localhost' IDENTIFIED BY 'password';
	# GRANT ALL privileges on *.* to 'ambariviews02'@'localhost' WITH GRANT OPTION;
	# CREATE USER 'ambariviews02'@'ambari-edge-02.dac.local' IDENTIFIED BY 'password';
	# GRANT ALL privileges on *.* to 'ambariviews02'@'ambari-edge-02.dac.local' WITH GRANT OPTION;
	# CREATE USER 'ambariviews02'@'master02.dac.local' IDENTIFIED BY 'password';
	# GRANT ALL privileges on *.* to 'ambariviews02'@'master02.dac.local' WITH GRANT OPTION;
	# FLUSH PRIVILEGES;

mysql -u ambariviews0x -p -D ambariviews0x < Ambari-DDL-MySQL-CREATE.sql

# Execute the setup command
ambari-server setup 
# The first time you'll need to state that you have an external metastore
# Select the type, provide the name of a new db for your Ambari Views (e.g. ambariviews01 )
# The last question will ask if you've run a DDL against that db, select 'no' or 'n'
# This DDL is call Ambari-DDL-MySQL-CREATE.sql for MySQL

# Set up security
ambari-server setup-security
# Select and configure [3] Setup Ambari kerberos JAAS configuration (use ambari-server-dace2@DAC.LOCAL)
# Select and configure [4] Setup truststore using /etc/security/serverKeys/all.jks 
# If using HTTPS, select and confiugre [1] Enable HTTPS for Ambari server (note, testing this has failed for ambari-edge-02)

# Go to your 
# Start Ambari Server 
ambari-server start

# Sync AD and new Ambari Edge
scp ambari-edge-01:/etc/ambari-server/conf/groups.txt /etc/ambari-server/conf/ 
ambari-server setup-ldap # See /etc/ambari-server/conf/ambari.properties in exiting Ambari Server or Edge Node for more details
ambari-server restart
ambari-server sync-ldap --groups /etc/ambari-server/conf/groups.txt 

# Go to http://<AmbariEdgeIP>:8080/views/ADMIN_VIEW/2.5.2.0/INSTANCE/#/remoteClusters
# Register the 'remote' cluster
