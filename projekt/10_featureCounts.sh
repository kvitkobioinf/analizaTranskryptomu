#!/bin/bash

/bioapp/subread-2.0.0-source/bin/featureCounts -a ./hg19.gtf -g gene_name -o ./counts.txt ./STAR_mapped/*/*_sorted.bam
