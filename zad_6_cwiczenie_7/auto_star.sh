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
           
      seqLength=$(grep -v ">" ${wejcie}${p} | wc | awk '{print $3-$1}')                      
      echo "Dlugosc to: $seqLength"                                                      
      log=$(log2 $seqLength)                                                               
      base=$(expr $log / 2)                                                                  
      base=$(expr $base - 1)
      const=14                                                                                     
      if [ "$base" -gt "$const" ]; then                                                       
        base=14                                                                            
      fi

      /bioapp/STAR-2.7.3a/source/STAR --runThreadN 2 --genomeDir $wyjscie --readFilesIn $STAR_wejsciowe
      mv Aligned.out.sam $wyjscie/${plik%.*}.sam
      /bioapp/samtools-1.9/samtools view -Sb -@ 2 $wyjscie/${plik%.*}.sam > $wyjscie/${plik%.*}.bam
      /bioapp/samtools-1.9/samtools sort $wyjscie/${plik%.*}.bam -o $wyjscie/${plik%.*}_sorted.bam
      /bioapp/samtools-1.9/samtools index $wyjscie/${plik%.*}_sorted.bam

      STAR_wejsciowe=""
    fi
done