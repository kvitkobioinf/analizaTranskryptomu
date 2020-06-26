#!/bin/bash
# wybór intepretera (skrypt bash)

# pobranie listy numerów SRA Run dla projektu PRJNA313294 i zapisanie jej do pliku tekstowego
esearch -db sra -query PRJNA313294 | efetch -format runinfo -mode xml | xtract -pattern SraRunInfo -element Run > SRR_Acc_List.txt

# umieszczenie numerów SRA Run w pojedynczych liniach pliku tekstowego (nadpisanie pliku)
sed -i 's/\t/\n/g' SRR_Acc_List.txt

# usuwanie folderu ncbi w katalogu domowym (domyślna lokalizacja pobierania plików SRA przez program prefetch) jeśli wcześniej istniał (jeśli nie istniał - ignorowanie informacji o błędzie)
rm -r ~/ncbi 2> /dev/null

# pobranie plików SRA z listy w pliku tekstowym
prefetch $(<SRR_Acc_List.txt)

# utworzenie folderu dla pobranych plików
mkdir SRA
# przeniesienie ich do folderu docelowego
mv ~/ncbi/public/sra/*.sra SRA/
# usunięcie plików z domyślnego katalogu pobrania (j.w.)
rm -r ~/ncbi 2> /dev/null

# utworzenie katalogu
mkdir FASTQ
# konwersja plików SRA na odpowiednie pliki fastq (metoda szybsza niż pobranie plików formatu fastq bezpośrednio przez fastq-dump
for file in SRA/*.sra
do
	nohup fastq-dump ${file} --split-files -O FASTQ >/dev/null 2>&1 &
done

echo 'Sprawdzanie czy proces zakończył się poleceniem:'
echo 'ps -ef | grep "119494.*-dump" | grep -v "grep" | wc -l'
