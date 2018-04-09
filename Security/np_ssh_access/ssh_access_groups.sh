#Denys specified AD groups from accessing the nodes in datamaster_nodes.txt over ssh.
#NP Edge node is not included in datamaster_nodes.txt
#Users in dace2_non_prod_external and internal cannot access the data and master nodes

pssh -i -h datamaster_nodes.txt 'sed -i "/UsePAM yes/a AllowGroups dace2_non_prod_external dace2_non_prod_internal root" /etc/ssh/sshd_config'
sleep 5
pssh -i -h datamaster_nodes.txt service sshd restart
