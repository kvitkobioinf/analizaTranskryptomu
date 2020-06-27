#!/usr/bin/env python3

import os
import glob
import sys

# wybranie przekonwertowanych plików SRA->FASTQ przez fastq-dump
fastq_files = glob.glob('./FASTQ_trimmed/*_*.fastq')

os.system(f'mkdir STAR_mapped 2>/dev/null')

for fastq_file in fastq_files:
    run = (fastq_file.split('/')[2]).split('.')[0]
    run = run.replace('_trimmed', '')

    if run[-2:] == "_1":
        print(f'mkdir STAR_mapped/{run.replace("_1", "")} 2>/dev/null')
        print(f'cd STAR_mapped/{run.replace("_1", "")}')
        print(f'nohup /bioapp/STAR-2.7.3a/source/STAR --runThreadN 6 --genomeDir ../../STAR_index --readFilesIn ../../{fastq_file} ../../{fastq_file.replace("_1_trimmed.fastq", "_2_trimmed.fastq")} >/dev/null 2>&1 &')
        print(f'cd ../../')
    elif "_2" not in run:
        print(f'mkdir STAR_mapped/{run.replace("_1", "")} 2>/dev/null')
        print(f'cd STAR_mapped/{run.replace("_1", "")}')
        print(f'nohup /bioapp/STAR-2.7.3a/source/STAR --runThreadN 6 --genomeDir ../../STAR_index --readFilesIn ../../{fastq_file} >/dev/null 2>&1 &')
        print(f'cd ../../')

print('Informacje o postępie')
print('ps -ef | grep 119494 | grep STAR-2.7 | wc -l')
