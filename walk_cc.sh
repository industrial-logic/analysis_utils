#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export FILE_LIST=./filelist
export FILE_PATTERN="[.]java"
export RULES=$SCRIPT_DIR/cc.xml

function files_matching_pattern {
	commit=$1
	pattern=$2
	git diff-tree --no-commit-id --name-only --diff-filter=d -r $commit | grep $pattern > $FILE_LIST
   count=`wc -l < $FILE_LIST`
   echo $count
}

function review {
	commit=$1
	pattern=$2
	file_count=$(files_matching_pattern $commit $pattern)
	if [ $file_count -gt 0 ]
	then
   	cat $FILE_LIST
	   pmd -filelist $FILE_LIST -R $RULES -f text 2> /dev/null
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
		git checkout $commit
		review $commit $file_pattern
	done
}

function restore {
	git checkout .
	git checkout master &> /dev/null
}

walk $FILE_PATTERN
restore
