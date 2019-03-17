-- common_data_etl
CREATE USER 'common_data_etl'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `common_data_etl`@`10.74.10.%`;
GRANT SELECT, INSERT, UPDATE, DELETE ON `Common_Data`.* TO `common_data_etl`@`10.74.10.%`;
GRANT SELECT, INSERT ON `ETL_LOG`.* TO `common_data_etl`@`10.74.10.%`;
GRANT USAGE ON *.* TO `common_data_etl`@`localhost`;
GRANT SELECT, INSERT, UPDATE, DELETE ON `Common_Data`.* TO `common_data_etl`@`localhost`;
GRANT SELECT, INSERT ON `ETL_LOG`.* TO `common_data_etl`@`localhost`;


-- paulo.quizon
CREATE USER 'paulo.quizon'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `UCDDX`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `paulo.quizon`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `paulo.quizon`@`%`;


-- sira_ctp
CREATE USER 'sira_ctp'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sira_ctp`@`10.74.10.%`;
GRANT SELECT ON `Common_Data`.* TO `sira_ctp`@`10.74.10.%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sira_ctp`@`10.74.10.%`;
GRANT USAGE ON *.* TO `sira_ctp`@`10.74.32.%`;
GRANT SELECT ON `Common_Data`.* TO `sira_ctp`@`10.74.32.%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sira_ctp`@`10.74.32.%`;
GRANT USAGE ON *.* TO `sira_ctp`@`localhost`;
GRANT SELECT ON `Common_Data`.* TO `sira_ctp`@`localhost`;
GRANT SELECT ON `SIRA_CTP`.* TO `sira_ctp`@`localhost`;


-- suruchi.singh
CREATE USER 'suruchi.singh'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `UCDDX`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `suruchi.singh`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `suruchi.singh`@`%`;


-- waterline_user
CREATE USER 'waterline_user'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `waterline_user`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `waterline_user`@`%`;


-- darjia
CREATE USER 'darjia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `darjia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `darjia`@`%`;


-- ankit.darji
CREATE USER 'ankit.darji'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ankit.darji`@`%`;
GRANT SELECT ON `UCDDX`.* TO `ankit.darji`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `ankit.darji`@`%`;


-- backup_admin
CREATE USER 'backup_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, RELOAD, PROCESS, SUPER, LOCK TABLES, REPLICATION CLIENT, CREATE TABLESPACE ON *.* TO `backup_admin`@`localhost`;


-- sira_hbc
CREATE USER 'sira_hbc'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sira_hbc`@`10.74.10.%`;
GRANT SELECT ON `Common_Data`.* TO `sira_hbc`@`10.74.10.%`;
GRANT SELECT ON `SIRA_HBC`.* TO `sira_hbc`@`10.74.10.%`;
GRANT USAGE ON *.* TO `sira_hbc`@`10.74.32.%`;
GRANT SELECT ON `Common_Data`.* TO `sira_hbc`@`10.74.32.%`;
GRANT SELECT ON `SIRA_HBC`.* TO `sira_hbc`@`10.74.32.%`;
GRANT USAGE ON *.* TO `sira_hbc`@`localhost`;
GRANT SELECT ON `Common_Data`.* TO `sira_hbc`@`localhost`;
GRANT SELECT ON `SIRA_HBC`.* TO `sira_hbc`@`localhost`;


-- abenig
CREATE USER 'abenig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `abenig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `abenig`@`%`;


-- ptchecksum
CREATE USER 'ptchecksum'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, PROCESS, SUPER, REPLICATION SLAVE ON *.* TO `ptchecksum`@`%`;
GRANT ALL PRIVILEGES ON `percona`.* TO `ptchecksum`@`%`;
GRANT SELECT, PROCESS, SUPER, REPLICATION SLAVE ON *.* TO `ptchecksum`@`localhost`;
GRANT ALL PRIVILEGES ON `percona`.* TO `ptchecksum`@`localhost`;


-- phuong.dao
CREATE USER 'phuong.dao'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `phuong.dao`@`%`;
GRANT SELECT ON `UCDDX`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `phuong.dao`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `phuong.dao`@`%`;


-- arslanovs
CREATE USER 'arslanovs'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `arslanovs`@`%`;
GRANT SELECT ON `Common_Data`.* TO `arslanovs`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `arslanovs`@`%`;


-- orchestrator
CREATE USER 'orchestrator'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT RELOAD, PROCESS, SUPER, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO `orchestrator`@`10.74.13.74`;
GRANT SELECT ON `meta`.* TO `orchestrator`@`10.74.13.74`;


-- pythian_ro
CREATE USER 'pythian_ro'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `pythian_ro`@`%`;
GRANT SELECT ON `performance_schema`.* TO `pythian_ro`@`%`;


-- damien.smith
CREATE USER 'damien.smith'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT ON *.* TO `damien.smith`@`%`;


-- sasha.arslanov
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `UCDDX`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `Common_Data`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP_%`.* TO `sasha.arslanov`@`%`;


-- mstr_user
CREATE USER 'mstr_user'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT ON *.* TO `mstr_user`@`%`;


-- sira_etl
CREATE USER 'sira_etl'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sira_etl`@`10.74.%`;
GRANT SELECT, INSERT ON `ETL_LOG`.* TO `sira_etl`@`10.74.%`;
GRANT SELECT, INSERT, UPDATE, DELETE ON `SIRA\_%`.* TO `sira_etl`@`10.74.%`;
GRANT USAGE ON *.* TO `sira_etl`@`localhost`;
GRANT SELECT, INSERT ON `ETL_LOG`.* TO `sira_etl`@`localhost`;
GRANT SELECT, INSERT, UPDATE, DELETE ON `SIRA\_%`.* TO `sira_etl`@`localhost`;


-- newrelic
CREATE USER 'newrelic'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `newrelic`@`localhost`;


-- sstuser
CREATE USER 'sstuser'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT RELOAD, PROCESS, LOCK TABLES, REPLICATION CLIENT ON *.* TO `sstuser`@`localhost`;


-- mstr_history_list_admin
CREATE USER 'mstr_history_list_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_history_list_admin`@`%`;
GRANT ALL PRIVILEGES ON `mstr_history_list`.* TO `mstr_history_list_admin`@`%`;


-- dac_support
CREATE USER 'dac_support'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `dac_support`@`%` WITH GRANT OPTION;
GRANT SELECT ON `sys`.* TO `dac_support`@`%`;
GRANT EXECUTE ON FUNCTION `sys`.`format_time` TO `dac_support`@`%`;


-- mstr_enterprise_manager_admin
CREATE USER 'mstr_enterprise_manager_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_enterprise_manager_admin`@`%`;
GRANT ALL PRIVILEGES ON `mstr_enterprise_manager`.* TO `mstr_enterprise_manager_admin`@`%`;


-- mstr_dataprod_admin
CREATE USER 'mstr_dataprod_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `Common_Data`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `SIRA\_%`.* TO `mstr_dataprod_admin`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `SIRA_HBC`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `SIRA_OS_DRS`.* TO `mstr_dataprod_admin`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_WC`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;


-- haproxy_check
CREATE USER 'haproxy_check'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `haproxy_check`@`10.74.13.%`;


-- sira_qlik
CREATE USER 'sira_qlik'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sira_qlik`@`%`;
GRANT SELECT ON `Common_Data`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sira_qlik`@`%`;


-- replica
CREATE USER 'replica'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO `replica`@`10.74.13.118`;
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO `replica`@`10.74.31.110`;


-- etl_log
CREATE USER 'etl_log'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `etl_log`@`10.74.10.%`;
GRANT SELECT ON `ETL_LOG`.* TO `etl_log`@`10.74.10.%`;
GRANT USAGE ON *.* TO `etl_log`@`10.74.32.%`;
GRANT SELECT ON `ETL_LOG`.* TO `etl_log`@`10.74.32.%`;
GRANT USAGE ON *.* TO `etl_log`@`localhost`;
GRANT SELECT ON `ETL_LOG`.* TO `etl_log`@`localhost`;


-- anand.mistry
CREATE USER 'anand.mistry'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `anand.mistry`@`%`;
GRANT SELECT ON `UCDDX`.* TO `anand.mistry`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `anand.mistry`@`%`;


-- mcbridei
CREATE USER 'mcbridei'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mcbridei`@`%`;


-- azenith.benig
CREATE USER 'azenith.benig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `azenith.benig`@`%`;
GRANT SELECT ON `UCDDX`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP_RECON`.* TO `azenith.benig`@`%`;


-- agarcia
CREATE USER 'agarcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `agarcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `agarcia`@`%`;


-- avinash.gupta
CREATE USER 'avinash.gupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `avinash.gupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP%`.* TO `avinash.gupta`@`%`;


-- angeal.garcia
CREATE USER 'angeal.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angeal.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angeal.garcia`@`%`;


-- sira_wc
CREATE USER 'sira_wc'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sira_wc`@`10.74.10.%`;
GRANT SELECT ON `Common_Data`.* TO `sira_wc`@`10.74.10.%`;
GRANT SELECT ON `SIRA_WC`.* TO `sira_wc`@`10.74.10.%`;
GRANT USAGE ON *.* TO `sira_wc`@`10.74.32.%`;
GRANT SELECT ON `Common_Data`.* TO `sira_wc`@`10.74.32.%`;
GRANT SELECT ON `SIRA_WC`.* TO `sira_wc`@`10.74.32.%`;
GRANT USAGE ON *.* TO `sira_wc`@`localhost`;
GRANT SELECT ON `Common_Data`.* TO `sira_wc`@`localhost`;
GRANT SELECT ON `SIRA_WC`.* TO `sira_wc`@`localhost`;


-- siratalend
CREATE USER 'siratalend'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `siratalend`@`%` WITH GRANT OPTION;
GRANT BACKUP_ADMIN,BINLOG_ADMIN,CONNECTION_ADMIN,ENCRYPTION_KEY_ADMIN,GROUP_REPLICATION_ADMIN,PERSIST_RO_VARIABLES_ADMIN,REPLICATION_SLAVE_ADMIN,RESOURCE_GROUP_ADMIN,RESOURCE_GROUP_USER,ROLE_ADMIN,SET_USER_ID,SYSTEM_VARIABLES_ADMIN,XA_RECOVER_ADMIN ON *.* TO `siratalend`@`%` WITH GRANT OPTION;


