#!/bin/bash

# Check if emails.txt exists and is readable
if [ ! -r "emails.txt" ]; then
    echo "Error: emails.txt file not found or not readable."
    exit 1
fi

# Extract valid email addresses
grep -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt > valid.txt

# Remove duplicate valid emails
sort valid.txt | uniq > temp.txt
mv temp.txt valid.txt

# Extract invalid email addresses
grep -Ev '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' emails.txt > invalid.txt

echo "Email cleaning completed."
echo "Valid emails stored in valid.txt"
echo "Invalid emails stored in invalid.txt"
