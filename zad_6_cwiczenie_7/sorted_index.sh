#!/bin/bash
for f in *.bam
do
    /bioapp/samtools-1.9/samtools sort "$f" -o "${f%.bam}_sorted.bam"
    /bioapp/samtools-1.9/samtools index "${f%.bam}_sorted.bam"
done