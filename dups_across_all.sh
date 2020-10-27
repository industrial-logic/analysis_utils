#!/bin/bash

# shellcheck source=.

LANGUAGE=""

if [ $# -eq 0 ]
	then
		LANGUAGE="java"
	else
		LANGUAGE="$1"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/banner.sh" "$SCRIPT_DIR"

print_banner

find . -name src  | while read dir; do
	project_dir=`dirname $dir | cut -d/ -f2`
	echo "|||||$project_dir {"
	pushd "$project_dir" > /dev/null || exit
	git pull >/dev/null 2>&1
	"$SCRIPT_DIR"/dups.sh $LANGUAGE
	echo "} $project_dir"
	popd > /dev/null || exit
done
