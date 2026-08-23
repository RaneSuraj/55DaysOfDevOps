#!/bin/bash

set -euo pipefail

verbose=false
threshold=80
file=""

while getopts "f:t:v" opt; do
	case $opt in
		f) file="$OPTARG" ;;
		t) threshold="$OPTARG" ;;
		v) verbose=true ;;
		\?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
		:) echo "Option -$OPTARG requires an argument" >&2; exit 1 ;;
	esac
done
shift $((OPTIND - 1))
echo "FILE: ${file}"
echo "Threshold: ${threshold}"
echo "verbose: ${verbose}"
echo "Remaining args: $@"
