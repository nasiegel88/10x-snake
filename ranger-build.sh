#!/bin/bash

mkdir apps
cd apps

# download app
curl -o cellranger-5.0.1.tar.gz \
"https://cf.10xgenomics.com/releases/cell-exp/cellranger-5.0.1.tar.gz?Expires=1611242268&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci01LjAuMS50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2MTEyNDIyNjh9fX1dfQ__&Signature=PwVj8d2uH81ZE-PZgnQFpX2LxKu4t-K1bRWVCNadsJc4vh3udE3l0c0TSDH5viTpz2zeNsYBV40eMIa6YErmGk1NGfYETmG4MXtfIklHrt7-0~8N2KPA1jYYLdpelC6uN-wtEDQRwTWY4CrEkxrAOtUc6egbNqB6jGrrCzD2USLGCQ7I5LaFMOHTm2d8QAw6sRRF6PoR87DPO~iVv2ZEJpD5igW4hegp2dJ8DX1HhqNEmj6K1NbrtObcWYtxxxrARZ1xAx0iCvEWjDMrb~tSepP0HjifbOC-1HYPRhcDduV9tXdi7ddnwiXgCSfijDIcYTH-ummHIG~V6ZeJkfeZ~A__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"
# unpack
tar -zxvf cellranger-5.0.1.tar.gz

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