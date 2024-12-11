#!/bin/bash
# named pipes created via mkfifo and are attached to the container in the config
PIPE_PATH="/home/skynet/pipe/mypipe"
OUTPUT_PIPE="/home/skynet/pipe/outputpipe"


while true; do
if read command < "$PIPE_PATH"; then
  IFS=" " read -r CMD ARGS <<< "$command"
  if [[ $CMD == "squeue" ]]; then
    squeue > "$OUTPUT_PIPE"
  else
    ENV_NAME=$CMD
    PY_SCRIPT_PATH=$ARGS
    docker exec -w /home/jovyan/work jupyter-yousif \
      bash -c "source /opt/conda/bin/activate $ENV_NAME && python $PY_SCRIPT_PATH" \
      > "$OUTPUT_PIPE" 2>&1
  fi
fi
done
