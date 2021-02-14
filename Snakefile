configfile: "config.yaml"
import io 
import os
import pandas as pd
import pathlib
from snakemake.exceptions import print_exception, WorkflowError

# Configuration file variables
INPUT=config['indir']
SUF = config["suffix"]
R1_SUF = str(config["r1_suf"])
R2_SUF = str(config["r2_suf"])
CELL_NUMBER = config['cell_number']
PROJECT = config['proj_name']

# Use glob statement to find all samples in 'raw_data' directory
## Wildcard '{num}' must be equivalent to 'R1' or '1', meaning the read pair designation.
SAMPLE_LIST,NUMS1,SEQS,NUMS2 = glob_wildcards(INPUT + "/{sample}_S{num1}_{seq}_{num2}" + SUF)
## example file format: ETS_NEO_M1_S23_L002_I1_001.fastq.gz 

# Unique the output variables from glob_wildcards
SAMPLE_SET = set(SAMPLE_LIST)
SET_NUMS1 = set(NUMS1)
SET_SEQS = set(SEQS)
SET_NUMS2 = set(NUMS2)

rule all:
    input:
        expand("stamps/count_stamps/{sample}.stamp", sample=SAMPLE_LIST),
        expand("stamps/vel_count_stamps/{sample}.stamp", sample=SAMPLE_LIST),
        "ref"

rule download_tar:
    output: "refdata-gex-GRCh38-2020-A.tar.gz"
    # download mouse transcriptome
    shell: "curl -O https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz"

rule transcriptome:
    input: "refdata-gex-GRCh38-2020-A.tar.gz"
    output: directory("ref")
    log: "output/logs/transcriptome.log"
    shell:
        """
        mkdir -p {output}
        tar -xvf {input} -C {output}
        # clean up
        rm refdata-gex-GRCh38-2020-A.tar.gz
        """

rule run_cellranger:
    input: "ref"
    output: 
        STAMP = "stamps/count_stamps/{sample}.stamp",
        VELO = directory("output/{sample}")
    params: directory("ref/refdata-gex-GRCh38-2020-A")
    log: "output/logs/run_cellranger-{sample}"
    shell:
        """
        export PATH=$HOME/10x-snake/apps/cellranger-5.0.1:$PATH
        cellranger count --id={wildcards.sample} \
                         --fastqs={config[indir]} \
                         --transcriptome={params} \
                          --sample {wildcards.sample} \
                         --expect-cells={CELL_NUMBER} \
                         --disable-ui
        touch {output.STAMP}
        mkdir -p {output.VELO}
        rsync -a {wildcards.sample}/ output/{wildcards.sample}/
        rm -rf {wildcards.sample}
        """
        
rule velocyto:
    input: "output/{sample}"
    output: "stamps/vel_count_stamps/{sample}.stamp"
    params: "ref/refdata-gex-GRCh38-2020-A/genes/genes.gtf"
    conda: "env/velocyto.yaml" 
    log: "output/logs/velocyto-{sample}"
    shell:
        """
        velocyto run10x {input} {params}
        touch {output}
        """