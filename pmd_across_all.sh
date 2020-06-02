#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/banner.sh" $SCRIPT_DIR
. "${SCRIPT_DIR}/bashlibs/check_args.sh" $SCRIPT_DIR

check_args 1 $@
RULES=$1

print_banner

find . -name src  | while read dir; do
	project_dir=`dirname $dir | cut -d/ -f2`
	echo "|||||$project_dir {"
	pushd $project_dir > /dev/null
    git pull >/dev/null 2>&1
	$SCRIPT_DIR/run_pmd.sh $RULES
	echo "} $project_dir"
	popd > /dev/null
done

