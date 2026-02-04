#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "ERROR: Please provide exactly 1 argument(s)."
  exit 1
fi

path=$1
if [ ! -e "$path" ]; then
  echo "ERROR: Path does not exist."
  exit 1
fi

if [ -f "$path" ]; then
  echo "   Lines   Words   Chars File"
  wc "$path"
elif [ -d "$path" ]; then
  total_files=$(find "$path" -type f | wc -l)
  txt_files=$(find "$path" -type f -name "*.txt" | wc -l)

  echo "Total files:       $total_files"
  echo "Text (.txt) files: $txt_files"
else
  echo "ERROR: Unsupported type."
  exit 1
fi
