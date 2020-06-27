#!/usr/bin/env python3

import os
import sys
import glob

aligned_sams = glob.glob('./STAR_mapped/*/Aligned.out.sam')

for aligned_sam in aligned_sams:
    path_parts = aligned_sam.split('/')
    file = path_parts[3]
    directory = aligned_sam.replace(file, '')
    sra_run = path_parts[2]

    print()
    print(f'Plik: {file}, folder: {directory}')

    # organizacja plików w katalogu
    os.system(f'mkdir {directory}helper_files/ 2>/dev/null')
    os.system(f'mv {directory}Log* {directory}helper_files/')
    os.system(f'mv {directory}SJ.out.tab {directory}helper_files/')
    os.system(f'mv {aligned_sam} {directory}{sra_run}.sam')

    os.system(f'/bioapp/samtools-1.9/samtools view -Sb -@ 2 {directory}{sra_run}.sam > {directory}{sra_run}.bam')
    os.system(f'/bioapp/samtools-1.9/samtools sort {directory}{sra_run}.bam -o {directory}{sra_run}_sorted.bam')
    os.system(f'/bioapp/samtools-1.9/samtools index {directory}{sra_run}_sorted.bam')

print('\n\n\n--------------')
print('ZAKOŃCZONO')
