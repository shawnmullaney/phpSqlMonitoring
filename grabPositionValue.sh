#!/bin/bash
IFS=$'\n' read -d '' -r -a array < positionList.txt
for x in "$@"
do
    echo "${array[x]}"
done
