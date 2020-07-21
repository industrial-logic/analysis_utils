#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [ ! -d "./src" ]; then
    echo "Does not appear to be a java project" >&2
    exit 1
fi

$SCRIPT_DIR/utils/dups_by_commit.sh | $SCRIPT_DIR/utils/to_gnuplot.sh | gnuplot
