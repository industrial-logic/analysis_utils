#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

TOTAL_COMMITS_BACK=1

if [ "$#" -eq 1  ]; then
    TOTAL_COMMITS_BACK=$1
fi

function total {
    echo $($SCRIPT_DIR/dups.sh 2>/dev/null | $SCRIPT_DIR/utils/summarize.awk | awk -F"," 'BEGIN{sum=0} {sum += $5} END {print sum}')
}

PWD=`pwd`
PROJ=`basename $PWD`

for i in $(git log --pretty=format:"%H" -n $TOTAL_COMMITS_BACK);do
    git checkout $i 2>/dev/null
    COMMIT_DATE=$(git show -s --format=%ci $i)
    START_COMMIT=$(git log --pretty=format:'%h' -n 1)
    START_TOKEN_COUNT=$(total)
    git checkout HEAD^ 2>/dev/null
    END_TOKEN_COUNT=$(total)
    let DIFF=`expr $START_TOKEN_COUNT - $END_TOKEN_COUNT`
    printf "%-30s: Diff: %8d Current: %7d Previous: %7d Commit: %7s [%s]\n" "$PROJ" "$DIFF" "$START_TOKEN_COUNT" "$END_TOKEN_COUNT" "$START_COMMIT" "$COMMIT_DATE"
done

git checkout master >/dev/null 2>&1
