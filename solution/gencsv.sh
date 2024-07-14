#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0  give proper <start_index> <end_index>"
    exit 1
fi

start_index=$1
end_index=$2

output_file="inputdata"
> $output_file

for ((i=start_index; i<=end_index; i++)); do
    echo "$i, $((RANDOM % 1000))" >> $output_file
done

echo "File $output_file generated successfully."
