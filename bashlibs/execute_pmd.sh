#!/bin/bash

# shellcheck source=.

script_dir="$1"

. "${script_dir}/bashlibs/get_pmd.sh"
. "${script_dir}/bashlibs/check_src.sh"

RULES="${script_dir}/rulesets/${2}"

function check_code() {
	check_src_dir
    "$(pmd_run)" pmd -d ./src -R "$RULES" -f text 2>/dev/null
}

