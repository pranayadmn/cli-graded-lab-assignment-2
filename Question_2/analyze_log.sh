#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "ERROR: Please provide exactly 1 log file(s)."
    exit 1
fi

logfile="$1"
if [ ! -f "$logfile" ] || [ ! -r "$logfile" ]; then
    echo "ERROR: File does not exist or is not readable."
    exit 1
fi

total=$(wc -l < "$logfile")
info=$(grep -c " INFO " "$logfile")
warning=$(grep -c " WARNING " "$logfile")
error=$(grep -c " ERROR " "$logfile")

recent_error=$(grep " ERROR " "$logfile" | tail -n 1)

echo "Total entries: $total"
echo "INFO:                 $info"
echo "WARNING:              $warning"
echo "ERROR:                $error"
echo "Most recent ERROR:    $recent_error"

date_str=$(date +%Y-%m-%d)
report="logsummary_${date_str}.txt"

{
echo "Total entries: $total"
echo "INFO:                 $info"
echo "WARNING:              $warning"
echo "ERROR:                $error"
echo "Most recent ERROR:    $recent_error"
} > "$report"
