#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

. "${SCRIPT_DIR}/bashlibs/check_src.sh"

check_src_dir

# quick hack to parameterize
BACK=${1:-''}

$SCRIPT_DIR/utils/dups_by_commit.sh $BACK | $SCRIPT_DIR/utils/to_gnuplot.sh | gnuplot
