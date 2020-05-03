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

function log2 {
    local x=0
    for (( y=$1-1 ; $y > 0; y >>= 1 )) ; do
        let x=$x+1
    done
    echo $x
}

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

      mkdir $wyjscie/${plik%.*}
                   
      seqLength=$(grep -v ">" ${wejcie}${p} | wc | awk '{print $3-$1}')
      log=$(log2 $seqLength)                                                               
      base=$(expr $log / 2)                                                                  
      base=$(expr $base - 1)
      const=14                                                                                     
      if [ "$base" -gt "$const" ]; then                                                       
        base=14                                                                            
      fi                                                                                   
      echo $"SAindexNbases to: $base"

      NumberOfReferences=$(grep "^>" ${wejcie}${p} | wc -l)
      NumberOfReferences=$(expr $seqLength / $NumberOfReferences)
      NumberOfReferences=$(log2 $NumberOfReferences)
      const=18                                                                                     
      if [ "$NumberOfReferences" -gt "$const" ]; then                                                       
        NumberOfReferences=18                                                                           
      fi

      /bioapp/STAR-2.7.3a/source/STAR --runThreadN 2 --genomeSAindexNbases $base --genomeChrBinNbits $NumberOfReferences --runMode genomeGenerate --genomeDir $wyjscie/${plik%.*} --genomeFastaFiles $STAR_wejsciowe

      STAR_wejsciowe=""
    fi
done