#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo '$DATABLOCK << EOD'
while IFS= read line; do
    echo "$line"
done
echo "EOD"

echo 'set datafile separator ","'
echo 'set terminal png size 1600,900'
echo 'set size 1,1'
echo 'set ylabel "Total Duplication"'
echo 'set xlabel "Commit Date"'
echo 'set grid'
echo 'set xdata time'
echo 'set timefmt "%Y-%m-%d %H:%M:%S"'
echo 'set format x "%Y-%m-%d"'
echo 'set xtics rotate by 90 right'
echo 'set yrange [0:*]'
echo 'set title "Total Duplication Across Time"'
echo 'set key left bottom'
echo 'plot $DATABLOCK using 1:2 with lines title "Total Lines of Duplication"'

