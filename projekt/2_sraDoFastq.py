#!/usr/bin/env python3
import os
import glob
import sys

# wybranie przekonwertowanych plików (paired-end) SRA->FASTQ przez fasterq-dump
paired_end_fastq_files = glob.glob('./FASTQ/*_*.fastq')
# wszystkie pliki SRA projeku
sra_files = glob.glob('./SRA/*.sra')

# pozostawienie wśród plików SRA tylko single-end
for paired_end_file in paired_end_fastq_files:
    paired_end_run = (paired_end_file.split('/')[2]).split('.')[0]
    for sra_file in sra_files:
        if paired_end_run in sra_file:
            sra_files.remove(sra_file)

# konwersja single-end SRA->FASTQ programem fastq-dump
for sra_file in sra_files:
     os.system(f'nohup fastq-dump {sra_file} -O ./FASTQ/ &')

print('Sprawdzanie czy proces zakończył się poleceniem:')
print('ps -ef | grep "119494.*-dump" | grep -v "grep" | wc -l')
