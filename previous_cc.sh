#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export FILE_LIST=./filelist
export FILE_PATTERN="[.]java"
export RULES=$SCRIPT_DIR/cc.xml

function header {
	echo '================================================================================'
}

function subheader {
	echo '--------------------------------------------------------------------------------'
}

function version_x {
	file=$1
	commit=$2
	git show $commit:$file > $file 2>/dev/null
}

function commit_x {
	file=$1
	index=$2
	git log --format="%H" --follow  -- $file | awk "NR==$index"
}

function files_matching_pattern {
	commit=$1
	pattern=$2
	git diff-tree --no-commit-id --name-only --diff-filter=d -r $commit | grep $pattern > $FILE_LIST
   count=`wc -l < $FILE_LIST`
   echo $count
}

function review {
	pmd -filelist $FILE_LIST -R $RULES -f text 2> /dev/null
}

function restore {
	git checkout . &> /dev/null
	git checkout master &> /dev/null
}

function extract_previous {
	cat $FILE_LIST | while read -r file_name; do
		previous=$(commit_x $file_name 2)
	   if [[ ! -z "${previous// }" ]]
		then
			version_x $file_name $previous
		fi
	done
}

function current_hash {
	echo `git rev-parse HEAD`
}

function check_commit {
	pattern=$1
	current_commit_hash=$(current_hash)
	file_count=$(files_matching_pattern $commit $pattern)

	subheader
	if [ $file_count -gt 0 ]
	then
		echo "Files changed in commit: $current_commit_hash"
		cat $FILE_LIST
		echo "Report for: $current_commit_hash"
		review
		extract_previous
		subheader
		echo 'Report for previous version of files'
		review 
	else
		echo "Commit does not contain files matching: $pattern"
	fi
}

function walk {
	file_pattern=$1
	git rev-list HEAD | while read commit
	do
		header
		echo $commit
		git checkout $commit &> /dev/null
		check_commit $file_pattern 
		restore
	done
}

walk $FILE_PATTERN
