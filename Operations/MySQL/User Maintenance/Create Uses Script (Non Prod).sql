# Non-Production Users to create

# abenig - SELECT privileges 
DROP USER 'Azenith.Benig'@'%'; 
CREATE USER 'Azenith.Benig'@'%' IDENTIFIED BY "',@pass_word,'";
GRANT SELECT on *.* TO 'Azenith.Benig'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# agarcia - SELECT privileges 
DROP USER 'Angela.Garcia'@'%'; 
CREATE USER 'Angela.Garcia'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Angela.Garcia'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# chenale - SELECT privileges
DROP USER 'Alex.Chen'@'%'; 
CREATE USER 'Alex.Chen'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Alex.Chen'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# neelakai - All Privileges
DROP USER 'Indu.Neelakandan'@'%'; 
CREATE USER 'Indu.Neelakandan'@'%' IDENTIFIED BY 'Password#123';
GRANT ALL ON *.* TO 'Indu.Neelakandan'@'%';

# npagupta/npguptas - No privileges
DROP USER 'Avinash.Gupta'@'%'; 
CREATE USER 'Avinash.Gupta'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'Avinash.Gupta'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# nparslanovs - No privileges
DROP USER 'Sasha.Arslanov'@'%'; 
CREATE USER 'Sasha.Arslanov'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'Avinash.Gupta'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# npchewr - All privileges except Grant_priv
DROP USER 'Ronny.Chew'@'%'; 
CREATE USER 'Ronny.Chew'@'%' IDENTIFIED BY 'Password#123';
GRANT CREATE USER,
CREATE VIEW,
DELETE,
DROP,
EVENT,
EXECUTE,
FILE,
INDEX,
INSERT,
LOCK TABLES,
PROCESS,
PROXY,
REFERENCES,
RELOAD,
REPLICATION CLIENT,
REPLICATION SLAVE,
SELECT,
SHOW DATABASES,
SHOW VIEW,
SHUTDOWN,
SUPER,
TRIGGER,
UPDATE,
USAGE
 on *.* TO 'Avinash.Gupta'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# npfinchj - No privileges
DROP USER 'Jordan.Finch'@'%'; 
CREATE USER 'Jordan.Finch'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'Jordan.Finch'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# npjakimowiczw - SUPER Privilege
DROP USER 'Waldemar.Jakimowicz'@'%'; 
CREATE USER 'Waldemar.Jakimowicz'@'%' IDENTIFIED BY 'Password#123';
GRANT SUPER on *.* TO 'Waldemar.Jakimowicz'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# npkarmudis - No privileges
DROP USER 'Sushrut.karmudi'@'%'; 
CREATE USER 'Sushrut.karmudi'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'Sushrut.karmudi'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# npmistrya - 
DROP USER 'Anand.Mistry'@'%'; 
CREATE USER 'Anand.Mistry'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'Anand.Mistry'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# SELECT * FROM mysql.user

# From mysql.user table privelege list:
# Select_priv, Insert_priv,	Update_priv, Delete_priv, Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv, References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv, Create_view_priv, Show_view_priv, Create_routine_priv, Alter_routine_priv, Create_user_priv, Event_priv, Trigger_priv, Create_tablespace_priv

# Full privelege list:
# CREATE USER, CREATE VIEW, DELETE, DROP, EVENT, EXECUTE, FILE, GRANT, OPTION, INDEX, INSERT, LOCK TABLES, PROCESS, PROXY, REFERENCES, RELOAD, REPLICATION CLIENT, REPLICATION SLAVE, SELECT, SHOW DATABASES, SHOW VIEW, SHUTDOWN, SUPER, TRIGGER, UPDATE, USAGE
