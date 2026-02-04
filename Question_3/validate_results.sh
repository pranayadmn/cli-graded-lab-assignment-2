#!/bin/bash

file="marks.txt"
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "ERROR: $file not found or not readable."
    exit 1
fi

pass_all=0
fail_one=0

echo "Students who failed in exactly 1 subject(s):"
while IFS=',' read -r roll name m1 m2 m3
do
    fail_count=0

    if [ "$m1" -lt 33 ]; then
        ((fail_count++))
    fi
    if [ "$m2" -lt 33 ]; then
        ((fail_count++))
    fi
    if [ "$m3" -lt 33 ]; then
        ((fail_count++))
    fi

    if [ "$fail_count" -eq 1 ]; then
        echo "$roll $name"
        ((fail_one++))
    fi
done < "$file"

echo
echo "Students who passed all 3 subjects:"
while IFS=',' read -r roll name m1 m2 m3
do
    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then
        echo "$roll $name"
        ((pass_all++))
    fi
done < "$file"

echo
echo "Count passed all: $pass_all"
echo "Count failed exactly one: $fail_one"
