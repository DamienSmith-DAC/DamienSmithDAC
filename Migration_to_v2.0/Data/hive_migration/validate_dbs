#! /bin/bash

# Script to assist in validating the migration of Hive tables from one cluster to another
# Run this script in both environments and compare the difference between the outputs

databases=`hive -e "show databases;"`
path_to_dbs=/tmp/hive_migration/databases/

for db in $databases;

	do
		tables=`hive -e "use ${db}; show tables;"`
		
		for t in $tables;
			do
				echo ${db}_${t}_count_`hive -e "use ${db}; select count(*) from ${t};"` >> row_counts 
			done
	done
