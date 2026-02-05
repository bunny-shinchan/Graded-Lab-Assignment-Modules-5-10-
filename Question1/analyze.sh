#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

# Store the argument
path="$1"

# Check if the path exists
if [ ! -e "$path" ]; then
    echo "Error: The specified path does not exist."
    exit 1
fi

# If the argument is a file
if [ -f "$path" ]; then
    echo "File analysis:"
    wc "$path"

# If the argument is a directory
elif [ -d "$path" ]; then
    echo "Directory analysis:"
    
    # Total number of files
    total_files=$(find "$path" -type f | wc -l)
    echo "Total number of files: $total_files"
    
    # Number of .txt files
    txt_files=$(find "$path" -type f -name "*.txt" | wc -l)
    echo "Number of .txt files: $txt_files"

# If it's neither file nor directory
else
    echo "Error: The path is neither a file nor a directory."
    exit 1
fi
