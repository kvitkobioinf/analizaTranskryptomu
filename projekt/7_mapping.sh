#!/bin/bash

mkdir STAR_index

# utworzenie indeksu genomu
nohup /bioapp/STAR-2.7.3a/source/STAR --runThreadN 6 --runMode genomeGenerate --genomeDir STAR_index --genomeFastaFiles hg19.fa --sjdbGTFfile hg19.gtf --sjdbOverhang 75 >/dev/null 2>&1 &   
