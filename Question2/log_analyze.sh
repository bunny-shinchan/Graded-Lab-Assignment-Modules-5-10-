#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Please provide exactly one log file as argument."
    exit 1
fi

logfile="$1"

# Check if file exists
if [ ! -e "$logfile" ]; then
    echo "Error: Log file does not exist."
    exit 1
fi

# Check if file is readable
if [ ! -r "$logfile" ]; then
    echo "Error: Log file is not readable."
    exit 1
fi

# Count total log entries
total_entries=$(wc -l < "$logfile")

# Count log levels
info_count=$(grep "INFO" "$logfile" | wc -l)
warning_count=$(grep "WARNING" "$logfile" | wc -l)
error_count=$(grep "ERROR" "$logfile" | wc -l)

# Get most recent ERROR message
recent_error=$(grep "ERROR" "$logfile" | tail -n 1)

# Get today's date
today=$(date +%Y-%m-%d)

# Report file name
report_file="logsummary_${today}.txt"

# Write report
{
    echo "Log Summary Report - $today"
    echo "---------------------------"
    echo "Total log entries: $total_entries"
    echo "INFO messages: $info_count"
    echo "WARNING messages: $warning_count"
    echo "ERROR messages: $error_count"
    echo ""
    echo "Most recent ERROR message:"
    echo "$recent_error"
} > "$report_file"

# Display summary to user
echo "Log analysis completed successfully."
echo "Report generated: $report_file"
