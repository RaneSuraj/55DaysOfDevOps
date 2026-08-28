#!/bin/bash

set -euo pipefail

log() {
	echo "$1"
}

rotate_log() {
	local FILE=$1
	local MAX_SIZE=$2

	if [[ ! -f ${FILE} ]]; then
		log "ERROR: File does not exixts...."
		exit 1
	fi

	local CURRENT_SIZE
	CURRENT_SIZE=$(du -k ${FILE} | cut -f1)

	if (( ${CURRENT_SIZE} > ${MAX_SIZE} )); then
		local TIMESTAMP
		TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
		mv "${FILE}" "${FILE}_${TIMESTAMP}"
		touch "${FILE}"
		gzip "${FILE}_${TIMESTAMP}"
		log "Log rotated successfully and created = "${FILE}_${TIMESTAMP}.gz"...as current log file size is: ${CURRENT_SIZE} > ${MAX_SIZE}"
	fi

	log "Current Size for the ${FILE} is: ${CURRENT_SIZE} < ${MAX_SIZE}"
}

main() {
	rotate_log $1 $2
}

main "$@"
