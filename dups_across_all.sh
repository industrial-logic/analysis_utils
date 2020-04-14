#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

find . -name src  | while read dir; do 
	project_dir=`dirname $dir | cut -d/ -f2`
	echo "|||||$project_dir {"
	pushd $project_dir > /dev/null
	$SCRIPT_DIR/dups_in_this_commit.sh
	echo "} $project_dir"
	popd > /dev/null
done

