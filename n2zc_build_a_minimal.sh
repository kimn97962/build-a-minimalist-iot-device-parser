#!/bin/bash

# n2zc_build_a_minimal.sh
# A minimalist IoT device parser in Bash

# Configuration
DEVICE_LOG_DIR="/var/log/iot_devices"
PARSE_LOG_PATTERN="^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}),([A-Za-z0-9_-]+),([0-9.]+),([0-9.]+)$"

# Functions
parse_log_line() {
  local log_line=$1
  if [[ $log_line =~ $PARSE_LOG_PATTERN ]]; then
    timestamp=${BASH_REMATCH[1]}
    device_id=${BASH_REMATCH[2]}
    temperature=${BASH_REMATCH[3]}
    humidity=${BASH_REMATCH[4]}
    echo "Parsed log line: $timestamp - $device_id - Temperature: $temperature°C - Humidity: $humidity%"
  else
    echo "Failed to parse log line: $log_line"
  fi
}

# Main program
for file in "$DEVICE_LOG_DIR"/*.log; do
  echo "Processing file: $file"
  while IFS= read -r line; do
    parse_log_line "$line"
  done < "$file"
done