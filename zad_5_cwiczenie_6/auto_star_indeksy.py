#!/usr/bin/env python3
import os

prefix = 'HBR'
for i in range(1, 4):
    os.system(f'/bioapp/STAR-2.7.3a/source/STAR --runThreadN 4 --genomeDir indeks_STAR/ --readFilesIn /Dydaktyka/sample_data/reads/{prefix}_{i}_R1.fq /Dydaktyka/sample_data/reads/{prefix}_{i}_R2.fq')
    os.system(f'mv Aligned.out.sam {prefix}_{i}.sam')

prefix = 'UHR'
for i in range(1, 4):
    os.system(f'/bioapp/STAR-2.7.3a/source/STAR --runThreadN 4 --genomeDir indeks_STAR/ --readFilesIn /Dydaktyka/sample_data/reads/{prefix}_{i}_R1.fq /Dydaktyka/sample_data/reads/{prefix}_{i}_R2.fq')
    os.system(f'mv Aligned.out.sam {prefix}_{i}.sam')
