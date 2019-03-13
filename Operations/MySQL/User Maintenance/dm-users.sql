-- agarcia
CREATE USER 'angela.garcia'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `angela.garcia`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `angela.garcia`@`%`;


-- darjia
CREATE USER 'ankit.darji'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `ankit.darji`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `ankit.darji`@`%`;


-- abenig
CREATE USER 'azenith.benig'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `azenith.benig`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `azenith.benig`@`%`;


-- arslanovs
CREATE USER 'sasha.arslanov'@'%' IDENTIFIED WITH authentication_pam AS 'mysql';
GRANT USAGE ON *.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `Common_Data`.* TO `sasha.arslanov`@`%`;
GRANT SELECT ON `SIRA_CTP`.* TO `sasha.arslanov`@`%`;


