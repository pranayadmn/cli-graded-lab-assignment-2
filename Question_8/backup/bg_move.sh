#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "ERROR: Please provide exactly 1 directory path(s)."
    exit 1
fi

dir="$1"
if [ ! -d "$dir" ]; then
    echo "ERROR: Directory $dir not found."
    exit 1
fi

backup="$dir/backup"
mkdir -p "$backup"

for file in "$dir"/*
do
    if [ -f "$file" ]; then
        mv "$file" "$backup/" &
        echo "Started PID: $!"
    fi
done

wait
echo "All background moves completed. Shell PID: $$"
