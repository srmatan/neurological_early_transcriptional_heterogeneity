#!/bin/bash

# takes patient/condition cell-type specific .mtx format files without headers (i.e. HD_patient_1023 + D1_MSN)  
# sorts them according to number of counts (3rd field) and calculates the ranking of the genes 
# according to their detection level (number of single cells they are detected in) using process_mtx_files1.pl

for file in `ls *.mtx`
do
file2=`echo $file | sed 's/.mtx//'`
cat $file |sort -k3,3nr > ${file2}.sorted.txt
perl process_mtx_files1.pl ${file2}.sorted.txt rank_res/${file2}.ranked.txt rank_res/${file2}_numCells.txt

done
