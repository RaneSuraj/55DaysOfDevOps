#!/bin/bash

# CRONTAB entry can be like this --> */15 * * * * /home/suraj/DevOps_challenge/Day2/log_monitor.sh >> /var/log/log_monitor.log 2>&1

set -euo pipefail

FILE=""
THRESHOLD=5
VERBOSE=false
ERROR_COUNT=0


while getopts ":f:t:v" opt; do
	case $opt in
		f) FILE="${OPTARG}";;
		t) THRESHOLD="${OPTARG}";;
		v) VERBOSE=true;;
		\?) echo "Invalid Option: -${OPTARG}" >&2; exit 1;;
		:) echo "Option -$OPTARG requires an argument" >&2; exit 1;;
	esac
done

if [[ -z "$FILE" ]]; then
        echo "Usage: $0 -f <file> [-t threshold] [-v]" >&2
        exit 1
fi

log() {
	local message=$1
	echo "[$(date)] ${message}"
}

check_errors() {

	if [[ ! -f "$FILE" ]]; then
        	echo "Error: ${FILE} not found" >&2
        	exit 1
	fi

        while IFS= read -r line; do
                if [[ $line == *ERROR* ]]; then
           	             ERROR_COUNT=$(( ERROR_COUNT + 1))
                        if [[ "$VERBOSE" == true ]]; then
                                log "MATCH: ${line}"
                        fi
                fi
        done < "$FILE"
}

main() {
	log "----- Stating Log Monitoring Script -----"
	check_errors
	if [[ ${ERROR_COUNT} -gt ${THRESHOLD} ]]; then
		log "WARNING: Error count exceeds the threshold ${ERROR_COUNT} > ${THRESHOLD} ..."
		exit 1
	else
		log "----- ERROR Count is within threshold limit -----"
		log "----- Ended Log Monitoring Script -----"
		exit 0
	fi
}

main "$@"
