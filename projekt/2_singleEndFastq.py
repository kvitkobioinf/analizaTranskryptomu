#!/usr/bin/env python3
import os
import glob
import sys

# wybranie przekonwertowanych plików SRA->FASTQ przez fastq-dump
fastq_files = glob.glob('./FASTQ/*_*.fastq')

for fastq_file in fastq_files:
	run = (fastq_file.split('/')[2]).split('_')[0]
	single_end = True
	for fastq_file_check in fastq_files:
		if run + '_2.fastq' in fastq_file_check:
			single_end = False
			break

	if single_end:
		os.system(f'mv {fastq_file} {(fastq_file.replace("_1", ""))}')
