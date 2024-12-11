#!/bin/bash
PIPE_PATH="/home/mypipe"
OUTPUT_PIPE="/home/outputpipe"

# slurm command (e.g. squeue, sbatch, etc.) which is an argumet for this script
SLURM_COMMAND=$1

# pass it to the pipe in skynet
echo "$SLURM_COMMAND" > "$PIPE_PATH"

# wai for and print the output, i.e. so that the container user can see if there are errors
if [[ -p $OUTPUT_PIPE ]]; then
  while read -r line; do
    echo "$line"
  done < "$OUTPUT_PIPE"
else
  echo "Output pipe $OUTPUT_PIPE does not exist."
fi

