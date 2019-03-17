-- percona_checksum
CREATE USER 'percona_checksum'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, PROCESS, SUPER, REPLICATION SLAVE ON *.* TO `percona_checksum`@`%`;
GRANT ALL PRIVILEGES ON `percona`.* TO `percona_checksum`@`%`;


-- paulo.quizon
CREATE USER 'paulo.quizon'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `UCDDX`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `paulo.quizon`@`%`;


-- suruchi.singh
CREATE USER 'suruchi.singh'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `UCDDX`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `suruchi.singh`@`%`;


-- waterline_user
CREATE USER 'waterline_user'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `waterline_user`@`%`;
GRANT SELECT ON `UCDDX`.* TO `waterline_user`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `waterline_user`@`%`;
GRANT SELECT ON `UCDDX`.`Accident` TO `waterline_user`@`%`;
GRANT SELECT ON `UCDDX`.`Claim` TO `waterline_user`@`%`;


-- singhs
CREATE USER 'singhs'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `singhs`@`%`;
GRANT SELECT ON `UCDDX`.* TO `singhs`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `singhs`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `singhs`@`%`;


-- rchew
CREATE USER 'rchew'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `rchew`@`%` WITH GRANT OPTION;


-- jakimowiczw
CREATE USER 'jakimowiczw'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `jakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `jakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `jakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `jakimowiczw`@`%`;


-- darjia
CREATE USER 'darjia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `darjia`@`%`;
GRANT SELECT ON `UCDDX`.* TO `darjia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `darjia`@`%`;


-- ankit.darji
CREATE USER 'ankit.darji'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ankit.darji`@`%`;
GRANT SELECT ON `UCDDX`.* TO `ankit.darji`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `ankit.darji`@`%`;


-- chenale
CREATE USER 'chenale'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `chenale`@`%`;
GRANT SELECT ON `UCDDX`.* TO `chenale`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `chenale`@`%`;
GRANT SELECT ON `SIRA_CTP_AUGUST`.* TO `chenale`@`%`;
GRANT SELECT ON `SIRA_CTP_OCTOBER`.* TO `chenale`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `chenale`@`%`;
GRANT SELECT ON `SIRA_CTP_SEPTEMBER`.* TO `chenale`@`%`;
GRANT SELECT ON `SIRA_OS_DRS`.* TO `chenale`@`%`;


-- angela.garcia
CREATE USER 'angela.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angela.garcia`@`%`;
GRANT SELECT ON `UCDDX`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `angela.garcia`@`%`;


-- mstr_meta_admin
CREATE USER 'mstr_meta_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_meta_admin`@`10.74.31.%`;
GRANT ALL PRIVILEGES ON `mstr_metadata`.* TO `mstr_meta_admin`@`10.74.31.%`;
GRANT USAGE ON *.* TO `mstr_meta_admin`@`10.74.32.%`;
GRANT ALL PRIVILEGES ON `mstr_metadata`.* TO `mstr_meta_admin`@`10.74.32.%`;


-- abenig
CREATE USER 'abenig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `abenig`@`%`;
GRANT SELECT ON `UCDDX`.* TO `abenig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `abenig`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `abenig`@`%`;


-- phuong.dao
CREATE USER 'phuong.dao'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `phuong.dao`@`%`;
GRANT SELECT ON `UCDDX`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `phuong.dao`@`%`;


-- arslanovs
CREATE USER 'arslanovs'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `arslanovs`@`%`;
GRANT SELECT ON `UCDDX`.* TO `arslanovs`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `arslanovs`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `arslanovs`@`%`;


-- alex.chen
CREATE USER 'alex.chen'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `alex.chen`@`%`;
GRANT SELECT ON `UCDDX`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_AUGUST`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_OCTOBER`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_CTP_SEPTEMBER`.* TO `alex.chen`@`%`;
GRANT SELECT ON `SIRA_OS_DRS`.* TO `alex.chen`@`%`;


-- damien.smith
CREATE USER 'damien.smith'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT ON *.* TO `damien.smith`@`%`;


-- sasha.arslanov
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `UCDDX`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `sasha.arslanov`@`%`;


-- daop
CREATE USER 'daop'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `daop`@`%`;
GRANT SELECT ON `UCDDX`.* TO `daop`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `daop`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `daop`@`%`;


-- mstr_reader
CREATE USER 'mstr_reader'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_reader`@`10.74.31.%`;
GRANT SELECT ON `CTP`.* TO `mstr_reader`@`10.74.31.%`;
GRANT SELECT ON `SIRACTP`.* TO `mstr_reader`@`10.74.31.%`;
GRANT SELECT ON `UCDDX`.* TO `mstr_reader`@`10.74.31.%`;
GRANT SELECT ON `SIRA_CTP`.* TO `mstr_reader`@`10.74.31.%`;
GRANT USAGE ON *.* TO `mstr_reader`@`10.74.32.%`;
GRANT SELECT ON `CTP`.* TO `mstr_reader`@`10.74.32.%`;
GRANT SELECT ON `SIRACTP`.* TO `mstr_reader`@`10.74.32.%`;
GRANT SELECT, EXECUTE ON `UCDDX`.* TO `mstr_reader`@`10.74.32.%`;
GRANT SELECT ON `SIRA_CTP`.* TO `mstr_reader`@`10.74.32.%`;


-- mstr_history_list_admin
CREATE USER 'mstr_history_list_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_history_list_admin`@`10.74.31.%`;
GRANT ALL PRIVILEGES ON `mstr_history_list`.* TO `mstr_history_list_admin`@`10.74.31.%`;
GRANT USAGE ON *.* TO `mstr_history_list_admin`@`10.74.32.%`;
GRANT ALL PRIVILEGES ON `mstr_history_list`.* TO `mstr_history_list_admin`@`10.74.32.%`;


-- dac_support
CREATE USER 'dac_support'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `dac_support`@`%` WITH GRANT OPTION;


-- mstr_enterprise_manager_admin
CREATE USER 'mstr_enterprise_manager_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_enterprise_manager_admin`@`10.74.31.%`;
GRANT ALL PRIVILEGES ON `mstr_enterprise_manager`.* TO `mstr_enterprise_manager_admin`@`10.74.31.%`;
GRANT USAGE ON *.* TO `mstr_enterprise_manager_admin`@`10.74.32.%`;
GRANT ALL PRIVILEGES ON `mstr_enterprise_manager`.* TO `mstr_enterprise_manager_admin`@`10.74.32.%`;


-- mstr_dataprod_admin
CREATE USER 'mstr_dataprod_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `SIRA_OS_DRS`.* TO `mstr_dataprod_admin`@`%`;


-- sira_qlik
CREATE USER 'sira_qlik'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sira_qlik`@`%`;
GRANT SELECT ON `UCDDX`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_AUGUST`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_JULY`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_JUNE`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_NOVEMBER`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_OCTOBER`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP_SEPTEMBER`.* TO `sira_qlik`@`%`;


-- replica
CREATE USER 'replica'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO `replica`@`10.74.31.105`;
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO `replica`@`10.74.31.110`;


-- quizonp
CREATE USER 'quizonp'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `quizonp`@`%`;
GRANT SELECT ON `UCDDX`.* TO `quizonp`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `quizonp`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `quizonp`@`%`;


-- mistrya
CREATE USER 'mistrya'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mistrya`@`%`;
GRANT SELECT ON `UCDDX`.* TO `mistrya`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `mistrya`@`%`;


-- anand.mistry
CREATE USER 'anand.mistry'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `anand.mistry`@`%`;
GRANT SELECT ON `UCDDX`.* TO `anand.mistry`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `anand.mistry`@`%`;


-- mcbridei
CREATE USER 'mcbridei'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mcbridei`@`%`;
GRANT SELECT ON `UCDDX`.* TO `mcbridei`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `mcbridei`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `mcbridei`@`%`;


-- azenith.benig
CREATE USER 'azenith.benig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `azenith.benig`@`%`;
GRANT SELECT ON `UCDDX`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `azenith.benig`@`%`;


-- agarcia
CREATE USER 'agarcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `agarcia`@`%`;
GRANT SELECT ON `UCDDX`.* TO `agarcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `agarcia`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `agarcia`@`%`;


-- avinash.gupta
CREATE USER 'avinash.gupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP%`.* TO `avinash.gupta`@`%`;


-- siratalend
CREATE USER 'siratalend'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRACTP`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `NP_ETL_LOG`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP2`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_AUGUST`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_JULY`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_JUNE`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NOVEMBER`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_OCTOBER`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_RECON`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_SEPTEMBER`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_OS_DRS`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRADX`.`SIRADX` TO `siratalend`@`%`;


-- agupta
CREATE USER 'agupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `agupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `agupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `agupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `agupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP%`.* TO `agupta`@`%`;


