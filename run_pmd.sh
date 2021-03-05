#!/bin/bash

# shellcheck source=.

LANGUAGE=${2:-'java'}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/banner.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/get_pmd.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/check_args.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/execute_pmd.sh" $SCRIPT_DIR $1 $LANGUAGE

print_banner
check_code
