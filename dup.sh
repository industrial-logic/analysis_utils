#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $SCRIPT_DIR/get_pmd.sh 
. $SCRIPT_DIR/git_utils.sh

FILE_LIST=./filelist
FILE_PATTERN="[.]java"

function review {
	commit=$1
	pattern=$2

  git_files_matching_pattern $commit $pattern >$FILE_LIST
  cat $FILE_LIST
  file_count=$(cat $FILE_LIST | wc -l)

	if [ $file_count -gt 0 ]; then
		$SCRIPT_DIR/pmd-bin-*/bin/run.sh cpd --minimum-tokens 25 --filelist $FILE_LIST
	else
		echo "No files matching '$2'"
	fi
}


function walk {
  file_pattern=$1
	git rev-list HEAD | while read commit
	do
		echo '-------------------------------------------'
		echo $commit
		git checkout $commit > /dev/null 2>&1
		review $commit $file_pattern
	done
}

git_restore
walk $FILE_PATTERN
git_restore
