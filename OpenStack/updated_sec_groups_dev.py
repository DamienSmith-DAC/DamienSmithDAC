import subprocess

viz_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'viz_security_group', 
                      'description': "'Allow all HTTP and HTTPS in, as well as comms across the viz_security_group on all ports.",
                      'rules':
                        [
						  ['tcp', 'ingress', '1', '65535', '', "'viz_security_group'"],
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
						  ['tcp', 'ingress', '1', '65535', "''", 'dp_security_group'],
                          ['tcp', 'ingress', '3306', '3306', "''", 'viz_security_group'],
                          ['tcp', 'ingress', '1433', '1433', "''", 'viz_security_group'],
						  ['tcp', 'ingress', '1', '65535', "''", 'analytics_security_group']		#allow analytics_security_group to push data to dataproducts layer, which ports?			        
                        ]
                    }
						  #['tcp', 'ingress', '1433', '1433', '10.16.66.0/24', "''"]
						  #['tcp', 'ingress', '3306', '3306', '10.16.66.0/24', "''"]
						  #Didnt include the SQL rules from the VPN subnet as im unsure what its for? is it for Talend?

edge_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'edge_security_group', 
                      'description': "'Allow RStudio, Zeppelin, and Jupyter from trusted VPN machines. Allow comms across the edge node subnet'",
                      'rules':
                        [
                          ['tcp', 'ingress', '8787', '8787', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '1', '65535', '', "'edge_security_group'"],
                          ['tcp', 'ingress', '9995', '9995', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '8889', '8889', '10.16.66.0/24', "''"]
                        ]
                    }

analytics_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'analytics_security_group', 
                      'description': "'Allow Ambari, Hive Metastore, Hive Web UI, Hive Server, Spark, Spark History Server from trusted VPN machines. Allow connections from the edge node subnet from ports 1019 to 50475'",
                      'rules':
                        [
						  ['tcp', 'ingress', '1', '65535', '', "'analytics_security_group'"],
						  ['tcp', 'ingress', '1019', '50475', '10.30.54.0/24', "''"], #allow imbound connections from edge node subnet
                          ['tcp', 'ingress', '3000', '3000', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '6080', '6080', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '8080', '8080', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '8088', '8088', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '8886', '8886', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '16010', '16010', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '18081', '18081', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '19888', '19888', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '21000', '21000', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '50070', '50070', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '18080', '18080', '10.16.66.0/24', "''"]
						  
						  #Not clear on which ports these are exactly but I'm assuming its the 
						  #hive/ambari/spark ports? Different to the original ports in this script. 
						  #Why are these services on the openVPN subnet, will they be on the same subnet in v2?
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
						  ['tcp', 'ingress', '22', '22', 'analytics_ip', "''"], 
						  ['tcp', 'ingress', '443', '443', 'analytics_ip', "''"],
						  
					#Are the analytics_ip rules redundant given the above rules for
					#the analytics_security_group? Hard for me to know without testing
					
						  ['tcp', 'ingress', '1', '65535', '', "'landing_zone_security_group'"],
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
                          ['tcp', 'egress', '1', '65535', '0.0.0.0/0', "''"],
						  ['tcp', 'ingress', '22', '22', '10.16.66.0/24', "''"],
						  ['tcp', 'ingress', '3389', '3389', '10.16.66.0/24', "''"]
						  #default sg allows imbound traffic from 10.240.0.0/22? what is this for?
                        ]
                    }
					
	
list_of_groups=[viz_security_group, dp_security_group, edge_security_group, analytics_security_group, landing_zone_security_group, default_security_group]

for group in list_of_groups:
    
    print ('PRINTING %s...' % group['group'])
    print
    
    bashCommand = "openstack security group create %s --tenant-id %s --description %s" \
    % (group['group'], group['tenant-id'], group['description'])
    
    print (bashCommand)
    #output = subprocess.check_output(bashCommand, shell=True)
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
        #output = subprocess.check_output(bashCommand, shell=True)
        print

    print 
    print