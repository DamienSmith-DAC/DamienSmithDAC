import subprocess

openvpn = "x.x.x.x/x"

viz_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'viz_security_group', 
                      'description': "'Allow all HTTP and HTTPS in, as well as comms across the viz_security_group on all ports.",
                      'rules':
                        [
			  ['tcp', 'ingress', '-1', '-1', '', "'viz_security_group'"],
			  ['tcp', 'ingress', '80', '80', '0.0.0.0/0', "''"],
                          ['tcp', 'ingress', '443' , '443', '0.0.0.0/0', "''"]
                        ]
                    }


dp_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'dp_security_group', 
                      'description': "'Allow mysql and sql-server from the Vizualisation subnet'",
                      'rules':
                        [
			  ['tcp', 'ingress', '-1', '-1', "''", 'dp_security_group'],
                          ['tcp', 'ingress', '3306', '3306', "''", 'viz_security_group'],
                          ['tcp', 'ingress', '1433', '1433', "''", 'viz_security_group'],
			  ['tcp', 'ingress', '3306', '3306', "''", 'analytics_security_group'] #as discussed
			  ['tcp', 'ingress', '1433', '1433', "''", 'analytics_security_group'] #allow analytics_security_group to push data to dataproducts layer
			  ['tcp', 'ingress', '1433', '1433', 'openvpn', "''"]
			  ['tcp', 'ingress', '3306', '3306', 'openvpn', "''"]		        
                        ]
                    }

edge_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'edge_security_group', 
                      'description': "'Allow RStudio, Zeppelin, and Jupyter from trusted VPN machines. Allow comms across the edge node subnet'",
                      'rules':
                        [
                          ['tcp', 'ingress', '8787', '8787', 'openvpn', "''"],
			  ['tcp', 'ingress', '-1', '-1', '', "'edge_security_group'"],
                          ['tcp', 'ingress', '9995', '9995', 'openvpn', "''"],
                          ['tcp', 'ingress', '8889', '8889', 'openvpn', "''"]
                        ]
                    }

analytics_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'analytics_security_group', 
                      'description': "'Allow Ambari, Hive Metastore, Hive Web UI, Hive Server, Spark, Spark History Server from trusted VPN machines. Allow connections from the edge node subnet from ports 1019 to 50475'",
                      'rules':
                        [
			  ['tcp', 'ingress', '-1', '-1', '', "'analytics_security_group'"],
			  ['tcp', 'ingress', '1019', '50475', '', "'edge_security_group'"], #allow imbound connections from edge node subnet
                          ['tcp', 'ingress', '3000', '3000', 'openvpn', "''"],
                          ['tcp', 'ingress', '6080', '6080', 'openvpn', "''"],
                          ['tcp', 'ingress', '8080', '8080', 'openvpn', "''"],
                          ['tcp', 'ingress', '8088', '8088', 'openvpn', "''"],
			  ['tcp', 'ingress', '8886', '8886', 'openvpn', "''"],
			  ['tcp', 'ingress', '16010', '16010', 'openvpn', "''"],
			  ['tcp', 'ingress', '18081', '18081', 'openvpn', "''"],
			  ['tcp', 'ingress', '19888', '19888', 'openvpn', "''"],
			  ['tcp', 'ingress', '21000', '21000', 'openvpn', "''"],
			  ['tcp', 'ingress', '50070', '50070', 'openvpn', "''"],
                          ['tcp', 'ingress', '18080', '18080', 'openvpn', "''"]
						  
			  #Not clear on which ports these are exactly but I'm assuming its the 
			  #hive/ambari/spark ports? Different to the original ports in this script. 
						  
			 #will get steve to send a snapshot of current rules for verification
                        ]
                    }
					
landing_zone_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'landing_zone_security_group', 
                      'description': "'Allow SSH, HTTPS from the analytics_security_group. Allow intergroup comms and all HTTPS traffic'",
                      'rules':
                        [
			  ['tcp', 'ingress', '22', '22', '', "'analytics_security_group'"],
			  ['tcp', 'ingress', '443', '443', '', "'analytics_security_group'"],
			  ['tcp', 'ingress', '-1', '-1', '', "'landing_zone_security_group'"],
			  ['tcp', 'ingress', '443', '443', '0.0.0.0/0', "''"]   
						  
			  #Allows all inbound HTTPS traffic, as discussed with Byron (should HTTP be included too?). 
			  #Cloudflare handles IP whitelisting *this still seems insecure because in the 
			  #latest pentest Cloudflare could be circumvented if you knew the server IP
                        ]
                    }	
					
default_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'default_security_group', 
                      'description': "'Allow SSH, RDP from OpenVPN subnet for management. Allow outbound traffic on all ports.'",
                      'rules':
                        [
                          ['tcp', 'egress', '-1', '-1', '0.0.0.0/0', "''"],
			  ['tcp', 'ingress', '22', '22', 'openvpn', "''"],
			  ['tcp', 'ingress', '3389', '3389', 'openvpn', "''"]
                        ]
                    }
					
	
list_of_groups=[viz_security_group, dp_security_group, edge_security_group, analytics_security_group, landing_zone_security_group, default_security_group]

for group in list_of_groups:
    
    print ('PRINTING %s...' % group['group'])
    print
    
    bashCommand = "openstack security group create %s --tenant-id %s --description %s" \
    % (group['group'], group['tenant-id'], group['description'])
    
    print (bashCommand)
    #output = subprocess.check_output(bashCommand, shell=True) REMOVE COMMENT WHEN RUNNING
    print

    for i in range(len(group['rules'])):
        
        print ('PRINTING RULE NUMBER %s...' % (i+1))
        print
        bashCommand = """openstack security group rule create %s  \
                --tenant-id %s  \
                --protocol %s  \
                --direction %s  \
                --ethertype %s  \
                --port-range-min %s  \
                --port-range-max %s  \
                --remote-ip-prefix %s \
                --remote-group-id %s""" % (group['group'],  \
                                           group['tenant-id'],   \
                                           group['rules'][i][0], \
                                           group['rules'][i][1], \
                                           'IPv4', \
                                           group['rules'][i][2], \
                                           group['rules'][i][3], \
                                           group['rules'][i][4], \
                                           group['rules'][i][5] 
                                          )

        print (bashCommand)
        #output = subprocess.check_output(bashCommand, shell=True) REMOVE COMMENT WHEN RUNNING
        print
		print
		print('REMINDER: ADD IPv6 EGRESS RULE FOR DEFAULT GROUP')
    print 
    print
