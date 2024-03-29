#!/bin/bash -login
#SBATCH -p high                # partition, or queue, to assign to
#SBATCH -J ets04               # name for job
#SBATCH -N 1                   # one "node", or computer
#SBATCH -n 1                   # one task for this node
#SBATCH -c 1                   # one core per task
#SBATCH -t 24:00:00            # ask for no more than 30 minutes
#SBATCH --mem=60Gb             # 65Gb should be enough
#SBATCH --mail-user=nasiegel@ucdavis.edu        # email address to recieve notification
#SBATCH --mail-type=ALL                         # NOTIFICATIONS OF SLURM JOB STATUS

# initialize conda
. ~/miniconda3/etc/profile.d/conda.sh

# activate your desired conda environment
conda activate snake

# go to the directory you ran 'sbatch' in, OR just hardcode it...

# fail on weird errors
set -o nounset
set -o errexit
set -x

# Select which snakefile yow want to submit
cd $HOME/10x-snake

snakemake --use-conda

# print out various information about the job
env | grep SLURM            # Print out values of the current jobs SLURM environment variables

scontrol show job ${SLURM_JOB_ID}     # Print out final statistics about resource uses before job exits

sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch 
