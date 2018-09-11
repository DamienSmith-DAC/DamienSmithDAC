/*******************************************************************************
-- Create role for external users
-- Must be select privileges only
-- Execute privilege on init connect procedures to be given to LDAP user or role
/*******************************************************************************/

DROP ROLE IF EXISTS dac_external_role;

CREATE ROLE dac_external_role;

GRANT SELECT ON sira_policy.* TO dac_external_role;

GRANT EXECUTE ON PROCEDURE audit.set_resource_group TO dac_external_role;

GRANT EXECUTE ON PROCEDURE audit.audit_user_login TO dac_external_role;
