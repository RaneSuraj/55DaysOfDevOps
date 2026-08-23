#!/bin/bash

set -euo pipefail


if [ $# -eq 0 ]; then
	echo "Usage: $0"
	exit 1
fi

LOGFILE=$1

if [ ! -f "${LOGFILE}" ]; then
	echo "Error: ${LOGFILE} does not exist"
	exit 1
fi

ERROR_COUNT=$(awk '
BEGIN {
	total=0
} 
$3 == "[ERROR]" {
	total += 1
} 
END {
	print total
}' "$LOGFILE" ) 

echo "Error Count is: ${ERROR_COUNT}"


echo "---------- Error Count total according to Hours ------------"
awk '
BEGIN {
	printf "%-15s | %s\n", "Error_Hour", "Count"
	printf "----------------|--------\n"
}
$3 == "[ERROR]" {
	split($2, hour, ":")
	timestamp = hour[1] 
	total[timestamp]++
}
END {
	for (t in total) {
		printf "%-15s | %d\n", t, total[t] | "sort -t \"|\" -k 2 -nr"
	}
}
' "$LOGFILE"


awk ' $3 == "[ERROR]" {print $0}' "$LOGFILE" | cut -d " " -f 4- | sort -u

echo "$(date) Completed Successful...."
