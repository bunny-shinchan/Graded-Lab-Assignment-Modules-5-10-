#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Please provide exactly one directory path."
    exit 1
fi

dir="$1"

# Check if directory exists
if [ ! -d "$dir" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$dir/backup"

echo "Script PID: $$"
echo "Starting background move operations..."

# Loop through files in directory
for file in "$dir"/*
do
    # Skip backup directory itself
    if [ "$(basename "$file")" = "backup" ]; then
        continue
    fi

    # Move file in background
    mv "$file" "$dir/backup/" &

    # Print PID of background process
    echo "Moving $(basename "$file") in background. PID: $!"
done

# Wait for all background processes to complete
wait

echo "All background move operations completed."
