
#!/bin/bash

# Usage: ./error_summary.sh <logfile>

LOGFILE="$1"

if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' not found!"
    exit 2
fi

echo "Error Summary for '$LOGFILE':"
echo "=============================="

# Extract lines with 'error', sort, count unique, and sort by frequency
grep -i "error" "$LOGFILE" | sort | uniq -c | sort -nr | while read COUNT LINE; do
    echo
    echo "Occurrences: $COUNT"
    echo "Error Message: $LINE"
done
