#!/bin/bash

directory="FASTQ"
if [ $# -gt 0 ]; then
	directory=$1
fi

mkdir qualityChecks 2>/dev/null

for fastq_file in ./${directory}/*.fastq
do
	nohup fastqc ${fastq_file} -o qualityChecks >/dev/null 2>&1 &
done

echo 'Sprawdzanie czy procesy zakończone'
echo 'ps -ef | grep "119494.*FastQC" | grep -v "grep" | wc -l'
