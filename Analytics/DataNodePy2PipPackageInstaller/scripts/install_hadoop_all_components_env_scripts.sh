#!/bin/bash

# Adds the hadoop-all-components-env.sh script to /etc/profile.d on all nodes specified in HOST_FILE

#### CONSTANTS ####

THIS_DIR="$(cd "$(dirname "$0")"; pwd)"

HOST_FILE="${THIS_DIR}/../host_lists/spyder-edge.txt"
STDOUT_DIR="${THIS_DIR}/../logs/hadoop_all_components_end_scripts_installer_out"
STDERR_DIR="${THIS_DIR}/../logs/hadoop_all_components_end_scripts_installer_err"
# 5 mins
TIMEOUT=300

HADOOP_ALL_COMPONENTS_SCRIPT="${THIS_DIR}/hadoop-all-components-env.sh"
DEST_PATH="/etc/profile.d/$(basename "${HADOOP_ALL_COMPONENTS_SCRIPT}")"

#### MAIN ####

script_content=`cat "${HADOOP_ALL_COMPONENTS_SCRIPT}"`

pssh -h "${HOST_FILE}" -t "${TIMEOUT}" -o "${STDOUT_DIR}" -e "${STDERR_DIR}" -Pv -I <<-ENDOFSCRIPT

	echo '${script_content}' > "${DEST_PATH}"

ENDOFSCRIPT
