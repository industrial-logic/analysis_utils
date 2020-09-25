#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

function cleanup {
    git checkout master 1>/dev/null 2>&1
}

trap cleanup EXIT

function total {
    "$SCRIPT_DIR"/../dups.sh 2>/dev/null | "$SCRIPT_DIR"/summarize.awk | "$SCRIPT_DIR"/total_lines.awk
}

BACK=${1:-"4.weeks"}

for i in $(git log --pretty=format:'%H' --since="$BACK"); do
    git checkout $i 2>/dev/null
    COMMIT_DATE=$(git show -s --format=%ci --date=local $i)
    COMMIT_DATE=$(gdate +"%Y-%m-%d %H:%M:%S" -d "$COMMIT_DATE")
    LINES=$(total)
    printf "%s,%d\n" "$COMMIT_DATE" "$LINES"
done
