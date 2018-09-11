CREATE DEFINER=`dac_support`@`%` PROCEDURE `audit_user_login`()
BEGIN
	DECLARE lv_resource_group_name 	VARCHAR(64);
    DECLARE lv_login_user_name     	VARCHAR(32);
    DECLARE lv_set_rg_status		VARCHAR(10);
    
    -- Declare variables to hold diagnostics area information
	DECLARE lv_code 				CHAR(5) DEFAULT '00000';
	DECLARE lv_msg 					TEXT;
	DECLARE lv_rows 				INT;
	DECLARE lv_result 				TEXT;
   
    -- Constants
    DECLARE c_log_error 			varchar(10) DEFAULT 'ERROR';
    DECLARE c_log_info  			varchar(10) DEFAULT 'INFO';
    DECLARE c_connection_id 		bigint(20) unsigned;
    
    -- Error Handler
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
      GET DIAGNOSTICS CONDITION 1
        lv_code = RETURNED_SQLSTATE, lv_msg = MESSAGE_TEXT;
        
	  INSERT INTO operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(),  c_log_error, lv_msg );
        
    END;
    
    INSERT INTO operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(),  c_log_info, 'Start' );
	SET c_connection_id = CONNECTION_ID();
     
	select resource_group
    into  lv_resource_group_name
    from  audit.user_resource_group
    where user_login_name = SUBSTR(user(), 1, LOCATE('@', user()) - 1);
    
    insert into operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(), c_log_info, concat( 'Value:', lv_resource_group_name));
   
    
	if row_count() = 1  then
        
        insert into operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(), c_log_info, concat( 'Resource_group_name:', lv_resource_group_name));
		
		call audit.set_resource_group(lv_resource_group_name, lv_set_rg_status);
        
        insert into operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(), c_log_info, concat( ' value set for lv_set_rg_status:', lv_set_rg_status));
         
        if lv_set_rg_status = 'Success' then
			INSERT INTO audit.user_login_audit 
					(
						connection_id
						, mysql_login_name
						, login_ts
						, resource_group
					)
					SELECT	th.processlist_id
							, user()
							, now()
							, resource_group
					FROM performance_schema.threads th
					WHERE processlist_id = c_connection_id;
        
			INSERT INTO operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(), c_log_info, concat( 'InsertCount for user_login_audit:' , row_count()));
		
			COMMIT;
            
	    else
			insert into operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(),  c_log_info, concat('Status', lv_set_rg_status) );
        end if; -- check lv_set_rg_status
        
     
	END IF;
    

    INSERT INTO operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) values (CONNECTION_ID(), USER(),  c_log_info , 'End');

	COMMIT;
    
    
END