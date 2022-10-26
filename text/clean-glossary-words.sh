#!/usr/bin/env bash
# this script prints only words from file $1 that don't exist in file $2

for WORD in $(cat ${1} | xargs); do 
  if  $(grep -i "${WORD}" ${2} > /dev/null)  ; then 
    echo ${WORD}
  fi
done | pv -l
