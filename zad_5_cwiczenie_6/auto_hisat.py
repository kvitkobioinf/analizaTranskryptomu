#!/usr/bin/env python3
import os

prefix = 'HBR'
for i in range(1, 4):
    os.system(f'nohup /bioapp/bin/hisat2 -q -x ERCC92_index/ERCC92_index -1 reads/{prefix}_{i}_R1.fq -2 reads/{prefix}_{i}_R2.fq -S SAM/{prefix}_{i}.sam &')

prefix = 'UHR'
for i in range(1, 4):
    os.system(f'nohup /bioapp/bin/hisat2 -q -x ERCC92_index/ERCC92_index -1 reads/{prefix}_{i}_R1.fq -2 reads/{prefix}_{i}_R2.fq -S SAM/{prefix}_{i}.sam &')
