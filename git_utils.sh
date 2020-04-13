#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$SCRIPT_DIR"/get_pmd.sh
. "$SCRIPT_DIR"/check_args.sh

FILE_LIST=./filelist

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
    check_code $FILE_LIST
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

function git_compare_to_previous() {
  git_files_in_commit HEAD > filelist
  check_code filelist > current_commit.txt
  git checkout HEAD^ 2>/dev/null
  check_code filelist > current_commit_with_files_moved_back_one_commit.txt
  git_restore
  echo "This commit introduced the following things worthy of review"
  diff current_commit.txt current_commit_with_files_moved_back_one_commit.txt
}
