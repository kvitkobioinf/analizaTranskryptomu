#!/bin/bash
# wybór intepretera (skrypt bash)

# pobranie listy numerów SRA Run dla projektu PRJNA313294 i zapisanie jej do pliku tekstowego
esearch -db sra -query PRJNA313294 | efetch -format runinfo -mode xml | xtract -pattern SraRunInfo -element Run > SRR_Acc_List.txt

# umieszczenie numerów SRA Run w pojedynczych liniach pliku tekstowego (nadpisanie pliku)
sed -i 's/\t/\n/g' SRR_Acc_List.txt

# usuwanie folderu ncbi w katalogu domowym (domyślna lokalizacja pobierania plików SRA przez program prefetch) jeśli wcześniej istniał (jeśli nie istniał - ignorowanie informacji o błędzie)
rm -r ~/ncbi 2> /dev/null
