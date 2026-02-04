#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "ERROR: Please provide dirA and dirB."
    exit 1
fi

dirA="$1"
dirB="$2"

if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
    echo "ERROR: One or both directories do not exist."
    exit 1
fi

echo "Files only in $dirA:"
for f in "$dirA"/*
do
    name=$(basename "$f")
    if [ ! -e "$dirB/$name" ]; then
        echo "$name"
    fi
done

echo
echo "Files only in $dirB:"
for f in "$dirB"/*
do
    name=$(basename "$f")
    if [ ! -e "$dirA/$name" ]; then
        echo "$name"
    fi
done

echo
echo "Files present in both directories:"
for f in "$dirA"/*
do
    name=$(basename "$f")
    if [ -f "$dirB/$name" ]; then
        if cmp -s "$dirA/$name" "$dirB/$name"; then
            echo "$name (MATCH)"
        else
            echo "$name (DIFFER)"
        fi
    fi
done
