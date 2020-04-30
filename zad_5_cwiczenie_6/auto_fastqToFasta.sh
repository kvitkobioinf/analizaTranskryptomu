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

pliki=$wejscie/*.$ext
i=0
for p in $pliki
do
    echo "Pracuje na ${wejcie}${p}"
    plik=$(basename -- "${wejcie}${p}")
    sed -n '1~4s/^@/>/p;2~4p' ${wejcie}${p} > ${wyjscie}/${plik%.*}.fa
done