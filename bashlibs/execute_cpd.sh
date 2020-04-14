#!/bin/bash

# shellcheck source=.

script_dir=$1

. "${script_dir}/bashlibs/get_pmd.sh"

function check_code() {
  check_args 0 "$@"

  "$(pmd_run)" cpd --minimum-tokens 20 --files src
}

