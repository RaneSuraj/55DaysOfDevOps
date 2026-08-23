#!/bin/bash

set -euo pipefail

while IFS= read -r line; do
	echo "Processing: ${line}"
done < "../logs/app.log"


count=0
while IFS= read -r line; do
	count=$((count + 1))
done < "../logs/app.log"
echo ${count}


while IFS= read -r line; do
	if [[ ${line} == *ERROR* ]]; then
		echo "ALERT: ${line}"
	fi
done < "../logs/app.log"


line_count=0
while IFS= read -r line; do
	line_count=$((line_count + 1))
	echo "${line_count}: $line"
done < "../logs/app.log"
