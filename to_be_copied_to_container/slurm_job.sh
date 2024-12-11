#!/bin/bash
ENV_NAME=$1
PY_SCRIPT_PATH=$2
PIPE_PATH="/home/mypipe"
OUTPUT_PIPE="/home/outputpipe"

CONTAINER_ID=$(cat /etc/hostname)

if [[ -p $PIPE_PATH ]]; then
  echo "$CONTAINER_ID $ENV_NAME $PY_SCRIPT_PATH" > "$PIPE_PATH"
  
  # wait and output the contents of the pipe
  while read line < "$OUTPUT_PIPE"; do
    echo "$line"  # pipe output
  done
else
  echo "Pipe $PIPE_PATH does not exist. exiting."
  exit 1
fi
