#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

function cleanup {
    rm -rf "$CLONE_DESTINATION"
}
trap cleanup EXIT

function project {
    PWD=$(pwd)
    echo $(basename "$PWD")
}

function total {
    echo $("$SCRIPT_DIR"/dups.sh 2>/dev/null | $SCRIPT_DIR/utils/summarize.awk | awk -F"," 'BEGIN{sum=0} {sum += $2} END {print sum}')
}

function cloneRepo {
    td=$(mktemp -d -t ec-XXXXXXXX)
    git clone . "$td" >/dev/null 2>&1
    echo "$td"
}

function totalClone {
    cd "$CLONE_DESTINATION" || exit
    totalLines=$(total)
    echo "$totalLines"
}

PROJ=$(project)
START_LINE_COUNT=$(total)
CLONE_DESTINATION=$(cloneRepo)
END_LINE_COUNT=$(totalClone)
DIFF=$(expr "$START_LINE_COUNT" - "$END_LINE_COUNT")
if [[ $END_LINE_COUNT -gt 0 ]]; then
    DELTA=$(expr $DIFF \* 100 / $END_LINE_COUNT)
else
    DELTA=0
fi

printf "%-30s: Diff: %8d (%4d%%) Current: %7d Previous: %7d\n" \
    "$PROJ" "$DIFF" "$DELTA" "$START_LINE_COUNT" "$END_LINE_COUNT"
