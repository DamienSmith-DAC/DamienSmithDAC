# CLUSTER VM INIT

  # Written by Byron Allen, Consultant, Servian, May 2017

  # Purpose:
    # Initialize cluster VMs

  # Assumptions:
    # Signed into and using Azure CLI
    # Password-based authentication
    # Creates CentOS 7.3 VMs
    # --platform-fault-domain-count default is 1
    # --platform-update-domain-count default is 3
    # See variables for other assumptions




# DEFINE VARIABLES

import json
import getpass
import subprocess

print 'Reading env file...'

target = open('anyhadoop/env', 'r')
vars = [x.replace('\n', '') for x in target]
for var in vars:
    if var.startswith('vendor=') == True:
        vendor=var.split('=')[1]
    if var.startswith('cloud=') == True:
        cloud=var.split('=')[1]
    if var.startswith('resource_group=') == True:
        resource_group=var.split('=')[1]    
    if var.startswith('new_resource_group=') == True:
        new_resource_group=var.split('=')[1]    
    if var.startswith('location=') == True:
        location=var.split('=')[1]
    if var.startswith('vm_image=') == True:
        vm_image=var.split('=')[1]
    if var.startswith('non_root_user=') == True:
        non_root_user=var.split('=')[1]
    if var.startswith('storage=') == True:
        storage=var.split('=')[1]
    if var.startswith('master_nsg=') == True:
        master_nsg=var.split('=')[1]
    if var.startswith('data_nsg=') == True:
        data_nsg=var.split('=')[1]
    if var.startswith('edge_nsg=') == True:
        edge_nsg=var.split('=')[1]
    if var.startswith('vnet=') == True:
        vnet=var.split('=')[1]
    if var.startswith('subnet=') == True:
        subnet=var.split('=')[1]
    if var.startswith('master_as=') == True:
        master_as=var.split('=')[1]
    if var.startswith('data_as=') == True:
        data_as=var.split('=')[1]
    if var.startswith('edge_as=') == True:
        edge_as=var.split('=')[1]
    if var.startswith('number_master_nodes=') == True:
        number_master_nodes=var.split('=')[1]
    if var.startswith('number_data_nodes=') == True:
        number_data_nodes=var.split('=')[1]
    if var.startswith('number_edge_nodes=') == True:
        number_edge_nodes=var.split('=')[1]
    if var.startswith('master_size=') == True:
        master_size=var.split('=')[1]
    if var.startswith('data_size=') == True:
        data_size=var.split('=')[1]
    if var.startswith('edge_size=') == True:
        edge_size=var.split('=')[1]
    if var.startswith('zeppelin=') == True:
        zeppelin=var.split('=')[1]
    if var.startswith('cdsw=') == True:
        cdsw=var.split('=')[1]
    if var.startswith('cdsw_nsg=') == True:
        cdsw_nsg=var.split('=')[1]
    if var.startswith('cdsw_as=') == True:
        cdsw_as=var.split('=')[1]
    if var.startswith('cdsw_size=') == True:
        cdsw_size=var.split('=')[1]
    if var.startswith('master_disk_sizes_gb=') == True:
        master_disk_sizes_gb=var.split('=')[1]
    if var.startswith('data_disk_sizes_gb=') == True:
        data_disk_sizes_gb=var.split('=')[1]
    if var.startswith('edge_disk_sizes_gb=') == True:
        edge_disk_sizes_gb=var.split('=')[1]

authentication='password'
ip_allocation='static'
pd=getpass.getpass("Create your password. Make sure you remember it: ")

print 'need to ensure password meets microsoft standard'

bashCommand = "rm -rf ~/anyhadoop/clusters/%s" % resource_group
output = subprocess.check_output(bashCommand, shell=True)

bashCommand = "mkdir ~/anyhadoop/clusters/%s" % resource_group
output = subprocess.check_output(bashCommand, shell=True)

bashCommand = "touch ~/anyhadoop/clusters/%s/non_root_user" % resource_group
output = subprocess.check_output(bashCommand, shell=True)

bashCommand = "echo %s > ~/anyhadoop/clusters/%s/non_root_user" % (non_root_user, resource_group)
output = subprocess.check_output(bashCommand, shell=True)

private_ips=[]
hosts=[]
fqdns=[]
public_ips=[]


# CREATE RESOURCE GROUP

print 'Creating resource group...'

if new_resource_group.lower() == 'true':
    bashCommand = "az group create --location %s --name %s" % (location, resource_group)
    output = subprocess.check_output(bashCommand, shell=True) 


# CREATE NSGs
print 'Creating network security groups...'

#master_nsg
bashCommand = '''
              az network nsg create --name %s \
                                    --resource-group %s 
                                    ''' % (master_nsg, resource_group)

output = subprocess.check_output(bashCommand, shell=True)

#data_nsg
if data_nsg != master_nsg:
  bashCommand = '''
                az network nsg create --name %s \
                                      --resource-group %s 
                                      ''' % (data_nsg, resource_group)
  output = subprocess.check_output(bashCommand, shell=True)

#edge_nsg
if edge_nsg != master_nsg:
  if edge_nsg != data_nsg:
    bashCommand = '''
                  az network nsg create --name %s \
                                        --resource-group %s 
                                        ''' % (edge_nsg, resource_group)
    output = subprocess.check_output(bashCommand, shell=True)


# CREATE MASTER NODES

print 'Creating master nodes...'

if int(number_master_nodes) > 0:

    bashCommand =   '''
                    az vm availability-set create \
                            --resource-group %s \
                            --location %s \
                            --name %s \
                            --platform-fault-domain-count 2 \
                            --platform-update-domain-count 5
                    ''' % (resource_group, location, master_as)
    output = subprocess.check_output(bashCommand, shell=True)

    for i in range(int(number_master_nodes)):

        name=resource_group + 'master' + str(i) 
        #name=resource_group + 'master' + str(i+1) # for testing purposes
        #print 'line added for testing purposes... remove before committing'

        bashCommand =   '''
                        az vm create \
                        	--resource-group %s  \
                        	--name %s \
                        	--location %s  \
                        	--image %s  \
                        	--authentication-type %s  \
                        	--admin-username %s  \
                        	--admin-password %s  \
                        	--storage-sku %s  \
                        	--public-ip-address-allocation %s  \
                        	--nsg %s  \
                        	--vnet-name %s  \
                        	--subnet %s  \
                        	--public-ip-address-dns-name %s  \
                        	--availability-set %s \
                          --size %s \
                          --data-disk-sizes-gb %s
                        ''' % (resource_group, 
                               name, 
                               location, 
                               vm_image, 
                               authentication, 
                               non_root_user, 
                               pd, 
                               storage, 
                               ip_allocation,
                               master_nsg,
                               vnet,
                               subnet,
                               name,
                               master_as,
                               master_size,
                               master_disk_sizes_gb)
        output = subprocess.check_output(bashCommand, shell=True)

        data = json.loads(output)
        fqdns.append(data['fqdns'])
        hosts.append(data['fqdns'].split('.')[0])
        public_ips.append(data['publicIpAddress'])
        private_ips.append(data['privateIpAddress'])
        
        if i == 0:
            
            ## specify master host
            #
            #bashCommand = 'touch ~/anyhadoop/clusters/%s/master' % resource_group
            #output = subprocess.check_output(bashCommand, shell=True) 
            #
            #target = open('anyhadoop/clusters/%s/master' % resource_group, 'w')
            #target.truncate()
            #
            #target.write(hosts[0])
            #target.write("\n")
            #
            #target.close()

            bashCommand = "touch ~/anyhadoop/clusters/%s/.pd" % resource_group
            output = subprocess.check_output(bashCommand, shell=True)

            bashCommand = "echo %s > ~/anyhadoop/clusters/%s/.pd" % (pd, resource_group)
            output = subprocess.check_output(bashCommand, shell=True)


# CREATE DATA NODES

print 'Creating data nodes...'

if int(number_data_nodes) > 0:

    bashCommand =   '''
                    az vm availability-set create \
                            --resource-group %s \
                            --location %s \
                            --name %s \
                            --platform-fault-domain-count 2 \
                            --platform-update-domain-count 5
                    ''' % (resource_group, location, data_as)
    output = subprocess.check_output(bashCommand, shell=True)

    for i in range(int(number_data_nodes)):

        name=resource_group + 'data' + str(i)

        bashCommand =   '''
                        az vm create \
                            --resource-group %s  \
                            --name %s \
                            --location %s  \
                            --image %s  \
                            --authentication-type %s  \
                            --admin-username %s  \
                            --admin-password %s  \
                            --storage-sku %s  \
                            --public-ip-address-allocation %s  \
                            --nsg %s  \
                            --vnet-name %s  \
                            --subnet %s  \
                            --public-ip-address-dns-name %s  \
                            --availability-set %s \
                            --size %s \
                            --data-disk-sizes-gb %s
                        ''' % (resource_group, 
                               name, 
                               location, 
                               vm_image, 
                               authentication, 
                               non_root_user, 
                               pd, 
                               storage, 
                               ip_allocation,
                               data_nsg,
                               vnet,
                               subnet,
                               name,
                               data_as,
                               data_size,
                               data_disk_sizes_gb)
        output = subprocess.check_output(bashCommand, shell=True)

        data = json.loads(output)
        fqdns.append(data['fqdns'])
        hosts.append(data['fqdns'].split('.')[0])
        public_ips.append(data['publicIpAddress'])
        private_ips.append(data['privateIpAddress'])




# CREATE EDGE NODES

print 'Creating edge nodes...'

if int(number_edge_nodes) > 0:

    bashCommand =   '''
                    az vm availability-set create \
                            --resource-group %s \
                            --location %s \
                            --name %s \
                            --platform-fault-domain-count 2 \
                            --platform-update-domain-count 5
                    ''' % (resource_group, location, edge_as)
    output = subprocess.check_output(bashCommand, shell=True)

    for i in range(int(number_edge_nodes)):

        name=resource_group + 'edge' + str(i)

        bashCommand =   '''
                        az vm create \
                            --resource-group %s  \
                            --name %s \
                            --location %s  \
                            --image %s  \
                            --authentication-type %s  \
                            --admin-username %s  \
                            --admin-password %s  \
                            --storage-sku %s  \
                            --public-ip-address-allocation %s  \
                            --nsg %s  \
                            --vnet-name %s  \
                            --subnet %s  \
                            --public-ip-address-dns-name %s  \
                            --availability-set %s \
                            --size %s \
                            --data-disk-sizes-gb %s
                        ''' % (resource_group, 
                               name, 
                               location, 
                               vm_image, 
                               authentication, 
                               non_root_user, 
                               pd, 
                               storage, 
                               ip_allocation,
                               edge_nsg,
                               vnet,
                               subnet,
                               name,
                               edge_as,
                               edge_size,
                               edge_disk_sizes_gb)
        output = subprocess.check_output(bashCommand, shell=True)

        data = json.loads(output)
        fqdns.append(data['fqdns'])
        hosts.append(data['fqdns'].split('.')[0])
        public_ips.append(data['publicIpAddress'])
        private_ips.append(data['privateIpAddress'])




# CREATE CDSW NODE

if cdsw == 'true':

    print 'Creating cdsw node...'

    bashCommand =   '''
                    az vm availability-set create \
                            --resource-group %s \
                            --location %s \
                            --name %s \
                            --platform-fault-domain-count 2 \
                            --platform-update-domain-count 5
                    ''' % (resource_group, location, cdsw_as)
    output = subprocess.check_output(bashCommand, shell=True)

    for i in range(int(number_edge_nodes)):

        name=resource_group + 'cdsw' + str(i)

        bashCommand =   '''
                        az vm create \
                            --resource-group %s  \
                            --name %s \
                            --location %s  \
                            --image %s  \
                            --authentication-type %s  \
                            --admin-username %s  \
                            --admin-password %s  \
                            --storage-sku %s  \
                            --public-ip-address-allocation %s  \
                            --nsg %s  \
                            --vnet-name %s  \
                            --subnet %s  \
                            --public-ip-address-dns-name %s  \
                            --availability-set %s \
                            --size %s \
                            --data-disk-sizes-gb %s
                        ''' % (resource_group, 
                               name, 
                               location, 
                               vm_image, 
                               authentication, 
                               non_root_user, 
                               pd, 
                               storage, 
                               ip_allocation,
                               cdsw_nsg,
                               vnet,
                               subnet,
                               name,
                               cdsw_as,
                               cdsw_size,
                               cdsw_disk_sizes_gb)
        output = subprocess.check_output(bashCommand, shell=True)

        data = json.loads(output)
        fqdns.append(data['fqdns'])
        hosts.append(data['fqdns'].split('.')[0])
        public_ips.append(data['publicIpAddress'])
        private_ips.append(data['privateIpAddress'])

# GENERATE HOSTS FILE

print 'Creating hosts file...'

host_details_zip = zip(private_ips, fqdns, hosts)
            
bashCommand = ' touch ~/anyhadoop/clusters/%s/hosts' % resource_group
output = subprocess.check_output(bashCommand, shell=True) 

target = open('anyhadoop/clusters/%s/hosts' % resource_group, 'w')
target.write('127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4')
target.write("\n")

for x in host_details_zip:
    
    target.write(str(' '.join(x)))
    target.write("\n")

target.close()




# GENERATE PUBLIC_IPS FILE

print 'Creating public ips file...'

host_details_zip = zip(public_ips, hosts)

bashCommand = ' touch ~/anyhadoop/clusters/%s/public_ips' % resource_group
output = subprocess.check_output(bashCommand, shell=True) 

target = open('anyhadoop/clusters/%s/public_ips' % resource_group, 'w')
target.truncate()

for x in host_details_zip:
    
    target.write(str(' '.join(x)))
    target.write("\n")

target.close()




# GENERATE PRIVATE_IPS FILE

print 'Creating private ips file...'

bashCommand = ' touch ~/anyhadoop/clusters/%s/private_ips' % resource_group
output = subprocess.check_output(bashCommand, shell=True) 

target = open('anyhadoop/clusters/%s/private_ips' % resource_group, 'w')
target.truncate()

for ip in private_ips:
    
    target.write(ip)
    target.write("\n")

target.close()

print '...completed cluster_vm_init.py'
