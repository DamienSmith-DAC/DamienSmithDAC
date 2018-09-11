/*******************************************************************************************************
-- create sample user
-- user must exist in LDAP server and assigned to correct AD group; user name must match LDAP name
/*******************************************************************************************************/
CREATE USER testsimple@'%' IDENTIFIED WITH authentication_pam AS 'mysql' DEFAULT ROLE dac_external_role;

SET DEFAULT ROLE dac_external_role to testsimple@'%';