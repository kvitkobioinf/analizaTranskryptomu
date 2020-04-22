#!/bin/bash
while getopts i:o:e:h option; do
  case $option in
    i) wejscie=$OPTARG;;
    o) wyjscie=$OPTARG;;
    e) ext=$OPTARG;;
    h) echo "-i folder wejscia, -o folder wyjscia, -e rozszerzenie pliku"
        exit;;
  esac
done


iloscPlikow="$(ls $wejscie/*.$ext -l | wc -l)"
echo "Znaleziono plikow: $iloscPlikow"

pliki=$wejscie/*.$ext
for p in $pliki
do
  fastqc -o "${wyjscie}" "${wejcie}${p}"
done

echo
echo "Zakonczono analize jakosci"