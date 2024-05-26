#!/bin/bash

# Directory to search for log files
LOG_DIR="/var/lib/docker/containers"

# Check if the directory exists
if [ -d "$LOG_DIR" ]; then
  # Find and truncate log files
  find "$LOG_DIR" -type f -name "*.log" -exec sh -c '> "$1"' _ {} \;

  echo "$(date '+%Y-%m-%d %H:%M:%S') - Log files in $LOG_DIR have been cleaned up."
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Directory $LOG_DIR does not exist."
fi
