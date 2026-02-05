#!/bin/bash

# Check if both directories exist
if [ ! -d "dirA" ] || [ ! -d "dirB" ]; then
    echo "Error: dirA and/or dirB do not exist."
    exit 1
fi

echo "Files only in dirA:"
echo "-------------------"
ls dirA | grep -Fxv -f <(ls dirB)

echo ""
echo "Files only in dirB:"
echo "-------------------"
ls dirB | grep -Fxv -f <(ls dirA)

echo ""
echo "Comparing common files:"
echo "-----------------------"

# Loop through files in dirA
for file in dirA/*
do
    filename=$(basename "$file")

    # Check if same file exists in dirB
    if [ -f "dirB/$filename" ]; then
        # Compare contents
        if cmp -s "dirA/$filename" "dirB/$filename"; then
            echo "$filename : SAME content"
        else
            echo "$filename : DIFFERENT content"
        fi
    fi
done
