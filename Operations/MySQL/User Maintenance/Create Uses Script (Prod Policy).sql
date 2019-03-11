# Non-Production Users to create

DECLARE Passord_set VARCHAR(40);
SET Password_set:= 'Password#123';

# abenig - SELECT Privelege
DROP USER 'Azenith.Benig'@'%'; 
CREATE USER 'Azenith.Benig'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Azenith.Benig'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# agarcia - SELECT Privelege
DROP USER 'Angela.Garcia'@'%'; 
CREATE USER 'Angela.Garcia'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Angela.Garcia'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# arslanovs - SELECT Privelege
DROP USER 'Sasha.Arslanov'@'%'; 
CREATE USER 'Sasha.Arslanov'@'%' IDENTIFIED BY 'Password#123';
GRANT SELECT on *.* TO 'Sasha.Arslanov'@'%' IDENTIFIED BY PASSWORD 'Password#123';

# darjia - SELECT Privelege
DROP USER 'Ankit.Darji'@'%'; 
CREATE USER 'Ankit.Darji'@'%' IDENTIFIED BY 'Password#123';
GRANT ALL ON *.* TO 'Ankit.Darji'@'%';

# joe.chiu  - No Priveleges
DROP USER 'Joe.Chiu'@'%'; 
CREATE USER 'Joe.Chiu'@'%' IDENTIFIED BY 'Password#123';
GRANT USAGE on *.* TO 'Joe.Chiu'@'%' IDENTIFIED BY PASSWORD 'Password#123';
