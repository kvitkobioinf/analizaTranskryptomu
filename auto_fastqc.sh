#!/bin/bash
pliki=*.fastq
for p in $pliki
do
  fastqc -o analiza_jakosci/ $p
done

echo
echo "Analiza jakosci zakonczona"