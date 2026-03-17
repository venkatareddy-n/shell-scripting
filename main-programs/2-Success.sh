#!/bin/bash

LOG_DIR='/var/log/jenkins/'
OUTPUT_FILE="build-summary-$(date +'%Y-%m-%d').log"

# Get the timestamp for 24 hours ago in seconds since epoch
TWENTY_FOUR_HOURS_AGO=$(date -d '24 hours ago' +%s)

# Initialize counters
SUCCESS_COUNT=0
FAILURE_COUNT=0
UNSTABLE_COUNT=0

# Iterate over all .log files in the directory
for log_file in "$LOG_DIR"/*.log; do
  while IFS= read -r line; do
    # Extract timestamp from the beginning of the line
    LOG_TIMESTAMP_STR=$(echo "$line" | awk '{print $1" "$2}')
    
    # Convert log timestamp to seconds since epoch for comparison
    LOG_TIMESTAMP=$(date -d "$LOG_TIMESTAMP_STR" +%s 2>/dev/null)
    
    # Continue only if timestamp is valid and within last 24 hours
    if [[ ! -z "$LOG_TIMESTAMP" ]] && [[ $LOG_TIMESTAMP -ge $TWENTY_FOUR_HOURS_AGO ]]; then
      # Check for build status keywords and increment counters
      if echo "$line" | grep -q "SUCCESS"; then
        ((SUCCESS_COUNT++))
      elif echo "$line" | grep -q "FAILURE"; then
        ((FAILURE_COUNT++))
      elif echo "$line" | grep -q "UNSTABLE"; then
        ((UNSTABLE_COUNT++))
      fi
    fi
  done < "$log_file"
done

# Write the summary report to the output file
{
  echo "Total SUCCESS count: $SUCCESS_COUNT"
  echo "Total FAILURE count: $FAILURE_COUNT"
  echo "Total UNSTABLE count: $UNSTABLE_COUNT"
} > "$OUTPUT_FILE"