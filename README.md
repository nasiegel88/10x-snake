# 10x-snake
### Author: Noah Siegel
### Email: nasiegel@ucdavis.edu
### Last update: 2021-02-16
General snakemake pipeline to generate cell matrices for single-cell analysis and ```.loom ```files to assess cell development.

## Summary
* Usage
* Output
* Next Steps
* References

### Usage:
Go to the cellranger download page and install the lastest version of cellranger. You will need to enter you name, email, and institution.
```
https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest
```

Once you have the link to download the lastest installation of cellranger replace the url in 
```ranger-build.sh```:
```
mkdir apps
cd apps

# New url here
curl -o cellranger-5.0.1.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-5.0.1.tar.gz?Expires=1613392910&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci01LjAuMS50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2MTMzOTI5MTB9fX1dfQ__&Signature=jCzQaXWhnVZFXxqfIeJCD0gnz0ULZoHPkntqQ-gIiMu~iuUWONLycXrxB4U7QpuCX9Z62~UTfGVdQM-T90NgEm6yg4Krcys5vys-FAzK48vKLima7xB8efUOd4W~sZ0YAnKU1lve4qlLI79Hd81tDHPQr162-2IakmvUxpW4GpM6tZzCr1FUxoWEFz8Z-mS3Ixl7nhB22i3bR6KngA1pR8I1S-pkwSGrltsm9OHgDVENAR25CSBVPqEqyZrjAuIclDAZzI6p40GgRIYM5z3NpRb3cTyQjl9B7CogA1DqvrIYSwChKfnh2j6O6cBZanav30K3ktHYTwm-DGcGAUvMtw__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"

tar -xzvf cellranger-5.0.1.tar.gz
```

Next, run the following command.
```
bash ranger-build.sh
```
Note, you should only have to do the above for the first time running ```10x-snake```. If cellranger is already installed on your system you will still need to perform the approve to add cellranger to the path of this directory.

### Outputs:
```
output/
      |
      |__ETS_NEO__
      |           |_outs_
      |                  |
      |                  |_filtered_feature_bc_matrix/ # used to assess single cell expression in Seurat
      |                  |__velocyto/ETS_NEO_MI.loom # used to assess rna velocit in Seurat
      |
      |__FA_NEO__
                  |_outs_
                         |
                         |_filtered_feature_bc_matrix/
                         |__velocyto/FA_NEO_MI.loom
```
* Note that there is no limit to the number of samples that can run through 10-snake.

### Next Steps...
Most of the single analysis pipeline can be done in R using the package called [Seuarat](). Here are some useful vignettes to get started with the downsteam analysis
* Normalization: [scTransform normalization](https://satijalab.org/seurat/articles/sctransform_vignette.html)
* Integration of multiple samples: [Integration using scTransform](https://satijalab.org/seurat/archive/v3.0/integration.html)
* Comparing treatement groups: [Fast integration](https://satijalab.org/seurat/articles/integration_rpca.html)
* Differential expression analysis: [DEG](https://satijalab.org/seurat/articles/de_vignette.html)
* RNA velosity: [Estimating RNA Velocity using Seurat and scVelo](https://htmlpreview.github.io/?https://github.com/satijalab/seurat-wrappers/blob/master/docs/scvelo.html)
### References:
1. [Hafemeister et al., Genome Biology 2019](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1874-1)
2. [Stuart, Butler, et al., Cell 2019](https://www.cell.com/cell/fulltext/S0092-8674(19)30559-8)
3. [Butler et al., Nat Biotechnol 2018](https://www.nature.com/articles/nbt.4096)
4. [La Manno et al, Nature 2018](https://www.nature.com/articles/s41586-018-0414-6)