#!/bin/bash
# use the output .ranked.txt files from process_mtx_files.sh+process_mtx_files.pl

# e.g., D1_MSN_Putamen_A47L_Control.ranked.txt = cellType_patientId_Condition.ranked.txt
all_cond=('D1_MSN_Putamen' 'D2_MSN_Putamen') # example

for cond in "${all_cond[@]}"
do
file_out="summary_${cond}_200.txt"
printf "condition\tgrade\tnumCells\tmedian\n" >  $file_out
done

for cond in "${all_cond[@]}"
do
	for file in `ls ${cond}_*ranked.txt|sort`
	do
	grade=`echo $file|sed 's/.ranked.txt//' | sed 's/.*_//'` # control/disease-grade
	file_out="summary_${cond}_200.txt"
	perl calcTopStats.pl $file $file_out $numCells 200 $grade $cond    # 200=number of top genes to use
	done
done

