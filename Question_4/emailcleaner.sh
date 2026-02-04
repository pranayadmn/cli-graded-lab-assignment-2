#!/bin/bash

input="emails.txt"
if [ ! -f "$input" ] || [ ! -r "$input" ]; then
    echo "ERROR: $input not found or not readable."
    exit 1
fi

grep -E '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' "$input" | sort | uniq > valid.txt
grep -Ev '^[a-zA-Z0-9]+@[a-zA-Z]+\.com$' "$input" > invalid.txt

echo "Processing complete."
