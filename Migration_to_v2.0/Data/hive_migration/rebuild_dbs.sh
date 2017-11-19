#! /bin/bash

# Script to rebuild databases and tables

path_to_dbs=/tmp/hive_migration/databases/
databases=`ls ${path_to_dbs}`

for db in $databases; 
	do 
		echo 'Creating database '${db}
		hive -e "create database ${db};" 
		tables=`ls ${path_to_dbs}${db}`

		for t in $tables
			do 
				echo 'Creating table '${t}
				# Transform location of database from onegovdev to new cluster
				sed -i s'/onegovdev/np-master02.dac.local:8020/'g ${path_to_dbs}${db}/${t}
				hive --database ${db} -f ${path_to_dbs}${db}/${t}
				echo ' ' 
			done

	done
