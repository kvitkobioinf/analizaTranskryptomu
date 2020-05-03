#!/bin/bash
while getopts i:o:e:a:t:h option; do
  case $option in
    i) wejscie=$OPTARG;;
    e) ext=$OPTARG;;
    h) echo "-i folder wejscia, -o folder wyjscia, -e rozszerzenie pliku"
       echo "FOLDERY BEZ! KONCZACEGO znaku /"
       exit;;
  esac
done


iloscPlikow="$(ls $wejscie/*.$ext -l | wc -l)"
echo "Znaleziono plikow: $iloscPlikow"

hisat_wejsciowe_1=""

pliki=$wejscie/*.$ext
i=0
for p in $pliki
do
    plik=$(basename -- "${wejcie}${p}")

    ((i=i+1))
    if ! (($i % 2)); then
      echo

      hisat_wejsciowe_2="${wejscie}/${plik%.*}.$ext"
      echo "Pracuje na $hisat_wejsciowe_1 oraz $hisat_wejsciowe_2"

      /bioapp/bin/hisat2 -q -x ERCC92_index -1 $hisat_wejsciowe_1 -2 $hisat_wejsciowe_2 -S SAM/${plik%.*}.sam

      /bioapp/samtools-1.9/samtools view -Sb -@ 2 SAM/${plik%.*}.sam > BAM/${plik%.*}.bam
    else
        hisat_wejsciowe_1="${wejscie}/${plik%.*}.$ext"
    fi
done