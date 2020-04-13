#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# shellcheck source=.

function check_code() {
  check_args 0 "$@"

  "${SCRIPT_DIR}/pmd-bin-*/bin/run.sh" cpd --minimum-tokens 20 --files src
}

