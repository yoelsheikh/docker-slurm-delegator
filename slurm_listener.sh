#!/bin/bash
# named pipes created via mkfifo and are attached to the container in the config
PIPE_PATH="/home/skynet/pipe/mypipe"
OUTPUT_PIPE="/home/skynet/pipe/outputpipe"


while true; do
if read command < "$PIPE_PATH"; then
  IFS=" " read -r ALPH BETA GAMM <<< "$command"
  # debug
  echo "ALPH: $ALPH, BETA: $BETA, GAMM: $GAMM"
  if [[ $CMD == "squeue" ]]; then
    squeue > "$OUTPUT_PIPE"
  else
    ENV_NAME=$BETA
    PY_SCRIPT_PATH=$GAMM
    docker exec -w /home/jovyan/work $ALPH \
      bash -c "source /opt/conda/bin/activate $ENV_NAME && python $PY_SCRIPT_PATH" \
      > "$OUTPUT_PIPE" 2>&1
  fi
fi
done
