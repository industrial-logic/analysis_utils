#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. $SCRIPT_DIR/get_pmd.sh

FILE_PATTERN="[.]java"
RULES=$SCRIPT_DIR/$1

function check_code() {
  file_list=$1
  $SCRIPT_DIR/pmd-bin-*/bin/run.sh pmd -filelist $FILE_LIST -R $RULES -f text 2>/dev/null
}

. $SCRIPT_DIR/git_utils.sh
git_main $FILE_PATTERN
