#!/bin/bash
# is a script for cold backup from data products
# from /dataproducts/full to /analytics/dataproducts_cold_backup/full 
# Deletes incremental backup files for the previous 6 days.
# It'll copy the full backup file from previous Saturday
# Cronjob for this Script will run on Friday 18:00 UTC
###############################################################################
# version 1.1
# Developer Chetna S
###############################################################################
# Change history:
# Version 1.1: Removed code that copies incremental backup to
#              dataproducts_cold_backup/incr
###############################################################################

#variables for full
source_parent_dir_full="/dataproducts/full"
weekly_local_source_full="$(date -d "$(date) - 6 day" +"%Y/%m/%d")"
weekly_source_dir_full="${source_parent_dir_full}/${weekly_local_source_full}"
destination_parent_backup_full="/analytics/dataproducts_cold_backup/full"
destination_local_dir_full="${destination_parent_backup_full}/$(date "+%Y")/$(date "+%m")"

#variables for incr
source_parent_dir_incr="/dataproducts/incr"
destination_parent_dir_incr="/analytics/dataproducts_cold_backup/incr"
destination_local_dir_incr="${destination_parent_dir_incr}/$(date "+%Y")/$(date "+%m")"

#log variable
LOG_PATH="/dataproducts/log/backup_COPY_$(date +%a%Y%m%d).log"

# Log function
function log_info()
 {
    log_time=`date "+%Y-%m-%d:%H:%M:%S"`
    echo -e "$* $log_time" >>${LOG_PATH}
 }

#Copy
RSYNC="rsync -a"

#start logging
log_info "Info: Start copy of full backup"

# create local directory if it doesnt exit
[ ! -d ${destination_local_dir_full} ] && mkdir -p ${destination_local_dir_full}

if [ $? -eq 0 ]; then
   log_info "Info: Created directory ${destination_local_dir_full}"
else
   log_info "Info: Local directory ${destination_local_dir_full} exists"
fi

# Copy previous Saturday's file
OK=0
$RSYNC "${weekly_source_dir_full}"  "${destination_local_dir_full}";

if [ $? -eq 0 ]; then
	log_info "Info: Copy Completed for ${weekly_source_dir_full}"
	rm -rf "${weekly_source_dir_full}";
	if [ $? -eq 0 ]; then
		 log_info "Info: Deletion Complete for ${weekly_source_dir_full}"
	else
		 log_info "Info: Error in Deleting ${weekly_source_dir_full}"
		 OK=1
	fi
else
   log_info "Info:Error in copying Full Backup ${weekly_source_dir_full}"
   OK=1

fi

if [ $OK -eq 0 ]; then
    log_info "Info: Full Backup Copy Completed"
else
    log_info "Info: Error in Full Backup Copy"
fi

#start logging
log_info "Info: Start cleanup of incremental backup "

# Delete last 6 days of incremental backup
ok=0
for i in {0..5}; do

    source_local_dir_incr=$(date -d "$(date) - $i day" +"%Y/%m/%d")
    
    rm -rf "${source_parent_dir_incr}/${source_local_dir_incr}";
    if [ $? -eq 0 ]; then
		log_info "Info: Deletion Complete for ${source_parent_dir_incr}/${source_local_dir_incr}"
    else
        log_info "Info: Error in Deleting ${source_parent_dir_incr}/${source_local_dir_incr}"
        ok=1
    fi
 
done

log_info "Info: Cleanup of incremental backup completed "