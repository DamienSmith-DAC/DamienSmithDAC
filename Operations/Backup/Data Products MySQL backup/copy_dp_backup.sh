#!/bin/bash

#########################################################################
# Copy dataproducts backup files from dp-mysql-data-02 to backup-master01.
# This is a data pull.
# This script is called by root cron job scheduled to run
# every day 2 hours after dataproducts backup cronjob on  dp-mysql-data-02
#########################################################################
# Version: 1.0
# Developer: Indu N
#########################################################################

export LC_ALL=C

#Variables
PARENT_DIR="/db/mysql_backup"
REMOTE_DIR="${PARENT_DIR}/$(date +%a%Y%m%d)"
LOG_FILE="${REMOTE_DIR}/backup-progress.log"
REMOTE_HOST="dp-mysql-data-02"
LOCAL_DIR="/dataproducts"
LOG_PATH="/dataproducts/log/COPY_$(date +%a%Y%m%d).log"
BACKUP_LOG="/dataproducts/log/backuptail$(date +%a%Y%m%d).log"

# Log function
function log_info()
 {
    log_time=`date "+%Y-%m-%d:%H:%M:%S"`
    echo -e "$* $log_time" >> ${LOG_PATH}
 }

# Start backup pull from remote host
log_info "Info: Start copy at"

rsync --remove-source-files -re  "ssh -i /root/dace2_data_product_root_private_key" root@${REMOTE_HOST}:${REMOTE_DIR} ${LOCAL_DIR}

if [ $? -ne 0 ]; then
        log_info "Error: Copy of ${REMOTE_DIR}@${REMOTE_HOST} Directory has failed execution at"
        exit
fi

log_info "Info:  Copy of ${REMOTE_DIR}@${REMOTE_HOST} directory has completed execution at"

# Start deletion of empty dir in remote host
log_info "Info:  Start deletion of ${REMOTE_DIR}@${REMOTE_HOST} at"

ssh -i /root/dace2_data_product_root_private_key root@${REMOTE_HOST} "rmdir ${REMOTE_DIR}"

if [ $? -ne 0 ]; then
        log_info "Error: Deletion of ${REMOTE_DIR}@${REMOTE_HOST} Directory has failed execution at"
       exit
fi


log_info "Info:  Complete deletion of ${REMOTE_DIR}@${REMOTE_HOST} at"
