!#/bin/bash

# Script used to generate the truststore used as prereq for Kerberos in Ambari

# run on ambari server
mkdir -p /etc/security/serverKeys
echo -n | openssl s_client -connect p-dc-101.dac.local:636 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /etc/security/serverKeys/ldapserver.crt
keytool -import -v -trustcacerts -alias ldapserver -file /etc/security/serverKeys/ldapserver.crt -keystore /etc/security/serverKeys/all.jks

# loop through list of nodes
#scp -r /etc/security/serverKeys $h:/etc/security/
#ssh $h "chmod 755 /etc/security/serverKeys/"
#ssh $h "chown yarn:hadoop /etc/security/serverKeys/*.jks"
#ssh $h "chmod 444 /etc/security/serverKeys/*.jks"

# on ambari server after distributing truststore across nodes
#ambari-server setup-security
