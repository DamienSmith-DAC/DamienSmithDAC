#! /bin/bash

# Script to assist in validating the migration of Hive tables from one cluster to another
# Run this script in both environments and compare the difference between the outputs

databases=`hive -e "show databases;"`
base_path=/tmp/hive_migration

for db in $databases;

	do
		tables=`hive -e "use ${db}; show tables;"`
		
		for t in $tables;
			do
				echo ${db}_${t}_count_`hive -e "use ${db}; select count(*) from ${t};"` >> row_counts.txt 
			done
	done

#Logging
PROCESS_LOG_PATH=${base_path}/logs
function log_info()
{
log_time=date "+%Y-%m-%d:%H:%M:%S"
echo -e "$* $log_time" >> ${PROCESS_LOG_PATH}
}
log_info "Info: Process started at"

#This code to check for any failure at any step
if [ $? -eq 0 ];then
log_info "Info : Command Completed"
else
log_info "Error : Command Failed"
exit 1
fi

log_info "Info: Process completed at"
