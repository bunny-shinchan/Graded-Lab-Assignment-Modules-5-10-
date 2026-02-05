#!/bin/bash

# Check if input.txt exists and is readable
if [ ! -r "input.txt" ]; then
    echo "Error: input.txt file not found or not readable."
    exit 1
fi

# Convert text into one word per line and lowercase
words=$(tr -c 'a-zA-Z' '\n' < input.txt | tr 'A-Z' 'a-z' | grep -v '^$')

# Clear output files
> vowels.txt
> consonants.txt
> mixed.txt

# Process each word
for word in $words
do
    # Only vowels
    if echo "$word" | grep -qE '^[aeiou]+$'; then
        echo "$word" >> vowels.txt

    # Only consonants
    elif echo "$word" | grep -qE '^[bcdfghjklmnpqrstvwxyz]+$'; then
        echo "$word" >> consonants.txt

    # Mixed words starting with a consonant
    elif echo "$word" | grep -qE '^[bcdfghjklmnpqrstvwxyz]' \
         && echo "$word" | grep -q '[aeiou]'; then
        echo "$word" >> mixed.txt
    fi
done

echo "Pattern extraction completed."
