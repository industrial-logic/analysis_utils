#!/bin/bash

script_dir=$1
. "${script_dir}/bashlibs/check_args.sh"

function self_update {
    check_args 0 $@

    pushd "$script_dir" > /dev/null 2>&1
	git pull > /dev/null 2>&1
	popd > /dev/null 2>&1
}
