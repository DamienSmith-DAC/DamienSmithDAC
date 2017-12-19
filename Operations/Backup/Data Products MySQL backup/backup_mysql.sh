#!/bin/bash

###############################################################
# Backup script for incremental backup of
# all databases in MySQL instance of dp-mysql-data-01
###############################################################
# Version: 1.0
# Developer: Indu N
###############################################################

export LC_ALL=C

#Variables
days_of_backups=6  # Must be less than 7
backup_owner="mysqlbackup"
parent_dir="/db/mysql_backup"
defaults_file="/db/mysql_backup/config/mysqldump.cnf"
todays_dir="${parent_dir}/$(date +%a%Y%m%d)"
log_file="${todays_dir}/backup-progress.log"
encryption_key_file="/db/mysql_backup/config/encryption_key"
now="$(date +%m-%d-%Y_%H-%M-%S)"
processors="$(nproc --all)"
emailAddress="indu.neelakandan@treasury.nsw.gov.au"
file_name="$(date +%a%Y%m%d)/backup-progress.log"
backup_info="${todays_dir}/xtrabackup_info"
mailContent="$backup_info"
attachment="$log_file"


# Use this to echo to standard error
error () {
    printf "%s: %s\n" "$(basename "${BASH_SOURCE}")" "${1}" >&2

    (
                echo To: $emailAddress
                echo Subject: "Error"
                echo "Mime-Version: 1.0"
                echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                echo ""
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: text/html"
                echo "Content-Disposition: inline"
                echo ""
                echo "${1}"
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: application/text/html"
                echo "Content-Transfer-Encoding: base64"
                echo ""
                base64 $attachment
    ) | /usr/sbin/sendmail -t

    exit 1
}

trap 'error "An unexpected error occurred."' ERR

sanity_check () {
    # Check user running the script
    if [ "$USER" != "$backup_owner" ]; then
        error "Script can only be run as the \"$backup_owner\" user"
    fi

    # Check whether the encryption key file is available
    if [ ! -r "${encryption_key_file}" ]; then
        error "Cannot read encryption key at ${encryption_key_file}"
    fi
}

set_options () {
    # List the xtrabackup arguments
    xtrabackup_args=(
        "--defaults-file=${defaults_file}"
        "--backup"
        "--extra-lsndir=${todays_dir}"
        "--compress"
        "--stream=xbstream"
        "--encrypt=AES256"
        "--encrypt-key-file=${encryption_key_file}"
        "--parallel=${processors}"
        "--compress-threads=${processors}"
        "--encrypt-threads=${processors}"
        "--slave-info"
    )

    backup_type="full"

    # Add option to read LSN (log sequence number) if a full backup has been
    # taken today.
    if grep -q -s "to_lsn" "${todays_dir}/xtrabackup_checkpoints"; then
        backup_type="incremental"
        lsn=$(awk '/to_lsn/ {print $3;}' "${todays_dir}/xtrabackup_checkpoints")
        xtrabackup_args+=( "--incremental-lsn=${lsn}" )
    fi
}

rotate_old () {
    # Remove the oldest backup in rotation
    day_dir_to_remove="${parent_dir}/$(date --date="${days_of_backups} days ago" +%a%Y%m%d)"

    if [ -d "${day_dir_to_remove}" ]; then
        rm -rf "${day_dir_to_remove}"
    fi
}

take_backup () {
    # Make sure today's backup directory is available and take the actual backup
    mkdir -p "${todays_dir}"
    find "${todays_dir}" -type f -name "*.incomplete" -delete
    xtrabackup "${xtrabackup_args[@]}" --target-dir="${todays_dir}" > "${todays_dir}/${backup_type}-${now}.xbstream.incomplete" 2> "${log_file}"

    mv "${todays_dir}/${backup_type}-${now}.xbstream.incomplete" "${todays_dir}/${backup_type}-${now}.xbstream"
}

#Main - call functions #
sanity_check && set_options && rotate_old && take_backup

# Check success and print message

if tail -1 "${log_file}" | grep -q "completed OK"; then
    printf "Backup successful!\n"
    printf "Backup created at %s/%s-%s.xbstream\n" "${todays_dir}" "${backup_type}" "${now}"

        (
                echo To: $emailAddress
                echo Subject: "Successful backup created at " "${todays_dir}" "${backup_type}" "${now}"
                echo "Mime-Version: 1.0"
                echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                echo ""
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: text/html"
                echo "Content-Disposition: inline"
                echo ""
                echo "Check log file at ${log_file} for more information"
                echo ""
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: application/text/html"
                echo "Content-Transfer-Encoding: base64"
                echo "Content-Disposition: attachment; filename=$file_name"
                echo ""
                base64 $attachment
        ) | /usr/sbin/sendmail -t

else
    error "Backup failure! Check ${log_file} for more information"

        (
                echo To: $emailAddress
                echo Subject: "Backup failure Check ${log_file} for more information"
                echo "Mime-Version: 1.0"
                echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
                echo ""
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: text/html"
                echo "Content-Disposition: inline"
                echo ""
                echo "Check log file at ${log_file} for more information"
                echo ""
                echo "--GvXjxJ+pjyke8COw"
                echo "Content-Type: application/text/html"
                echo "Content-Transfer-Encoding: base64"
                echo "Content-Disposition: attachment; filename=$file_name"
                echo ""
                base64 $attachment
        ) | /usr/sbin/sendmail -t
fi