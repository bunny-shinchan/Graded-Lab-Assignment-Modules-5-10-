#!/bin/bash

# Check if input.txt exists and is readable
if [ ! -r "input.txt" ]; then
    echo "Error: input.txt file not found or not readable."
    exit 1
fi

# Convert text to one word per line (remove punctuation)
words=$(tr -c 'a-zA-Z0-9' '\n' < input.txt | tr 'A-Z' 'a-z')

# Longest word
longest_word=$(echo "$words" | awk 'length > max { max=length; word=$0 } END { print word }')

# Shortest word
shortest_word=$(echo "$words" | awk 'NR==1 || length < min { min=length; word=$0 } END { print word }')

# Average word length
average_length=$(echo "$words" | awk '{ total+=length; count++ } END { if (count>0) print total/count; else print 0 }')

# Total number of unique words
unique_words=$(echo "$words" | sort | uniq | wc -l)

# Display results
echo "Longest word: $longest_word"
echo "Shortest word: $shortest_word"
echo "Average word length: $average_length"
echo "Total number of unique words: $unique_words"
