#!/bin/bash

mkdir qualityChecks

for fastq_file in ./FASTQ/*.fastq
do
	nohup fastqc ${fastq_file} -o qualityChecks >/dev/null 2>&1 &
done

echo 'Sprawdzanie czy procesy zakończone'
echo 'ps -ef | grep "119494.*FastQC" | grep -v "grep" | wc -l'
