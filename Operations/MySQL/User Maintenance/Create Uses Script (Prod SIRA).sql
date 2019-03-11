# Non-Production Users to create

SET Password_set:= 'Password#123';

# abenig - SELECT Privelege
DROP USER 'Azenith.Benig'@'%'; 
CREATE USER 'Azenith.Benig'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Azenith.Benig'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# agarcia - SELECT Privelege
DROP USER 'Angela.Garcia'@'%'; 
CREATE USER 'Angela.Garcia'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Angela.Garcia'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  agupta - All privileges except Grant_priv
DROP USER 'Avinash.Gupta'@'%'; 
CREATE USER 'Avinash.Gupta'@'%' IDENTIFIED BY 'Password#123';
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
USAGE on *.* TO 'Avinash.Gupta'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  arslanovs - SELECT Privelege
DROP USER 'Sasha.Arslanov'@'%'; 
CREATE USER 'Sasha.Arslanov'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT ON *.* TO 'Sasha.Arslanov'@'%';

#  chenale - SELECT Privelege
DROP USER 'Alex.Chen'@'%'; 
CREATE USER 'Alex.Chen'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Alex.Chen'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  daop - SELECT Privelege
DROP USER 'Phuong.Dao'@'%'; 
CREATE USER 'Phuong.Dao'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Phuong.Dao'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  darjia - SELECT Privelege
DROP USER 'Ankit.Darji'@'%'; 
CREATE USER 'Ankit.Darji'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Ankit.Darji'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  jakimowiczw - All privileges except Grant_priv
DROP USER 'Waldemar.Jakimowicz'@'%'; 
CREATE USER 'Waldemar.Jakimowicz'@'%' IDENTIFIED BY 'Password#123';
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
USAGE on *.* TO 'Waldemar.Jakimowicz'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  joe.chiu - No Priveleges
DROP USER 'joe.chiu'@'%'; 
CREATE USER 'joe.chiu'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'joe.chiu'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  mistrya - SELECT Privelege
DROP USER 'Anand.Mistry'@'%'; 
CREATE USER 'Anand.Mistry'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Anand.Mistry'@'%' IDENTIFIED BY PASSWORD 'Password#123';

#  quizonp - SELECT Privelege
DROP USER 'Paulo.Quizon'@'%'; 
CREATE USER 'Paulo.Quizon'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Paulo.Quizon'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# rchew - No Priveleges
DROP USER 'Ronny.Chew'@'%'; 
CREATE USER 'Ronny.Chew'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'Ronny.Chew'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# singhs - SELECT Priveleges
DROP USER 'Suruchi.Singh'@'%'; 
CREATE USER 'Suruchi.Singh'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Suruchi.Singh'@'%' IDENTIFIED BY PASSWORD 'Password#123';
