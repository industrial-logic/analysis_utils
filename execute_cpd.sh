#!/bin/bash

function check_code() {
  check_args 1 "$@"

  file_list=$1
  "$SCRIPT_DIR"/pmd-bin-*/bin/run.sh cpd --minimum-tokens 20 --filelist "$file_list"
}

