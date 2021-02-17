#!/bin/bash

mkdir apps
cd apps

# download app
curl -o cellranger-5.0.1.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-5.0.1.tar.gz?Expires=1613392910&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci01LjAuMS50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2MTMzOTI5MTB9fX1dfQ__&Signature=jCzQaXWhnVZFXxqfIeJCD0gnz0ULZoHPkntqQ-gIiMu~iuUWONLycXrxB4U7QpuCX9Z62~UTfGVdQM-T90NgEm6yg4Krcys5vys-FAzK48vKLima7xB8efUOd4W~sZ0YAnKU1lve4qlLI79Hd81tDHPQr162-2IakmvUxpW4GpM6tZzCr1FUxoWEFz8Z-mS3Ixl7nhB22i3bR6KngA1pR8I1S-pkwSGrltsm9OHgDVENAR25CSBVPqEqyZrjAuIclDAZzI6p40GgRIYM5z3NpRb3cTyQjl9B7CogA1DqvrIYSwChKfnh2j6O6cBZanav30K3ktHYTwm-DGcGAUvMtw__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"

tar -xzvf cellranger-5.0.1.tar.gz

# # should see something like..
# cellranger-3.1.0/
# cellranger-3.1.0/cellranger-tiny-fastq/
# cellranger-3.1.0/cellranger-tiny-fastq/3.0.0/
# cellranger-3.1.0/cellranger-tiny-fastq/3.0.0/tinygex_S1_L001_I1_001.fastq.gz
# cellranger-3.1.0/cellranger-tiny-fastq/3.0.0/tinygex_S1_L002_R1_001.fastq.gz
# cellranger-3.1.0/cellranger-tiny-fastq/3.0.0/tinygex_S1_L001_R1_001.fastq.gz
# cellranger-3.1.0/cellranger-tiny-fastq/3.0.0/tinygex_S1_L002_R2_001.fastq.gz
# cellranger-3.1.0/cellranger-tiny-fastq/3.0.0/tinygex_S1_L002_I1_001.fastq.gz
# cellranger-3.1.0/cellranger-tiny-fastq/3.0.0/tinygex_S1_L001_R2_001.fastq.gz
# ...
# ... wait for the command to finish ...

# move into directory
cd cellranger-5.0.1

# set path
export PATH=$HOME/10x-snake/apps/cellranger-5.0.1:$PATH

echo "which cellranger"
which cellranger

# should look like this...
## ~/10x-snake/yard/apps/cellranger-5.0.1/cellranger

# preform test run

echo "starting test run..."
cellranger testrun --id=check_install