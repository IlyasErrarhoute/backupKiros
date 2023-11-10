
#!/bin/bash

# Configuration
backup_dir="/path/to/backups"
source_dir="/path/to/source"
backup_file="$backup_dir/$(date +"%d-%m-%Y_%H-%M-%S").tar.gz"
log_file="$backup_dir/backup_log.txt"

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "This script requires root privileges. Please run as root."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Log the current step
echo "$(date +"%Y-%m-%d %H:%M:%S"): Starting backup process" >> "$log_file"

# Capture the date
current_date=$(date +"%Y%m%d")

# Compress and move source directories to backup directory
tar -czf "$backup_file" -C "$source_dir" .
echo "$(date +"%Y-%m-%d %H:%M:%S"): Backup completed successfully: $backup_file" >> "$log_file"
