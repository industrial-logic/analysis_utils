#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. $SCRIPT_DIR/get_pmd.sh

FILE_PATTERN="[.]java"

function execute_pmd() {
  file_list=$1
  $SCRIPT_DIR/pmd-bin-*/bin/run.sh cpd --minimum-tokens 25 --filelist $file_list
}

. $SCRIPT_DIR/git_utils.sh
git_main $FILE_PATTERN
