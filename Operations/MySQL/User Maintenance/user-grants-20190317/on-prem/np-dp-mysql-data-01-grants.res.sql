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


-- npczyzewskim
CREATE USER 'npczyzewskim'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `npczyzewskim`@`10.74.23.113`;


-- mstr_np_meta_admin
CREATE USER 'mstr_np_meta_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_np_meta_admin`@`%`;
GRANT ALL PRIVILEGES ON `mstr_np_metadata`.* TO `mstr_np_meta_admin`@`%`;
GRANT USAGE ON *.* TO `mstr_np_meta_admin`@`localhost`;
GRANT ALL PRIVILEGES ON `mstr_np_metadata`.* TO `mstr_np_meta_admin`@`localhost`;


-- chenale
CREATE USER 'chenale'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `chenale`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `chenale`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `chenale`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `chenale`@`%`;


-- backup_admin
CREATE USER 'backup_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, LOCK TABLES ON *.* TO `backup_admin`@`localhost`;


-- npcomptonp
CREATE USER 'npcomptonp'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npcomptonp`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX`.* TO `npcomptonp`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `npcomptonp`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `npcomptonp`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_SIT`.* TO `npcomptonp`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_UAT`.* TO `npcomptonp`@`%`;
GRANT ALL PRIVILEGES ON `UCD_INSURER_SUPERVISION_UAT`.* TO `npcomptonp`@`%`;


-- mstr_np_enterprise_manager_admin
CREATE USER 'mstr_np_enterprise_manager_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_np_enterprise_manager_admin`@`%`;
GRANT ALL PRIVILEGES ON `mstr_np_enterprise_manager`.* TO `mstr_np_enterprise_manager_admin`@`%`;


-- abenig
CREATE USER 'abenig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `abenig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `abenig`@`%`;
GRANT SELECT ON `SIRA_POLICY`.* TO `abenig`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `abenig`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `abenig`@`%`;


-- nparslanovs
CREATE USER 'nparslanovs'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `nparslanovs`@`%`;


-- ucd_insurer_uat_ro
CREATE USER 'ucd_insurer_uat_ro'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ucd_insurer_uat_ro`@`%`;
GRANT SELECT ON `UCD_INSURER_SUPERVISION_UAT`.* TO `ucd_insurer_uat_ro`@`%`;


-- npmistrya
CREATE USER 'npmistrya'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npmistrya`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `npmistrya`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `npmistrya`@`%`;


-- mstr_user
CREATE USER 'mstr_user'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT ON *.* TO `mstr_user`@`%`;


-- mstr_reader
CREATE USER 'mstr_reader'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_reader`@`%`;
GRANT SELECT, EXECUTE ON `UCDDX_SIT`.* TO `mstr_reader`@`%`;
GRANT SELECT, EXECUTE ON `UCDDX_UAT`.* TO `mstr_reader`@`%`;


-- npchenale
CREATE USER 'npchenale'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npchenale`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `npchenale`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `npchenale`@`%`;


-- trant
CREATE USER 'trant'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `trant`@`%`;


-- npchewr
CREATE USER 'npchewr'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `npchewr`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP2`.* TO `npchewr`@`%`;


-- dac_support
CREATE USER 'dac_support'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `dac_support`@`%` WITH GRANT OPTION;


-- mstr_dataprod_admin
CREATE USER 'mstr_dataprod_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `Common_Data`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `SIRA\_%`.* TO `mstr_dataprod_admin`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `SIRA_HBC`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `SIRA_WC`.* TO `mstr_dataprod_admin`@`%` WITH GRANT OPTION;


-- sira_qlik
CREATE USER 'sira_qlik'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sira_qlik`@`%`;
GRANT SELECT ON `Common_Data`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sira_qlik`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NEW`.* TO `sira_qlik`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `sira_qlik`@`%`;


-- replica
CREATE USER 'replica'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO `replica`@`10.74.23.111`;


-- npfinchj
CREATE USER 'npfinchj'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npfinchj`@`%`;
GRANT SELECT ON `FACS_CWU`.* TO `npfinchj`@`%`;


-- mcbridei
CREATE USER 'mcbridei'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mcbridei`@`%`;


-- npazevedow
CREATE USER 'npazevedow'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npazevedow`@`%`;
GRANT SELECT ON `FACS_CWU`.* TO `npazevedow`@`%`;


-- npagupta
CREATE USER 'npagupta'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SUPER ON *.* TO `npagupta`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `npagupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `npagupta`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NEW`.* TO `npagupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_SIT`.* TO `npagupta`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_UAT`.* TO `npagupta`@`%`;


-- agarcia
CREATE USER 'agarcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `agarcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `agarcia`@`%`;
GRANT SELECT ON `SIRA_POLICY`.* TO `agarcia`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `agarcia`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `agarcia`@`%`;


-- npguptas
CREATE USER 'npguptas'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npguptas`@`%`;
GRANT SELECT ON `FACS_CWU`.* TO `npguptas`@`%`;


-- npkarmudis
CREATE USER 'npkarmudis'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npkarmudis`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `npkarmudis`@`%`;


-- sira_policy
CREATE USER 'sira_policy'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON *.* TO `sira_policy`@`%` WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON `%`.* TO `sira_policy`@`%` WITH GRANT OPTION;


-- mstr_np_history_list_admin
CREATE USER 'mstr_np_history_list_admin'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `mstr_np_history_list_admin`@`%`;
GRANT ALL PRIVILEGES ON `mstr_np_history_list`.* TO `mstr_np_history_list_admin`@`%`;


-- siratalend
CREATE USER 'siratalend'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP2`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NEW`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_HBC`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_HBC_LOG`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_OS_DRS`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_SIT`.* TO `siratalend`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_UAT`.* TO `siratalend`@`%`;


-- neelakai
CREATE USER 'neelakai'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `neelakai`@`%` WITH GRANT OPTION;


-- npcrescentis
CREATE USER 'npcrescentis'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npcrescentis`@`%`;
GRANT USAGE ON *.* TO `npcrescentis`@`10.74.23.113`;


-- npjakimowiczw
CREATE USER 'npjakimowiczw'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT SUPER ON *.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `ETL_LOG`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP2`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_ETL_DEV`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_ETL_NEW`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_ETL_Staging`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `SIRA_CTP_NEW`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_SIT`.* TO `npjakimowiczw`@`%`;
GRANT ALL PRIVILEGES ON `UCDDX_UAT`.* TO `npjakimowiczw`@`%`;


-- npmcbridei
CREATE USER 'npmcbridei'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `npmcbridei`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `npmcbridei`@`%`;
GRANT SELECT ON `SIRA_CTP_NEW`.* TO `npmcbridei`@`%`;
GRANT SELECT ON `UCDDX_SIT`.* TO `npmcbridei`@`%`;
GRANT SELECT ON `UCDDX_UAT`.* TO `npmcbridei`@`%`;


