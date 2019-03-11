# Production SIRA UCD Users to create

# abenig - SELECT Privelege
DROP USER 'azenith.benig'@'%'; 
CREATE USER 'azenith.benig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `azenith.benig`@`%`;
GRANT SELECT ON `UCDDX`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `azenith.benig`@`%`;

# agarcia - SELECT Privelege
DROP USER 'angela.garcia'@'%'; 
CREATE USER 'angela.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angela.garcia`@`%`;
GRANT SELECT ON `UCDDX`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `angela.garcia`@`%`;

#  agupta - All privileges except Grant_priv
DROP USER 'avinash.gupta'@'%'; 
CREATE USER 'avinash.gupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP%`.* TO `avinash.gupta`@`%`;


#  arslanovs - SELECT Privelege
DROP USER 'sasha.arslanov'@'%'; 
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `UCDDX`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `sasha.arslanov`@`%`;

#  chenale - SELECT Privelege
DROP USER 'alex.chen'@'%'; 
CREATE USER 'alex.chen'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `alex.chen`@`%`;
GRANT SELECT ON `UCDDX`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_AUGUST`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_OCTOBER`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_SEPTEMBER`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_OS_DRS`.* TO `alex.chen`@`%`;

#  daop - SELECT Privelege
DROP USER 'phuong.dao'@'%'; 
CREATE USER 'phuong.dao'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `phuong.dao`@`%`;
GRANT SELECT ON `UCDDX`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `phuong.dao`@`%`;

#  darjia - SELECT Privelege
DROP USER 'ankit.darji'@'%'; 
CREATE USER 'ankit.darji'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ankit.darji`@`%`;
GRANT SELECT ON `UCDDX`.* TO `ankit.darji`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `ankit.darji`@`%`;

#  jakimowiczw - All privileges except Grant_priv
DROP USER 'waldemar.jakimowicz'@'%'; 
CREATE USER 'waldemar.jakimowicz'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `waldemar.jakimowicz`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `waldemar.jakimowicz`@`%`;

#  joe.chiu - No Priveleges
DROP USER 'joe.chiu'@'%'; 
CREATE USER 'joe.chiu'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE on *.* TO 'joe.chiu'@'%';

#  mistrya - SELECT Privelege
DROP USER 'anand.mistry'@'%'; 
CREATE USER 'anand.mistry'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `anand.mistry`@`%`;
GRANT SELECT ON `UCDDX`.* TO `anand.mistry`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `anand.mistry`@`%`;

#  quizonp - SELECT Privelege
DROP USER 'paulo.quizon'@'%'; 
CREATE USER 'paulo.quizon'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `UCDDX`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `paulo.quizon`@`%`;

# rchew - No Priveleges
DROP USER 'ronny.chew'@'%'; 
CREATE USER 'ronny.chew'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `ronny.chew`@`%` WITH GRANT OPTION;

# singhs - SELECT Priveleges
DROP USER 'suruchi.singh'@'%'; 
CREATE USER 'suruchi.singh'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `UCDDX`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `suruchi.singh`@`%`;
