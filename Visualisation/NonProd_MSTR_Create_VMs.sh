#Create the bootable volumes 
os volume create  NP-MSTR-Intelli-Volume  --image MSTR-Intelli-01_snapshotforduplication-toNP_20171006 --type ceph --description "Bootable root volume for NP-MSTR-Intelli" --project dac --bootable --size 80
os volume create  NP-MSTR-Web-Volume  --image MSTR-Web-01_snapshotforduplication-toNP_20171006 --type ceph --description "Bootable root volume for NP-MSTR-Web" --project dac --bootable --size 80

#Create the additional volume
os volume create  NP-MSTR-Intelli-Volume-Second  --type ceph --description "Additional volume for NP-MSTR-Intelli to seperate cubes" --project dac --size 250

#Create the flavors
os flavor create dac.medium.0disk --ram 32768 --vcpus 4 
os flavor create m1.medium.0disk --ram 4096 --vcpus 2 

#Spin up the NP Intelli VM
os server create NP-MSTR-Intelli --volume NP-MSTR-Intelli-Volume --flavor dac.medium.0disk --availability-zone nasnova:s-nasnova-01 --network Non_Prod_Visual
#Remove the default security group
os server remove security group NP-MSTR-Intelli default
#Attach the secondary volume
os server add volume NP-MSTR-Intelli NP-MSTR-Intelli-Volume-Second

#Spin up the NP Web VM
os server create NP-MSTR-Web --volume NP-MSTR-Web-Volume --flavor m1.medium.0disk --availability-zone nasnova:s-nasnova-01 --network Non_Prod_Visual
#Remove the default security group
os server remove security group NP-MSTR-Web default

#Manually (through the console) detach the VMs from the domain, reboot, rename the VM hostnames, reboot
#Allow them to access the network again by applying security groups

os server add security group NP-MSTR-Web default_security_group
os server add security group NP-MSTR-Web np_viz_security_group
os server add security group NP-MSTR-Intelli default_security_group
os server add security group NP-MSTR-Intelli np_viz_security_group

#Manually (through the console) attach the VM to the domain, reboot - Test RDP
