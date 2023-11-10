#!/bin/bash

# Configuration
backup_dir="/path/to/backups"
restore_dir="/path/to/restore"
log_file="$restore_dir/restore_log.txt"

# Display a warning and prompt for user confirmation
read -p "Warning: Restoring will overwrite all data. Continue? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "Restore aborted."
    exit 1
fi

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script requires root privileges. Please run as root."
    exit 1
fi

# Log the current step
echo "$(date +"%Y-%m-%d %H:%M:%S"): Starting restore process" >> "$log_file"

# Identify and restore the latest backup
latest_backup=$(ls -t "$backup_dir"/*.tar.gz | head -1)
tar -xzf "$latest_backup" -C "$restore_dir"
echo "$(date +"%Y-%m-%d %H:%M:%S"): Restore completed successfully from: $latest_backup" >> "$log_file"

# Reinstall packages
# Add your package installation commands here

echo "Restore process completed successfully."
