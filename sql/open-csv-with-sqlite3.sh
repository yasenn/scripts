#!/usr/bin/env bash
# Opens CSV file as a TABLE in `sqlite3`
 
function usage {
    echo "Usage: $0 <CSV_file> [<table_name>] [mode]"
    exit 1
}
 
[ $# -lt 1 ] && usage
CSV_FILE="$1"
[ ! -s "$CSV_FILE" ] && echo "missing or empty file: $CSV_FILE" && exit 1
 
TABLE_NAME="${CSV_FILE%%\.csv}"
TABLE_NAME="${2:-TABLE_NAME}"
[ -z "$TABLE_NAME" ] && echo "Unable to determine table name"
if [[ $TABLE_NAME =~ [-] ]] ; then
    echo "Table name cannot contain hypen - converting to underscore (_)"
    TABLE_NAME=$(echo "$TABLE_NAME"|tr "-" "_")
fi
 
MODE=${3:-csv}

echo "CSV file  : $CSV_FILE"
echo "Table name: $TABLE_NAME"
echo "Mode: $MODE"
 
sqlite3 -interactive \
    -cmd ".mode ${MODE}" \
    -cmd ".mode columns" \
    -cmd ".headers on" \
    -cmd ".import $CSV_FILE '$TABLE_NAME'"
