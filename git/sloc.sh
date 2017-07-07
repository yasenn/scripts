#!/usr/bin/env bash
# `sloc.sh` counts lines of code
# Usage: sloc.sh [path] [extension]

PATH=${1:-.}
MASK=${2:-*}

TOTAL_SLOCK_COUNTER=0
FILES_COUNTER=0

for FILENAME in $(find . -name "$MASK"); do
  FILES_COUNTER=$((FILES_COUNTER+1))
  SLOCK_COUNTER=$(cat "$FILENAME" | sort | uniq | wc --lines)
  TOTAL_SLOCK_COUNTER=$((TOTAL_SLOCK_COUNTER + SLOCK_COUNTER))
  echo "$SLOCK_COUNTER $FILENAME"
done

echo "==="
echo "Total lines: $TOTAL_SLOCK_COUNTER"
echo "Total files: $FILES_COUNTER with mask: $MASK in path: $PATH"
