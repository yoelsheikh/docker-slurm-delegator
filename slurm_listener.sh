#!/bin/bash
# named pipes created via mkfifo and are attached to the container in the config
PIPE_PATH="/home/skynet/pipe/mypipe"
OUTPUT_PIPE="/home/skynet/pipe/outputpipe"
OUTPUT_PIPE_CONTAINER="/home/outputpipe"

while true; do
  if read command < "$PIPE_PATH"; then
    if [[ $command == "squeue" ]]; then
      # run squeue and send output back
      squeue > "$OUTPUT_PIPE"
    else
      # default to executing a job - will later be executed inside of an sbatch
      docker exec -w /home/jovyan/work jupyter-yousif \
        bash -c "source /opt/conda/bin/activate bas && python $command" \
        > "$OUTPUT_PIPE" 2>&1
    fi
  fi
done

