#!/usr/bin/awk -f

BEGIN {
  sum=0
}

{
    sum += $2
    next
}

END {
    print sum
}

