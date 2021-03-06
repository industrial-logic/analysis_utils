#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$SCRIPT_DIR"/bashlibs/get_pmd.sh "$SCRIPT_DIR"
. "$SCRIPT_DIR"/bashlibs/git_utils.sh "$SCRIPT_DIR"

function set_status() {
  diff="$1"
  threshold="$2"
  if [[ $threshold -gt 0 && $diff -ge $threshold ]]; then
    echo "Last commit increased duplication by $diff lines" 1>&2
    echo "Allowed threshold was set to $threshold" 1>&2
    RETURN_STATUS=1
  else
    RETURN_STATUS=0
  fi
}

function usage() {
  echo "Usage: $0"
  echo "  [-b <n> Go back n commits, defaults to 1]"
  echo "  [-f <n> Force failure when increase greater than n lines, defaults to 10]"
  echo "  [-h print this message]"
}

function isWholeNumber() {
  value=$1
  option=$2
  wholeNumber='^[0-9]+$'
  if ! [[ $value =~ $wholeNumber ]]; then
    echo "Value provided for $option option must be a positive whole number"
    echo "Actual value: '$value'"
    exit 1
  fi
}

function total() {
  "$SCRIPT_DIR"/dups.sh 2>/dev/null | "$SCRIPT_DIR"/utils/summarize.awk | "$SCRIPT_DIR"/utils/total_lines.awk
}

TOTAL_COMMITS_BACK=1
FAIL_THRESHOLD=0
RETURN_STATUS=0
DIFF=0
while getopts hb:f: opt; do
  case $opt in
  b)
    TOTAL_COMMITS_BACK=$OPTARG
    isWholeNumber $TOTAL_COMMITS_BACK '-b'
    ;;
  f)
    FAIL_THRESHOLD=$OPTARG
    isWholeNumber $FAIL_THRESHOLD '-f'
    ;;
  h)
    usage
    exit 0
    ;;
  :)
    echo "Invalid Option: -$OPTAG requires an argument" 1>&2
    usage
    exit 1
    ;;
  \?)
    echo "Invalid Option: -$OPTAG" 1>&2
    usage
    exit 1
    ;;
  esac
done

if [ $(git_clean) -eq 0 ]; then
  . "${SCRIPT_DIR}/utils/dirty_last_commit_dups.sh" "${SCRIPT_DIR}"
else
  . "${SCRIPT_DIR}/utils/clean_last_commit_dups.sh" "${SCRIPT_DIR}"
fi

process_repo
set_status "$DIFF" "$FAIL_THRESHOLD"
exit $RETURN_STATUS
