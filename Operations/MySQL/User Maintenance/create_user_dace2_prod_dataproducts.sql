#############################################################################
#-- user creation script for Data Products MySQL instances
#-- Usage:
#   Backup_admin - user to create backup
#	dac_support  - user for database support activities; read only user
#############################################################################

create user 'backup_admin'@'localhost' identified by <password from lastpass>;

grant select, insert, update, reload, process, super, lock tables, replication client, create tablespace on *.* to 'backup_admin'@'localhost';

create user 'dac_support'@'%' identified by <password from lastpass>;

grant select on *.* to 'dac_support'@'%';
