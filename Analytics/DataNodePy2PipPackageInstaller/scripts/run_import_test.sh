#!/bin/bash

THIS_DIR="$(cd "$(dirname "$0")"; pwd)"

# Imports:
#	HOST_FILE
source "${THIS_DIR}/config.sh"

TEST_SCRIPT="${THIS_DIR}/../test/import_test.sh"
#HOST_FILE="${THIS_DIR}/../host_lists/dace2_data_node_addresses.txt"
STDOUT_DIR="${THIS_DIR}/../logs/import_test_pssh_out"
STDERR_DIR="${THIS_DIR}/../logs/import_test_pssh_err"
# 5 mins
TIMEOUT=300

pssh -h "${HOST_FILE}" -t "${TIMEOUT}" -o "${STDOUT_DIR}" -e "${STDERR_DIR}" -Pv -I < "${TEST_SCRIPT}"