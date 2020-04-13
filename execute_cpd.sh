#!/bin/bash

# shellcheck source=.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/get_pmd.sh"

function check_code() {
  check_args 0 "$@"

  "$(pmd_run)" cpd --minimum-tokens 20 --files src
}

