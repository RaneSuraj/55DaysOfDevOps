#!/bin/bash

set -euo pipefail

# ============================================================================================================================
# log_manager.sh
# A script to manage log rotation, retention, and monitor disk usage.
# ============================================================================================================================

usage() {
	echo "Usage: $0 -d <log_directory> [-s max_size_kb] [-r retention_days] [-t disk_threshold_percent]"
	echo "  -d  Directory containing .log files (Required)"
    	echo "  -s  Maximum file size in KB before rotation (Default: 1024)"
    	echo "  -r  Number of days to keep rotated logs (Default: 7)"
    	echo "  -t  Disk usage percentage threshold for alerts (Default: 80)"
    	exit 1
}


log() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a $LOG_FILE
}

send_alert() {
	echo "ALERT: $1" >&2
}

rotate_log() {
	local logfile="$1"
	local max_size_kb="$2"
	
	# checkinf file is present or not
	if [ ! -f "${logfile}" ];then
		echo "ERROR: File ${logfile} doesn't exists"
		exit 1
	fi
	
	# get current size of the file
	local current_size_kb
	current_size_kb=$(du -k "${logfile}" | cut -f1)

	if [ "${current_size_kb}" -ge "${max_size_kb}" ]; then
		local timestamp
		timestamp=$(date +'%Y%m%d_%H%M%S')
		
		local rotated_file="${logfile}_${timestamp}"
		log "Rotating $logfile (Size: ${current_size_kb}KB >= ${max_size_kb}KB)"

		mv "${logfile}" "${rotated_file}"
		touch "${logfile}"
		gzip "${rotated_file}"
	fi
}

cleanup_old_logs() {
	local log_dir=$1
	local retention_days=$2

	log "Cleaning up logs older than $retention_days days in $log_dir"

	find "${log_dir}" -type f -name "*.log*.gz" -mtime "${retention_days}" -exec rm -f {} \;
}

check_disk_usage() {
	local threshold="$1"
	local status=0

	while read -r usage mount; do
		local usage_val="${usage%\%}"
		
		if [ "${usage}" -ge "${threshold}" ]; then
			log "Warning: Mount $mount_point is at ${usage_pct} (Threshold: ${threshold}%)"
			status=1
		fi
	done < <(df -hP | awk 'NR>1 {print $5, $6}')
	
	return "$status"
}

main() {
	local log_dir="" max_size=1024 retention=7 threshold=80

	while getopts "d:s:r:t:" opt; do
		case $opt in
			d) log_dir="$OPTARG" ;;
			s) max_size="$OPTARG" ;;
			r) retention="$OPTARG" ;;
			t) threshold="$OPTARG" ;;
			\?) usgae ;;
		esac
	done

	[ -z "log_dir" ] && usage

	log "Starting log management for $log_dir"

	# Rotate eligible logs
	for logfile in "$log_dir"/*.log; do
		rotate_log "$logfile" "$max_size"
	done

	# Clean up old rotated logs
	cleanup_old_logs "$log_dir" "$retention"

	# Check disk usage against threshold
	if ! check_disk_usage "$threshold"; then
        	send_alert "Disk usage threshold exceeded on $(hostname)"
        	exit 1
    	fi

	log "Log management complete"

	exit 0
}

main "$@"
