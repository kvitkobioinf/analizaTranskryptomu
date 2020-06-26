#!/bin/bash

# utworzenie katalogu
mkdir FASTQ
# konwersja plików SRA na odpowiednie pliki fastq (metoda szybsza niż pobranie plików formatu fastq bezpośrednio przez fastq-dump
for file in SRA/*.sra
do
	nohup fastq-dump ${file} --split-files -O FASTQ >/dev/null 2>&1 & 
done

print('Sprawdzanie czy proces zakończył się poleceniem:')
print('ps -ef | grep "119494.*-dump" | grep -v "grep" | wc -l')
