#!/bin/bash

mkdir COUNTS 2>/dev/null

/bioapp/subread-2.0.0-source/bin/featureCounts -a ./hg19.gtf -g gene_id -o ./COUNTS/counts_ALL.txt ./STAR_mapped/*/*_sorted.bam

/bioapp/subread-2.0.0-source/bin/featureCounts -a ./hg19.gtf -g gene_id -o ./COUNTS/counts_SE.txt ./STAR_mapped/SRR31944*/*_sorted.bam

/bioapp/subread-2.0.0-source/bin/featureCounts -a ./hg19.gtf -g gene_id -p -o ./COUNTS/counts_PE.txt ./STAR_mapped/SRR319154*/*_sorted.bam
