#### slurm_command.sh
this script sends a slurm command from the container to the host through a named pipe and waits for the command's output to return via another pipe

usage:  
```
./slurm_command.sh "slurm_command"
```
- input:  
  - `slurm_command`: the slurm command to be executed on the host (e.g., `"squeue" or "sinfo"`, `"sbatch script.sh"`, etc.). currently only squeue is possible to run for testing
- output:  
  the result of the slurm command, printed to the console.
- example:  
to check the status of all jobs in the queue:  
```
./slurm_command.sh "squeue"
```

#### slurm_job.sh  
this script sends job information (a conda environment name and a python script path) to the host through a named pipe. the host processes the job in the slurm queue. use this if
you want to run a python script and a conda env by sending them to the job queue

usage:  
```
./slurm_job.sh environment_name script_path
```
- input:  
  - `environment_name`: the name of the conda environment to activate.  
  - `script_path`: the path to the python script to execute.
- example:  
to submit a job with the environment `some_env` and the script `some_traininig_script.py` (`some_env` should already be a valid local conda env that contains the necessary libraries to execute your script):
```
./slurm_job.sh some_env /path/to/some_traininig_script.py
