#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

function total {
    echo $($SCRIPT_DIR/dups.sh 2>/dev/null | $SCRIPT_DIR/utils/summarize.awk | awk -F"," 'BEGIN{sum=0} {sum += $5} END {print sum}')
}

START_TOKEN_COUNT=$(total)
git checkout HEAD^ 2>/dev/null
END_TOKEN_COUNT=$(total)
git checkout master >/dev/null 2>&1
let DIFF=`expr $START_TOKEN_COUNT - $END_TOKEN_COUNT`
PWD=`pwd`
PROJ=`basename $PWD`
printf "%-30s: Diff: %4d Current: %6d Previous: %6d\n" $PROJ $DIFF $START_TOKEN_COUNT $END_TOKEN_COUNT
