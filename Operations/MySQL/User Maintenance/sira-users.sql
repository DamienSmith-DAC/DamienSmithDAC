-- quizonp
CREATE USER 'paulo.quizon'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `UCDDX`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `paulo.quizon`@`%`;


-- mistrya
CREATE USER 'anand.mistry'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `anand.mistry`@`%`;
GRANT SELECT ON `UCDDX`.* TO `anand.mistry`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `anand.mistry`@`%`;


-- abenig
CREATE USER 'azenith.benig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `azenith.benig`@`%`;
GRANT SELECT ON `UCDDX`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `azenith.benig`@`%`;


-- singhs
CREATE USER 'suruchi.singh'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `UCDDX`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `suruchi.singh`@`%`;


-- rchew
CREATE USER 'ronny.chew'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLE, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP OLE ON *.* TO `ronny.chew`@`%` WITH GRANT OPTION;


-- jakimowiczw
CREATE USER 'waldemar.jakimowicz'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `waldemar.jakimowicz`@`%`;


-- arslanovs
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `UCDDX`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `sasha.arslanov`@`%`;


-- agarcia
CREATE USER 'angela.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angela.garcia`@`%`;
GRANT SELECT ON `UCDDX`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `angela.garcia`@`%`;


-- darjia
CREATE USER 'ankit.darji'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ankit.darji`@`%`;
GRANT SELECT ON `UCDDX`.* TO `ankit.darji`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `ankit.darji`@`%`;


-- chenale
CREATE USER 'alex.chen'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `alex.chen`@`%`;
GRANT SELECT ON `UCDDX`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_AUGUST`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_OCTOBER`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_SEPTEMBER`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_OS_DRS`.* TO `alex.chen`@`%`;


-- agupta
CREATE USER 'avinash.gupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP%`.* TO `avinash.gupta`@`%`;


-- daop
CREATE USER 'phuong.dao'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `phuong.dao`@`%`;
GRANT SELECT ON `UCDDX`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `phuong.dao`@`%`;


