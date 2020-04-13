#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "$SCRIPT_DIR"/check_args.sh

function git_files_in_commit {
  check_args 1 "$@"

  commit=$1
  git diff-tree --no-commit-id --name-only -r "$commit"
}

function git_current_commit {
  git log --pretty=format:'%H' -n 1
}

function git_last_commit_for_file {
  check_args 1 "$@"

  file=$1
  commits=($(git log -n 2 --pretty=format:%H -- $file))
  echo "${commits[1]}"
}

function git_move_file_to_commit {
  check_args 1 "$@"

  file=$1
  last_commit=$(git_last_commit_for_file $cf)

  if [ ! -z "$last_commit" ]; then
    git show $last_commit:$file > $file
  fi
}


function move_files_to_previous {
  current_commit=$(git_current_commit)
  files=($(git_files_in_commit $current_commit))
  for cf in "${files[@]}"; do
    git_move_file_to_commit $cf 
  done
}

