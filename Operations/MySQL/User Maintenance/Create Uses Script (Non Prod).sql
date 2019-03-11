# Non-Production Users to create

# abenig - SELECT privileges 
DROP USER 'azenith.benig'@'%'; 
CREATE USER 'azenith.benig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `abenig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_POLICY`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `azenith.benig`@`%`;

# agarcia - SELECT privileges 
DROP USER 'angela.garcia'@'%'; 
CREATE USER 'angela.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_POLICY`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `angela.garcia`@`%`;

# chenale - SELECT privileges
DROP USER 'alex.chen'@'%'; 
CREATE USER 'alex.chen'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `alex.chen`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `alex.chen`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `alex.chen`@`%`;

# neelakai - All Privileges
DROP USER 'indu.neelakandan'@'%'; 
CREATE USER 'indu.neelakandan'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT ALL ON *.* TO 'indu.neelakandan'@'%' WITH GRANT OPTION;

# npagupta/npguptas - No privileges
DROP USER 'avinash.gupta'@'%'; 
CREATE USER 'avinash.gupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SUPER ON *.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NEW`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_SIT`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_UAT`.* TO `avinash.gupta`@`%`;
GRANT SELECT ON `FACS_CWU`.* TO `avinash.gupta`@`%`;

# nparslanovs - No privileges
DROP USER 'sasha.arslanov'@'%'; 
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE on *.* TO 'sasha.arslanov'@'%';

# npchewr - All privileges except Grant_priv
DROP USER 'ronny.chew'@'%'; 
CREATE USER 'ronny.chew'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `ronny.chew`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP2`.* TO `ronny.chew`@`%`;

# npfinchj - Select privileges
DROP USER 'jordan.finch'@'%'; 
CREATE USER 'jordan.finch'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `jordan.finch`@`%`;
GRANT SELECT ON `FACS_CWU`.* TO `jordan.finch`@`%`;

# npjakimowiczw - SUPER Privilege
DROP USER 'waldemar.jakimowicz'@'%'; 
CREATE USER 'waldemar.jakimowicz'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SUPER ON *.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP2`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_ETL_DEV`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_ETL_NEW`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_ETL_Staging`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NEW`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_SIT`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_UAT`.* TO `waldemar.jakimowicz`@`%`;

# npkarmudis - All privileges
DROP USER 'sushrut.karmudi'@'%'; 
CREATE USER 'sushrut.karmudi'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sushrut.karmudi`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `sushrut.karmudi`@`%`;

# npmistrya - 
DROP USER 'anand.mistry'@'%'; 
CREATE USER 'anand.mistry'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `anand.mistry`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `anand.mistry`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `anand.mistry`@`%`;

