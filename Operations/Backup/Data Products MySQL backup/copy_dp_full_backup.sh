#!/bin/bash

#######################################################################################
# Copy dataproducts full backup files from dp-mysql-data-02 to backup-master01.
# This is a data pull.
# This script is called by root cron job scheduled to run
# every day 2 hours after dataproducts full backup cronjob on  dp-mysql-data-02
########################################################################################
# Version: 1.0
# Developer: Indu N
########################################################################################

export LC_ALL=C

#Variables
REMOTE_HOST="dp-mysql-data-02"
PARENT_FULL_DIR="/db/mysql_backup/full"
REMOTE_FULL_DIR="${PARENT_FULL_DIR}/$(date "+%Y")/$(date "+%m")/$(date "+%d")"
LOCAL_PARENT_FULL_DIR="/dataproducts/full"
TODAYS_FULL_DIR="${LOCAL_PARENT_FULL_DIR}/$(date "+%Y")/$(date "+%m")"
LOG_PATH="/dataproducts/log/FULL_COPY_$(date +%a%Y%m%d).log"

# Log function
function log_info()
 {
    log_time=`date "+%Y-%m-%d:%H:%M:%S"`
    echo -e "$* $log_time" >> ${LOG_PATH}
 }


# create local directory if it doesnt exit
[ ! -d ${TODAYS_FULL_DIR} ] && mkdir -p ${TODAYS_FULL_DIR}

if [ $? -eq 0 ]; then
       log_info "Info: Created directory ${TODAYS_FULL_DIR}"
else
       log_info "Info: Local directory ${TODAYS_FULL_DIR} exists"
fi

# check if remote directory is available for copy
ssh -i /root/dace2_data_product_root_private_key root@dp-mysql-data-02  "test -e ${REMOTE_FULL_DIR}"

# Start copy if remote directory is available
if [ $? -eq 0 ]; then

   log_info "Info:File ${REMOTE_FULL_DIR}@${REMOTE_HOST} exists. Start copy"
   rsync -re  "ssh -i /root/dace2_data_product_root_private_key" root@${REMOTE_HOST}:${REMOTE_FULL_DIR} ${TODAYS_FULL_DIR}

   if [ $? -eq 0 ]; then

       log_info "Info:  Copy of ${REMOTE_FULL_DIR}@${REMOTE_HOST} directory has completed execution at"

       # Start deletion of remote dir in remote host
       log_info "Info:  Start deletion of ${REMOTE_FULL_DIR}@${REMOTE_HOST} at"

       ssh -i /root/dace2_data_product_root_private_key root@${REMOTE_HOST} "rm -rf ${REMOTE_FULL_DIR}"

       if [ $? -eq 0 ]; then
           log_info "Info:  Complete deletion of ${REMOTE_FULL_DIR}@${REMOTE_HOST} at"
       else
           log_info "Error: Deletion of ${REMOTE_FULL_DIR}@${REMOTE_HOST} Directory has failed execution at"
           exit
      fi
   else
      log_info "Info:  Copy of ${REMOTE_FULL_DIR}@${REMOTE_HOST} directory has failed execution at"
   fi

else

   log_info "Info:File ${REMOTE_FULL_DIR}@${REMOTE_HOST} doesnot exist"

fi
