#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/get_pmd.sh"
. "${SCRIPT_DIR}/git_utils.sh"
. "${SCRIPT_DIR}/git_back_one_by_file.sh"
. "${SCRIPT_DIR}/execute_cpd.sh"

git_compare_to_previous HEAD
