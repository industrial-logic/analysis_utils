#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$SCRIPT_DIR"/get_pmd.sh

FILE_LIST=./filelist

function check_args() {
  count=$1
  shift
  if [ "$#" -ne $count ]; then
    echo "Requires $count parameters. Passed: " "$@"
    caller
    exit 1
  fi
}

function git_files_matching_pattern() {
  check_args 2 "$@"

  commit=$1
  pattern=$2

  git diff-tree --no-commit-id --name-only --diff-filter=d -r $commit | grep $pattern
}

function git_count_files_in_commit() {
  check_args 2 "$@"

  commit=$1
  pattern=$2

  git_files_matching_pattern $commit $pattern | wc -l
}

function git_restore() {
  git checkout . >/dev/null 2>&1
  git checkout master >/dev/null 2>&1
  rm -f filelist
}

function git_files_in_commit() {
  check_args 2 "$@"

  commit=$1
  pattern=$2
  git_files_matching_pattern $commit $pattern > $FILE_LIST
}

function review() {
  git_files_in_commit "$@"

  cat $FILE_LIST
  file_count=$(cat $FILE_LIST | wc -l)

  if [ $file_count -gt 0 ]; then
    execute_pmd $FILE_LIST
  else
    echo "No files matching '$pattern'"
  fi
}

function git_walk() {
  check_args 1 "$@"

  file_pattern=$1
  git rev-list HEAD | while read commit; do
    echo '-------------------------------------------'
    echo $commit
    git checkout $commit >/dev/null 2>&1
    review $commit $file_pattern
  done
}

function git_main() {
  check_args 1 "$@"

  file_pattern=$1
  git_restore
  git_walk $file_pattern
  git_restore
}
