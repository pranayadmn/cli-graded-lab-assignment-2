#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "ERROR: Please provide exactly 1 input file(s)."
    exit 1
fi

file="$1"
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "ERROR: $file not found or not readable."
    exit 1
fi

words=$(tr -cs '[:alpha:]' '\n' < "$file")

echo "$words" | grep -iE '^[aeiou]+$' > vowels.txt
echo "$words" | grep -iE '^[bcdfghjklmnpqrstvwxyz]+$' > consonants.txt
echo "$words" | grep -iE '^[bcdfghjklmnpqrstvwxyz][a-z]*$' | grep -i '[aeiou]' > mixed.txt

echo "Processing complete."
