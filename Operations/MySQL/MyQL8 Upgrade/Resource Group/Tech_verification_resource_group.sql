-- Check system table
select *
 from information_schema.resource_groups;
 
-- Check config table 
 select *
 from audit.user_resource_group; 
 
-- connect as  user using LDAP password
mysql --enable-cleartext-plugin -u testsimple -p

-- Check logs
select processlist_id, processlist_user, resource_group
 from performance_schema.threads;
 
select *
from operation_support.db_log;

select *
from audit.user_login_audit; 
 
 
