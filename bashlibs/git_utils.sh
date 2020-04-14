#!/bin/bash

# shellcheck source=.

script_dir=$1
. "${script_dir}/bashlibs/get_pmd.sh"
. "${script_dir}/bashlibs/check_args.sh"

function git_current_commit() {
  git log --pretty=format:'%H' -n 1
}

function git_first_commit() {
  git log --pretty=format:'%H' | tail -1
}

function git_restore() {
  git_go_to .
  git_go_to master
  rm -f filelist
  rm -f current_commit.txt
  rm -f previous_commit.txt
}

function git_go_to() {
  check_args 1 "$@"

  commit=$1
  git checkout $1 > /dev/null 2>&1
}

function git_compare_to_previous() {
  check_args 1 "$@"

  commit=$1

  git_go_to "$commit"
  check_code > current_commit.txt

  git_go_to "$commit^"

  if [[ $(git_current_commit) != $(git_first_commit) ]] ; then
    check_code > previous_commit.txt
  else
    rm previous_commit.txt
    touch previous_commit.txt
  fi

  echo "This commit introduced the following things worthy of review"
  diff current_commit.txt previous_commit.txt
}

function git_walk() {
  check_args 0 "$@"

  git_restore

  git rev-list HEAD | while read -r commit; do
    echo '-------------------------------------------'
    echo "$commit"
    git_compare_to_previous "$commit"
  done

  git_restore
}
