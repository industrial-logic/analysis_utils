#!/bin/bash

 SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

$SCRIPT_DIR/dups.sh > dups_start.txt 2>/dev/null
git checkout HEAD ^ 2>/dev/null
$SCRIPT_DIR/dups.sh > dups_prev.txt 2>/dev/null
git checkout master >/dev/null 2>&1
$SCRIPT_DIR/utils/summarize.awk < dups_start.txt > dups_start_summarized.txt
$SCRIPT_DIR/utils/summarize.awk < dups_prev.txt > dups_prev_summarized.txt
START_TOKEN_COUNT=$(cat dups_start_summarized.txt | awk -F"," 'BEGIN{sum=0} {sum += $5} END {print sum}')
END_TOKEN_COUNT=$(cat dups_prev_summarized.txt | awk -F"," 'BEGIN{sum=0} {sum += $5} END {print sum}')
rm dups_start_summarized.txt dups_prev_summarized.txt dups_start.txt dups_prev.txt
let DIFF=`expr $START_TOKEN_COUNT - $END_TOKEN_COUNT`
PWD=`pwd`
PROJ=`basename $PWD`
printf "%-30s: Diff: %4d [current to last commit] Total: %6d [sum of duplication]\n" $PROJ $DIFF $START_TOKEN_COUNT
