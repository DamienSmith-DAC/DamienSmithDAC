#!/bin/bash

#######################################################################################
# Copy MicroStrategy incremental backup files from dp-mysql-meta-02 to backup-master01.
# This is a data pull.
# This script is called by root cron job scheduled to run
# every day 2 hours after mstr incremental backup cronjob on  dp-mysql-meta-02
########################################################################################
# Version: 1.0
# Developer: Indu N
########################################################################################

export LC_ALL=C

#Variables
REMOTE_HOST="dp-mysql-meta-02"
PARENT_INCR_DIR="/db/mysql_backup/incr"
REMOTE_INCR_DIR="${PARENT_INCR_DIR}/$(date "+%Y")/$(date "+%m")/$(date "+%d")"
LOCAL_PARENT_INCR_DIR="/mstr/incr"
TODAYS_INCR_DIR="${LOCAL_PARENT_INCR_DIR}/$(date "+%Y")/$(date "+%m")"
LOG_PATH="/mstr/log/INCR_COPY_$(date +%a%Y%m%d).log"

# Log function
function log_info()
 {
    log_time=`date "+%Y-%m-%d:%H:%M:%S"`
    echo -e "$* $log_time" >> ${LOG_PATH}
 }


# create local directory if it doesnt exit
[ ! -d ${TODAYS_INCR_DIR} ] && mkdir -p ${TODAYS_INCR_DIR}

if [ $? -eq 0 ]; then
   log_info "Info: Created directory ${TODAYS_INCR_DIR}"
else
   log_info "Info: Local directory ${TODAYS_INCR_DIR} exists"
fi

# check if remote directory is available for copy
ssh -i /root/dace2_data_product_root_private_key root@${REMOTE_HOST}  "test -e ${REMOTE_INCR_DIR}"

# Start copy if remote directory is available
if [ $? -eq 0 ]; then

   log_info "Info:File ${REMOTE_INCR_DIR}@${REMOTE_HOST} exists. Start copy"
   rsync -re  "ssh -i /root/dace2_data_product_root_private_key" root@${REMOTE_HOST}:${REMOTE_INCR_DIR} ${TODAYS_INCR_DIR}

   if [ $? -eq 0 ]; then
         log_info "Info:  Copy of ${REMOTE_INCR_DIR}@${REMOTE_HOST} directory has completed execution at"

         # Start deletion of remote dir in remote host
         log_info "Info:  Start deletion of ${REMOTE_INCR_DIR}@${REMOTE_HOST} at"

         ssh -i /root/dace2_data_product_root_private_key root@${REMOTE_HOST} "rm -rf ${REMOTE_INCR_DIR}"

         if [ $? -eq 0 ]; then
              log_info "Info:  Completed deletion of ${REMOTE_INCR_DIR}@${REMOTE_HOST} at"
         else
              log_info "Error: Deletion of ${REMOTE_INCR_DIR}@${REMOTE_HOST} Directory has failed execution at"
              exit
         fi
  else
        log_info "Error:  Copy of ${REMOTE_INCR_DIR}@${REMOTE_HOST} directory has failed execution at"
  fi

else

   log_info "Info:File ${REMOTE_INCR_DIR}@${REMOTE_HOST} doesnot exist"

fi
