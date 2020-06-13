#!/usr/bin/env python3
import os

prefix = 'HBR'
for i in range(1, 4):
    os.system(f'mkdir STARred/{prefix}_{i}')
    os.system(f'nohup /bioapp/STAR-2.7.3a/source/STAR --runThreadN 2 --runMode genomeGenerate --genomeChrBinNbits 15 --genomeDir STARred/{prefix}_{i} --genomeFastaFiles  reads_fa/{prefix}_{i}_R1.fa reads_fa/{prefix}_{i}_R2.fa &')

prefix = 'UHR'
for i in range(1, 4):
    os.system(f'mkdir STARred/{prefix}_{i}')
    os.system(f'nohup /bioapp/STAR-2.7.3a/source/STAR --runThreadN 2 --runMode genomeGenerate --genomeChrBinNbits 15 --genomeDir STARred/{prefix}_{i} --genomeFastaFiles  reads_fa/{prefix}_{i}_R1.fa reads_fa/{prefix}_{i}_R2.fa &')
