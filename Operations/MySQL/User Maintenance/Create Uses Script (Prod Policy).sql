# Production SIRA POLICY Users to create

# abenig - SELECT Privelege
DROP USER 'azenith.benig'@'%'; 
CREATE USER 'azenith.benig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `azenith.benig`@`%`;

# agarcia - SELECT Privelege
DROP USER 'angela.garcia'@'%'; 
CREATE USER 'angela.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angela.garcia`@`%`;

# arslanovs - SELECT Privelege
DROP USER 'sasha.arslanov'@'%'; 
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `Common_Data`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sasha.arslanov`@`%`;

# darjia - SELECT Privelege
DROP USER 'ankit.darji'@'%'; 
CREATE USER 'ankit.darji'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ankit.darji`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `ankit.darji`@`%`;

# joe.chiu  - No Priveleges
DROP USER 'joe.chiu'@'%'; 
CREATE USER 'joe.chiu'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE on *.* TO 'joe.chiu'@'%';
