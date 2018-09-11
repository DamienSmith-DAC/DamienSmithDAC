CREATE DEFINER=`dac_support`@`%` PROCEDURE `set_resource_group`(
										 IN  p_in_resource_group_name VARCHAR(64)
									    ,OUT p_out_status			  VARCHAR(10)
									  )
BEGIN
      -- Constants
    DECLARE c_log_error 			VARCHAR(10) DEFAULT 'ERROR';
    DECLARE c_log_info  			VARCHAR(10) DEFAULT 'INFO';
    DECLARE lv_set_status 			VARCHAR(10) DEFAULT 'Not Set';
   
   INSERT INTO operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) VALUES (CONNECTION_ID(), USER(), c_log_info, concat('Incoming resource_group_name', p_in_resource_group_name) );
 
    
   IF (p_in_resource_group_name = 'dac_prod_mysql_external') THEN
   
        SET RESOURCE GROUP dac_prod_mysql_external;
                 
        SET p_out_status = 'Success';
 
    ELSE
    
		SET p_out_status =  'Not Set'; 
        
    END IF;
    
   INSERT INTO operation_support.db_log (connection_id, mysql_login_name, log_type, log_message) VALUES (CONNECTION_ID(), USER(), c_log_info, concat(' Set RG Staus: ', p_out_status) );

    
END