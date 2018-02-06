USE `operation_support`;
DROP procedure IF EXISTS `create_dataproduct_user`;

DELIMITER $$
USE `operation_support`$$
CREATE  PROCEDURE `create_dataproduct_user`(IN p_ad_user_name VARCHAR(45))
BEGIN

    DECLARE host_name  CHAR(50) DEFAULT '@\'%\'';
	DECLARE user_name  CHAR(30);
	DECLARE user_pwd   CHAR(30);
	DECLARE sql_stmt   BLOB;
    DECLARE gr_stmt	   BLOB;
	
	
		
    SET user_name := CONCAT('\'', REPLACE(TRIM(p_ad_user_name), CHAR(39), CONCAT(CHAR(92), CHAR(39))), '\'');
	
    SET user_pwd  := CONCAT('\'',REPLACE(CONCAT(upper(substr(p_ad_user_name, 1,1)), substr(p_ad_user_name, 2), '#10'), CHAR(39), ''), '\'');
    
    SET @sql_stmt :=  CONCAT('create user ',user_name, host_name, ' identified by ',user_pwd ,';'  );
    
    PREPARE create_stmt from @sql_stmt;
	SELECT @sql_stmt;
    EXECUTE create_stmt;     
  
    DEALLOCATE PREPARE create_stmt;
	
    FLUSH PRIVILEGES;
    
END$$

DELIMITER ;

