#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

function cleanup {
    git checkout "$ORIGINAL_BRANCH" 1>/dev/null 2>&1
}

ORIGINAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)

trap cleanup EXIT

function total {
    "$SCRIPT_DIR"/../dups.sh 2>/dev/null | "$SCRIPT_DIR"/summarize.awk | "$SCRIPT_DIR"/total_lines.awk
}

function reportOnCommit {
    COMMIT_DATE=$(git show -s --format=%ci --date=local)
    COMMIT_DATE=$(gdate +"%Y-%m-%d %H:%M:%S" -d "$COMMIT_DATE")
    LINES=$(total)
    printf "%s,%d\n" "$COMMIT_DATE" "$LINES"
}

BACK=${1:-"4.weeks"}

COMMITS_SO_FAR=0

for i in $(git log --pretty=format:'%H' --since="$BACK"); do
    git checkout $i 2>/dev/null
    reportOnCommit
    COMMITS_SO_FAR=$((COMMITS_SO_FAR+1))
    LAST_COMMIT="$i"
done

LAST_COMMIT="${LAST_COMMIT:-HEAD}"

while [ $COMMITS_SO_FAR -lt 2 ]; do
    git checkout "$LAST_COMMIT"^ 2>/dev/null
    reportOnCommit
    COMMITS_SO_FAR=$((COMMITS_SO_FAR+1))
    LAST_COMMIT="$LAST_COMMIT"^
done
