#!/bin/bash

# shellcheck source=.

script_dir=$1
LANGUAGE=$2

. "${script_dir}/bashlibs/get_pmd.sh"
. "${script_dir}/bashlibs/check_src.sh"

function check_code() {
	check_args 0 "$@"

	check_src_dir
	"$(pmd_run)" cpd --language $LANGUAGE --minimum-tokens 20 --files `find . -type d -name src`
}

