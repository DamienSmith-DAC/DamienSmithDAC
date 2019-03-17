mysql --defaults-extra-file=/root/joec/my.conf -scte "`mysql --defaults-extra-file=/root/joec/my.conf -sce "SELECT CONCAT('SHOW GRANTS FOR \'',user,'\'@\'',host,'\';') FROM mysql.user;"`"
