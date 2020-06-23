#!/bin/bash
for f in *.bam
do
    /bioapp/samtools-1.9/samtools view "$f" | awk '{if ($6 ~ '/I/') print $1}' > "${f%.bam}.txt"
done