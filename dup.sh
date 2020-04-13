#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$SCRIPT_DIR"/get_pmd.sh

FILE_PATTERN="[.]java"

function check_code() {
  check_args 1 "$@"

  file_list=$1
  "$SCRIPT_DIR"/pmd-bin-*/bin/run.sh cpd --minimum-tokens 20 --filelist "$file_list"
}

. "$SCRIPT_DIR"/git_utils.sh
git_main $FILE_PATTERN
