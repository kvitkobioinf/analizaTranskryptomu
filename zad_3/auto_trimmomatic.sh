#!/bin/bash
while getopts i:o:e:a:t:h option; do
  case $option in
    i) wejscie=$OPTARG;;
    o) wyjscie=$OPTARG;;
    e) ext=$OPTARG;;
    a) adapter=$OPTARG;;
    t) trimmomatic=$OPTARG;;
    h) echo "-i folder wejscia, -o folder wyjscia, -e rozszerzenie pliku, -a plik adaptera (bez folderu), -t lokalizacja pliku java trimmonatic (do znalezienia przez which trimmomatic)"
       echo "FOLDERY BEZ! KONCZACEGO znaku /"
       exit;;
  esac
done


iloscPlikow="$(ls $wejscie/*.$ext -l | wc -l)"
echo "Znaleziono plikow: $iloscPlikow"

SRA_wejsciowe=""
SRA_wyjsciowe=""

pliki=$wejscie/*.$ext
for p in $pliki
do
    plik=$(basename -- "${wejcie}${p}")
    SRA_wejsciowe="$SRA_wejsciowe ${wejscie}/${plik%.*}.$ext"
    SRA_wyjsciowe="$SRA_wyjsciowe ${wyjscie}/${plik%.*}_trimmed.fq"
    SRA_wyjsciowe="$SRA_wyjsciowe ${wyjscie}/${plik%.*}_unpaired.fq"
done

echo
java -jar $trimmomatic PE $SRA_wejsciowe $SRA_wyjsciowe SLIDINGWINDOW:4:30 TRAILING:30 ILLUMINACLIP:$wejscie/$adapter:2:30:5