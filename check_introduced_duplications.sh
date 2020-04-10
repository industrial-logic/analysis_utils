#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$SCRIPT_DIR"/get_pmd.sh
. "$SCRIPT_DIR"/git_utils.sh
. "$SCRIPT_DIR"/git_back_one_by_file.sh

function execute_pmd() {
  check_args 1 "$@"

  file_list=$1
  "$SCRIPT_DIR"/pmd-bin-*/bin/run.sh cpd --minimum-tokens 20 --filelist "$file_list"
}

git_files_in_commit HEAD > filelist
execute_pmd filelist > current_commit.txt
move_files_to_previous
execute_pmd filelist > current_commit_with_files_moved_back_one_commit.txt
git_restore
echo "This commit introduced the following things worthy of review"
diff current_commit.txt current_commit_with_files_moved_back_one_commit.txt
