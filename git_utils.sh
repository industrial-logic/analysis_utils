#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. $SCRIPT_DIR/get_pmd.sh

FILE_LIST=./filelist
FILE_PATTERN="[.]java"
RULES=$SCRIPT_DIR/$1

function check_args() {
  count=$1
  shift
  if [ "$#" -ne $count ]; then
    echo "Requires $count parameters. Passed: $@"
    caller
    exit 1
  fi
}

function git_files_matching_pattern() {
  set -o noglob
  check_args 2 $@

  commit=$1
  pattern=$2

  git diff-tree --no-commit-id --name-only --diff-filter=d -r $commit | grep $pattern
  set +o noglob
}

function git_count_files_in_commit() {
  check_args 2 $@

  commit=$1
  pattern=$2

  $(git_files_matching_pattern $commit $pattern) | wc -l
}

function git_restore() {
  git checkout . > /dev/null 2>&1
  git checkout master > /dev/null 2>&1
  rm -f filelist
}

