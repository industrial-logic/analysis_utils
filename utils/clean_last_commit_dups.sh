#!/bin/bash

SCRIPT_DIR="$1"

function cleanup() {
  if [[ 'HEAD' == "$INITIAL_BRANCH" ]]; then # detatched head
    git checkout "$INITIAL_COMMIT" >/dev/null 2>&1
  else
    git checkout "$INITIAL_BRANCH" >/dev/null 2>&1
  fi
}

trap cleanup EXIT

function process_repo() {
  PWD=$(pwd)
  PROJ=$(basename $PWD)
  INITIAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  INITIAL_COMMIT=$(git rev-parse HEAD)

  for i in $(git log --pretty=format:"%H" -n $TOTAL_COMMITS_BACK); do
    git checkout $i 2>/dev/null
    COMMIT_DATE=$(git show -s --format=%ci $i)
    START_COMMIT=$(git rev-parse HEAD)
    START_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    START_TOKEN_COUNT=$(total)
    git checkout HEAD^ 2>/dev/null
    END_TOKEN_COUNT=$(total)
    DIFF=$(expr $START_TOKEN_COUNT - $END_TOKEN_COUNT)
    if [[ $END_TOKEN_COUNT -gt 0 ]]; then
      DELTA=$(expr $DIFF \* 100 / $END_TOKEN_COUNT)
    else
      DELTA=0
    fi
    printf "%-30s: Diff: %8d (%4d%%) Current: %7d Previous: %7d Commit: %7s [%s]\n" \
      "$PROJ" "$DIFF" "$DELTA" "$START_TOKEN_COUNT" "$END_TOKEN_COUNT" \
      "$START_COMMIT" "$COMMIT_DATE"
  done
}
