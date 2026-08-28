#!/bin/bash

set -euo pipefail

while true; do
	bash log-rotation.sh /home/suraj/DevOps_challenge/Day3/sample_logs/app_service.log 650 >> /home/suraj/DevOps_challenge/Day3/cron.txt 2>&1
	sleep 10
done
