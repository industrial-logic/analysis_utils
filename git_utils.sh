#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/get_pmd.sh"
. "${SCRIPT_DIR}/check_args.sh"

function git_restore() {
  git checkout . >/dev/null 2>&1
  git checkout master >/dev/null 2>&1
  rm -f filelist
}

function git_walk() {
  check_args 0 "$@"

  git_restore

  git rev-list HEAD | while read commit; do
    echo '-------------------------------------------'
    echo "$commit"
    git checkout "$commit" >/dev/null 2>&1
    check_code
  done

  git_restore
}

function git_compare_to_previous() {
  check_code > current_commit.txt
  git checkout HEAD^ 2>/dev/null
  check_code > previous_commit.txt
  git_restore
  echo "This commit introduced the following things worthy of review"
  diff current_commit.txt previous_commit.txt
}
