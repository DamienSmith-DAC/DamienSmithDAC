/*********************************************************************
-- Create one resource group for external user access
-- This resource group is set to low priority.
/**********************************************************************/
 DROP RESOURCE GROUP dac_prod_mysql_external;
 
 CREATE RESOURCE GROUP dac_prod_mysql_external
  TYPE = USER
  VCPU = 5-7           
  THREAD_PRIORITY = 16; 
  
/************************************************************************
-- Create audit database
-- create tables required for user audits
/************************************************************************/  
DROP DATABASE  IF EXISTS audit;

CREATE DATABASE audit;

USE audit;

DROP TABLE IF EXISTS user_resource_group;

CREATE TABLE user_resource_group
(  user_login_name				VARCHAR(32) NOT NULL PRIMARY KEY
 , resource_group               VARCHAR(64) NOT NULL  
 , created_date 				TIMESTAMP 	DEFAULT CURRENT_TIMESTAMP
 );  
 
INSERT INTO user_resource_group (user_login_name, resource_group)
VALUES ('testsimple', 'dac_prod_mysql_external');

COMMIT;

DROP TABLE  IF EXISTS user_login_audit;

CREATE TABLE user_login_audit
( connection_id      			INT UNSIGNED 	NOT NULL DEFAULT 0
, mysql_login_name     			VARCHAR(64) 	NOT NULL DEFAULT 'unknown'
, login_ts       				DATETIME  		NOT NULL DEFAULT CURRENT_TIMESTAMP
, logout_ts      				DATETIME  		NULL  
, resource_group    			VARCHAR(64)
, PRIMARY KEY (connection_id, mysql_login_name,login_ts)
)
   PARTITION BY RANGE( YEAR(login_ts) ) 
   SUBPARTITION BY HASH( MONTH(login_ts) ) SUBPARTITIONS 12  
  ( 
	 PARTITION p_2018 VALUES LESS THAN (2019)
    ,PARTITION p_2019 VALUES LESS THAN (2020)
	,PARTITION p_2020 VALUES LESS THAN (2021)
	,PARTITION p_2021 VALUES LESS THAN (2022)
	,PARTITION p_2022 VALUES LESS THAN (2023)
	,PARTITION p_max VALUES LESS THAN MAXVALUE  
  ); 

/*
Cannot have FK on partitioned table
ALTER TABLE user_resource_login ADD CONSTRAINT user_resource_login_fk1 FOREIGN KEY (user_login_name) REFERENCES user_resource_group (user_login_name);
ALTER TABLE user_resource_login ADD CONSTRAINT user_resource_login_fk2 FOREIGN KEY (resource_group) REFERENCES user_resource_group (resource_group);

Error Code: 1506. Foreign keys are not yet supported in conjunction with partitioning

*/
