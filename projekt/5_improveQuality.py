#!/usr/bin/env python3

import os
import sys
import glob

# utworzenie katalogu dla plików po oczyszczeniu
os.system('mkdir ./FASTQ_trimmed 2>/dev/null')

fastq_files = glob.glob('./FASTQ/*.fastq')

# plik adaptera TruSeq wybrany zgodnie z sugestią samego programu FastQC dla plików projektu PRJNA313294
# sekwencja pobrana z internetu  http://tucf-genomics.tufts.edu/documents/protocols/TUCF_Understanding_Illumina_TruSeq_Adapters.pdf

for fastq_file in fastq_files:
    run = (fastq_file.split('/')[2]).split('.')[0]	

    if run[-2:] == "_1":
        # uruchomienie Trimmomatic dla paired-end
        fastq_file_2_of_pair = fastq_file.replace('_1.fastq', '_2.fastq')
        os.system(f'nohup java -jar /bioapp/Trimmomatic-0.39/trimmomatic-0.39.jar PE {fastq_file} {fastq_file_2_of_pair} ./FASTQ_trimmed/{run}_trimmed.fastq ./FASTQ_trimmed/{run}_unpaired.fastq ./FASTQ_trimmed/{run.replace("_1", "_2")}_trimmed.fastq ./FASTQ_trimmed/{run.replace("_1", "_2")}_unpaired.fastq TRAILING:36 -threads 6 ILLUMINACLIP:TrueSeqIndexedAdapter.fa:2:30:5 >/dev/null 2>&1 &')
    elif run[-2:] == "_2":
        # pominięcie - program trimmomatic uruchomiony dla pierwszego pliku z pary
        pass
    else:
        # uruchomienie dla single-end
        os.system(f'nohup java -jar /bioapp/Trimmomatic-0.39/trimmomatic-0.39.jar SE {fastq_file}  ./FASTQ_trimmed/{run}_trimmed.fastq TRAILING:30 -threads 6 ILLUMINACLIP:TrueSeqIndexedAdapter.fa:2:30:5 >/dev/null 2>&1 &')

print('Sprawdzanie zakończenia pracy')
print('ps -ef | grep "119494.*Trimmomatic" | grep -v "grep" | wc -l')

print('\nOpcjonalne usunięcie niesparowanych sekwencji komendą:')
print('rm ./FASTQ_trimmed/*unpaired*')
