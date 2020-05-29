#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/self_update.sh" $SCRIPT_DIR
self_update

find . -name src  | while read dir; do
	project_dir=`dirname $dir | cut -d/ -f2`
	echo "|||||$project_dir {"
	pushd $project_dir > /dev/null
    git pull >/dev/null 2>&1
	$SCRIPT_DIR/dups.sh
	echo "} $project_dir"
	popd > /dev/null
done

