#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

function line() {
    printf "%6s, %-30s, %s\n" "$1" "$2" "$3"
}

function countDuplication() {
    DIR=$1
    (cd $DIR; $SCRIPT_DIR/summarize.sh 2>/dev/null | awk -F"," 'BEGIN{sum=0} {sum+=$2} END {print sum}')
}

function firstCommitDate() {
    DIR=$1
    (cd $DIR; git log --reverse --format=%ci | head -1)
}

function summarizeTotal() {
    for i in */src;do
        d=$(dirname "$i")
        total=$(countDuplication $d)
        date=$(firstCommitDate $d)
        line "$total" $d "$date"
    done
}

line "Total" "Project" "First commit date"
summarizeTotal | sort -t , -k1r,1
