# Name: openstack_security_groups.py
# Purpose: Take human readable security groups and rules and create them in OpenStack
# Author: Byron Allen, Consultant, Servian
 
import subprocess

#SAMPLE

# Human readable security groups and rules
# Groups and rules in Python dictionaries

# sample_group= {
#                       'tenant-id': 'ID',
#                       'group': 'GROUP_NAME', 
#                       'description': "'DESCRIPTION MUST HAVE SINGLE AND DOUBLE QUOTES'",
#                       'rules':
#                         [
#                           ['PROTOCOL', 'INGRESS/EGRESS', 'MIN_PORT', 'MAX_PORT', 'REMOTE-IP-PREFIX', "'REMOTE-GROUP-ID'"],
#                           ['PROTOCOL', 'INGRESS/EGRESS', 'MIN_PORT', 'MAX_PORT', 'REMOTE-IP-PREFIX', "'REMOTE-GROUP-ID'"]
#                         ]
#                     }

# Option of 'REMOTE-IP-PREFIX' or 'REMOTE-GROUP-ID'
# REMOTE-IP-PREFIX is the source ip or ip range
# REMOTE-GROUP-ID is the name of the same or another security group 

viz_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'viz_security_group', 
                      'description': "'Allow all HTTP and HTTPS in'",
                      'rules':
                        [
                          ['tcp', 'ingress', '80', '80', '0.0.0.0/0', "''"],
                          ['tcp', 'ingress', '443'   , '443', '0.0.0.0/0', "''"]
                        ]
                    }


dp_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'dp_security_group', 
                      'description': "'Allow mysql and sql-server from the Vizualisation subnet'",
                      'rules':
                        [
                          ['tcp', 'ingress', '3306', '3306', "''", 'viz_security_group'],
                          ['tcp', 'ingress', '1433', '1433', "''", 'viz_security_group']
                        ]
                    }

edge_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'edge_security_group', 
                      'description': "'Allow RStudio, Zeppelin, and Jupyter from trusted VPN machines'",
                      'rules':
                        [
                          ['tcp', 'ingress', '8787', '8787', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '9995', '9995', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '8889', '8889', '10.16.66.0/24', "''"]
                        ]
                    }

analytics_security_group= {
                      'tenant-id': '44aa97b1fc4346c0b1c240d550e9627f',
                      'group': 'analytics_security_group', 
                      'description': "'Allow Ambari, Hive Metastore, Hive Web UI, Hive Server, Spark, Spark History Server from trusted VPN machines'",
                      'rules':
                        [
                          ['tcp', 'ingress', '8080', '8080', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '9083', '9083', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '9999', '9999', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '10000', '10000', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '4040', '4040', '10.16.66.0/24', "''"],
                          ['tcp', 'ingress', '18080', '18080', '10.16.66.0/24', "''"]
                        ]
                    }


# List of python dictionaries (i.e. security groups)

list_of_groups=[viz_security_group, dp_security_group, edge_security_group, analytics_security_group]


# Code to parse through dictionaries and generate security groups in OpenStack

for group in list_of_groups:
    
    print 'PRINTING %s...' % group['group']
    print
    
    bashCommand = "neutron security-group-create %s --tenant-id %s --description %s" \
    % (group['group'], group['tenant-id'], group['description'])
    
    print bashCommand
    output = subprocess.check_output(bashCommand, shell=True)
    print

    for i in range(len(group['rules'])):
        
        print 'PRINTING RULE NUMBER %s...' % (i+1)
        print
        bashCommand = """neutron security-group-rule-create %s  \
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

        print bashCommand
        output = subprocess.check_output(bashCommand, shell=True)
        print

    print 
    print