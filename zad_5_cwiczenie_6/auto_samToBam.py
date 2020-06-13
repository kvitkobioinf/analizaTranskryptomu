#!/usr/bin/env python3
import os

prefix = 'HBR'
for i in range(1, 4):
    os.system(f'nohup /bioapp/bin/samtools view -Sb -@ 2 SAM/{prefix}_{i}.sam > BAM/{prefix}_{i}.bam &')

prefix = 'UHR'
for i in range(1, 4):
    os.system(f'nohup /bioapp/bin/samtools view -Sb -@ 2 SAM/{prefix}_{i}.sam > BAM/{prefix}_{i}.bam &')
