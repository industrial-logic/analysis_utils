#!/bin/bash

# shellcheck source=.

script_dir="$1"

. "${script_dir}/bashlibs/get_pmd.sh"
. "${script_dir}/bashlibs/check_src.sh"

RULES="${script_dir}/rulesets/${2}"
RUN_PMD=$(find "$script_dir" -name run.sh)
function check_code() {
    src_dir=$(find . -type d -name src)
	check_src_dir
    "$RUN_PMD" pmd -dir "$src_dir" -rulesets "$RULES" -f text 2>/dev/null
}

