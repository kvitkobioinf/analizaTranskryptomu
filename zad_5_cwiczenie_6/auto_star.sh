#!/bin/bash
while getopts i:o:e:a:t:h option; do
  case $option in
    i) wejscie=$OPTARG;;
    o) wyjscie=$OPTARG;;
    e) ext=$OPTARG;;
    h) echo "-i folder wejscia, -o folder wyjscia, -e rozszerzenie pliku"
       echo "FOLDERY BEZ! KONCZACEGO znaku /"
       exit;;
  esac
done


iloscPlikow="$(ls $wejscie/*.$ext -l | wc -l)"
echo "Znaleziono plikow: $iloscPlikow"

STAR_wejsciowe=""

pliki=$wejscie/*.$ext
i=0
for p in $pliki
do
    plik=$(basename -- "${wejcie}${p}")
    STAR_wejsciowe="$STAR_wejsciowe ${wejscie}/${plik%.*}.$ext"
    ((i=i+1))
    if ! (($i % 2)); then
      echo
      echo "Pracuje na $STAR_wejsciowe"

      # STAR --runThreadN 2 --runMode genomeGenerate --genomeDir $wyjscie --genomeFastaFiles $STAR_wejsciowe
      # /bioapp/STAR-2.7.3a/source/STAR --runThreadN 2 --runMode genomeGenerate --genomeDir $wyjscie --genomeFastaFiles $STAR_wejsciowe
      echo "STAR --runThreadN 2 --runMode genomeGenerate --genomeChrBinNbits 15 --genomeDir $wyjscie --genomeFastaFiles $STAR_wejsciowe"

      STAR_wejsciowe=""
    fi
done