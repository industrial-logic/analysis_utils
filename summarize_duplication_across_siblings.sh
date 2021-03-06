#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/check_args.sh" $SCRIPT_DIR

function line() {
    printf "%6s, %-30s, %s\n" "$1" "$2" "$3"
}

function countDuplication() {
	  check_args 1 "$@"

    DIR="$1"
    (cd "$DIR" || exit; "$SCRIPT_DIR"/summarize.sh 2>/dev/null | "$SCRIPT_DIR"/utils/total_lines.awk)
}

function firstCommitDate() {
	  check_args 1 "$@"

    DIR="$1"
    (cd "$DIR" || exit; git log --reverse --format=%ci | head -1)
}

function summarizeTotal() {
    for i in */src;do
        d=$(dirname "$i")
        total=$(countDuplication "$d")
        date=$(firstCommitDate "$d")
        line "$total" "$d" "$date"
    done
}

line "Total" "Project" "First commit date"
summarizeTotal | sort -t , -k1r,1
