#!/bin/bash

# shellcheck source=.

script_dir="$1"

. "${script_dir}/get_pmd.sh"

RULES="${script_dir}/rulesets/${1}"

function check_code() {
  "$(pmd_run)" pmd -d ./src -R "$RULES" -f text 2>/dev/null
}

