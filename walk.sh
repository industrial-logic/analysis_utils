#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/get_pmd.sh"
. "${SCRIPT_DIR}/git_utils.sh"

RULES="${SCRIPT_DIR}/${1}"

function check_code() {
  "${SCRIPT_DIR}/pmd-bin-*/bin/run.sh" pmd -d ./src -R "$RULES" -f text 2>/dev/null
}

git_walk 
