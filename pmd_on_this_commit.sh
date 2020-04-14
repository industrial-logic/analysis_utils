#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/get_pmd.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/git_utils.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/execute_pmd.sh" $SCRIPT_DIR "$@"

git_compare_to_previous HEAD
git_restore
