#!/bin/bash

# shellcheck source=.

LANGUAGE=${1:-'java'}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/banner.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/get_pmd.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/check_args.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/execute_cpd.sh" $SCRIPT_DIR $LANGUAGE

print_banner
check_code
