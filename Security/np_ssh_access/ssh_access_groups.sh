#Denys specified AD groups from accessing the nodes in datamaster_nodes.txt over ssh.
#NP Edge node is not included in datamaster_nodes.txt
#Locks data and master node to admin access only (NP)

pssh -i -h datamaster_nodes.txt 'sed -i "/UsePAM yes/a DenyGroups dace2_non_prod_external dace2_non_prod_internal" /etc/ssh/sshd_config'
sleep 10
pssh -i -h datamaster_nodes.txt 'sed -i "/UsePAM yes/a AllowGroups dace2_non_prod_admin" /etc/ssh/sshd_config'
sleep 5
pssh -i -h datamaster_nodes.txt service sshd restart
