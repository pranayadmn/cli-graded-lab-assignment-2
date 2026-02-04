#!/bin/bash

file="input.txt"
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "ERROR: $file not found or not readable."
    exit 1
fi

words=$(tr -cs '[:alnum:]' '\n' < "$file")
longest=$(echo "$words" | awk '{ if (length>max){ max=length; word=$0 } } END{ print word }')
shortest=$(echo "$words" | awk 'NR==1{min=length; word=$0} { if(length<min){ min=length; word=$0 } } END{ print word }')
avg=$(echo "$words" | awk '{ total+=length; count++ } END{ if(count>0) printf "%.2f", total/count }')
unique=$(echo "$words" | sort | uniq | wc -l)

echo "Longest word:             $longest"
echo "Shortest word:            $shortest"
echo "Average word length:      $avg"
echo "Total unique words: $unique"
