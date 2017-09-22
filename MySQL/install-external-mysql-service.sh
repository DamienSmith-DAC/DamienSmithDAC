#!/bin/bash

# HDP Install Exteral MySQL Database

CREATE USER 'ambari'@'%' IDENTIFIED BY 'ambari_password';
GRANT ALL privileges on *.* to 'ambari'@'%' WITH GRANT OPTION;
CREATE USER 'ambari'@'localhost' IDENTIFIED BY 'ambari_password';
GRANT ALL privileges on *.* to 'ambari'@'localhost' WITH GRANT OPTION;
CREATE USER 'ambari'@'np-master02.dac.local' IDENTIFIED BY 'ambari_password';
GRANT ALL privileges on *.* to 'ambari'@'np-master02.dac.local' WITH GRANT OPTION;
FLUSH PRIVILEGES;

# NOT AUTOMATED
# mysql -u ambari -p
# create database ambari;
# use ambari;
# SOURCE Ambari-DDL-MySQL-CREATE.sql;

CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive_password';
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'localhost';
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive_password';
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'%';
CREATE USER 'hive'@'np-master02.dac.local' IDENTIFIED BY 'hive_password';
GRANT ALL PRIVILEGES ON *.* TO 'hive'@'np-master02.dac.local';
FLUSH PRIVILEGES;

# NOT AUTOMATED
# mysql -u root -p
# create database hive;



