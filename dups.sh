#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/banner.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/self_update.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/get_pmd.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/check_args.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/execute_cpd.sh" $SCRIPT_DIR

print_banner
self_update
check_code
