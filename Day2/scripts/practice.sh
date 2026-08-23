#!/bin/bash

set -euo pipefail

: <<'COMMENT'

# how to handle aritmetic in conditional loops concept
is_even() {
	#(( $1 % 2 == 0 ))
	if (( $1 % 2 == 0 )); then
		return 0
	else
		return 1
	fi
}


num=$1

if is_even "${num}"; then
	echo "Number is Even"
else
	echo "Number is Odd"
fi
#COMMENT


# Function can't return data, only return numeric value (0-255) concept
get_hostname() {
	# return "server - $1" --- this won't work as in shell we can't return data only return numeric value (0-255)
	# we are getting this error [./script.sh: line 26: return: server - prod: numeric argument required]

	echo "server - $1"
}

name=$(get_hostname $1)
echo "Server name is: ${name}"
#COMMENT

# Local Variable concept
COUNT=10

update_count() {
	local COUNT=5
	echo "Inside Count is: ${COUNT}"
}

update_count

echo "Outside count is: ${COUNT}"
COMMENT

# Passing Arguments to Functions Concept

log () {
	echo "[$(date)] $1..."
}


check_disk_usage() {
	local threshold=$1
	local usage
	usage=$(df /mnt/c | awk 'NR == 2 {print $5}' | tr -d "%")
	if [ ${usage} -ge ${threshold} ]; then
		log "WARNING: Disk Usage at ${usage}%"
	else
		log "INFO: Disk Usage is OK ${usage}"
	fi
}

main() {
	log "Starting Health Check"
	check_disk_usage 80
	log "Health Check Completed"
}

main



