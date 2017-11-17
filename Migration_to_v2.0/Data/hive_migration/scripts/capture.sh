#! /bin/bash

# Script to capture the rebuild Hive command for all tables in all databases

databases=`hive -e "show databases;"`
path_to_dbs=/tmp/hive_migration/databases/

for db in $databases;

	do
		mkdir -p ${path_to_dbs}${db}
		tables=`hive -e "use ${db}; show tables;"`
		
		for t in $tables;
			do
				hive -e "use ${db}; show create table ${t};" > ${path_to_dbs}${db}/${t}
			done
	done
