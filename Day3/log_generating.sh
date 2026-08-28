#!/usr/bin/env bash
set -euo pipefail

mkdir -p sample_logs

log_levels=("INFO" "WARN" "ERROR" "DEBUG")
components=("auth_service" "payment_gateway" "db_pool" "api_router" "cache_layer")

echo "Generating 10 log files (100 KB - 900 KB)..."

for i in $(seq 1 10); do
    # Pick a target size randomly between 100 KB and 900 KB
    target_kb=$(( RANDOM % 801 + 100 ))
    filename="sample_logs/app_service_${i}.log"
    
    # Generate random structured log lines until target size is reached
    while [ $(du -k "$filename" 2>/dev/null | cut -f1 || echo 0) -lt $target_kb ]; do
        timestamp=$(date -d "@$(($(date +%s) - RANDOM % 86400))" "+%Y-%m-%d %H:%M:%S")
        level=${log_levels[$((RANDOM % ${#log_levels[@]}))]}
        comp=${components[$((RANDOM % ${#components[@]}))]}
        payload=$(head -c 64 /dev/urandom | base64 | tr -d '\n')
        
        echo "[$timestamp] [$level] [$comp] Transaction payload payload_hash=$payload processed in $((RANDOM % 500))ms" >> "$filename"
    done
    
    actual_kb=$(du -k "$filename" | cut -f1)
    echo "Created $filename -> ${actual_kb} KB"
done

echo "Done!"
