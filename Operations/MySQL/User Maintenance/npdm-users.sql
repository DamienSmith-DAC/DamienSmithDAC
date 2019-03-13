-- npfinchj
CREATE USER 'jordan.finch'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `jordan.finch`@`%`;
GRANT SELECT ON `FACS_CWU`.* TO `jordan.finch`@`%`;


-- nparslanovs
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sasha.arslanov`@`%`;


-- mcbridei
CREATE USER 'ignatius.mcbride'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ignatius.mcbride`@`%`;


-- trant
CREATE USER 'tuan.tran'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `tuan.tran`@`%`;
GRANT USAGE ON *.* TO `tuan.tran`@`%`;


-- agarcia
CREATE USER 'angela.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_POLICY`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `angela.garcia`@`%`;


-- npagupta
CREATE USER 'avinash.gupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SUPER ON *.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NEW`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_SIT`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_UAT`.* TO `avinash.gupta`@`%`;


-- npchewr
CREATE USER 'ronny.chew'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `ronny.chew`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP2`.* TO `ronny.chew`@`%`;


-- npkarmudis
CREATE USER 'sushrut.karmudi'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sushrut.karmudi`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `sushrut.karmudi`@`%`;


-- chenale
CREATE USER 'alex.chen'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `alex.chen`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `alex.chen`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `alex.chen`@`%`;


-- npaguptas
CREATE USER 'avinash.gupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';


-- neelakai
CREATE USER 'indu.neelakandan'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `indu.neelakandan`@`%` WITH GRANT OPTION;


-- npmistrya
CREATE USER 'anand.mistry'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `anand.mistry`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `anand.mistry`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `anand.mistry`@`%`;


-- npjakimowiczw
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


