#!/bin/bash

# Runs the python package installer on all nodes specified in HOST_FILE

THIS_DIR="$(cd "$(dirname "$0")"; pwd)"

# Imports:
#	HOST_FILE
source "${THIS_DIR}/config.sh"
# source "${THIS_DIR}/py27_package_installer_config.sh"

#HOST_FILE="${THIS_DIR}/../host_lists/dace2_data_node_addresses.partial.txt"
PACKAGE_INSTALLER="${THIS_DIR}/py27_package_installer.sh" 
STDOUT_DIR="${THIS_DIR}/../logs/py27_package_installer_pssh_out"
STDERR_DIR="${THIS_DIR}/../logs/py27_package_installer_pssh_err"
# 10 mins
TIMEOUT=600

pssh -h "${HOST_FILE}" -t "${TIMEOUT}" -o "${STDOUT_DIR}" -e "${STDERR_DIR}" -Pv -I < "${PACKAGE_INSTALLER}"
