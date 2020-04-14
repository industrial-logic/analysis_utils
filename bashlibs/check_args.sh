#!/bin/bash

function check_args() {
  count=$1
  shift
  if [ "$#" -ne "$count" ]; then
    echo "Requires $count parameters. Passed: " "$@"
    caller
    exit 1
  fi
}
