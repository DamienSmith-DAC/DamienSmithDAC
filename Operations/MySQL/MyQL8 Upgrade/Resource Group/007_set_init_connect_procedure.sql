/******************************************************************************
-- Set init connect procedure to assign logged in user to specific resource group

/******************************************************************************/

SET GLOBAL init_connect="CALL audit.audit_user_login()";