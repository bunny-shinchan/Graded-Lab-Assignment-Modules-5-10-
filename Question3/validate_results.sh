#!/bin/bash

# Check if marks.txt exists and is readable
if [ ! -r "marks.txt" ]; then
    echo "Error: marks.txt file not found or not readable."
    exit 1
fi

# Counters
fail_one_count=0
pass_all_count=0

echo "Students who failed in exactly ONE subject:"

# Read file line by line
while IFS=',' read -r roll name m1 m2 m3
do
    fail_count=0

    # Check each subject
    if [ "$m1" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    if [ "$m2" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    if [ "$m3" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    # Failed in exactly one subject
    if [ "$fail_count" -eq 1 ]; then
        echo "$roll, $name"
        fail_one_count=$((fail_one_count + 1))
    fi

    # Passed in all subjects
    if [ "$fail_count" -eq 0 ]; then
        pass_all_count=$((pass_all_count + 1))
    fi

done < marks.txt

echo ""
echo "Students who passed in ALL subjects:"
echo "-----------------------------------"

# Second pass to print passed students
while IFS=',' read -r roll name m1 m2 m3
do
    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then
        echo "$roll, $name"
    fi
done < marks.txt

echo ""
echo "Summary:"
echo "--------"
echo "Students failed in exactly one subject: $fail_one_count"
echo "Students passed in all subjects: $pass_all_count"
