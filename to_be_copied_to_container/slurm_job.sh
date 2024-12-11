#!/bin/bash
ENV_NAME=$1
PY_SCRIPT_PATH=$2
PIPE_PATH="/home/mypipe"

if [[ -p $PIPE_PATH ]]; then
  echo "$ENV_NAME $PY_SCRIPT_PATH" > "$PIPE_PATH"
else
  echo "Pipe $PIPE_PATH does not exist. Exiting."
  exit 1
fi
