while IFS='' read -r line || [[ -n "$line" ]]; do
AR=${line};
echo ${AR};
echo "*** Pobieranie: ${AR}";
fastq-dump -X 10 ${AR} --split-files
done < $1