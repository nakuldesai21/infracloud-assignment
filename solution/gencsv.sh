#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0  give proper <start_index> <end_index>"
    exit 1
fi

start_index=$1
end_index=$2

if ! [[ "$start_index" =~ ^[0-9]+$ ]] || ! [[ "$end_index" =~ ^[0-9]+$ ]]; then
    echo "Both arguments must be integers."
    exit 1
fi

if [ "$start_index" -ge "$end_index" ]; then
    echo "Start index must be less than end index."
    exit 1
fi

output_file="inputdata"
> $output_file

for ((i=start_index; i<=end_index; i++)); do
    echo "$i, $((RANDOM % 1000))" >> $output_file
done

echo "File $output_file generated successfully."
