#!/bin/bash

patient_array=(../../pt*)

len1=${#patient_array[@]}


for ((i=0;i<$len1;i++))
do 
echo "$i"/"$len1"

rm "${patient_array[$i]}"/SIMIND/lkd256* 
rm "${patient_array[$i]}"/SIMIND/rkd256* 
rm "${patient_array[$i]}"/SIMIND/ls1256* 
rm "${patient_array[$i]}"/SIMIND/ls2256* 
rm "${patient_array[$i]}"/SIMIND/ls3256* 
rm "${patient_array[$i]}"/SIMIND/lvr256* 
rm "${patient_array[$i]}"/SIMIND/bgd256*
rm "${patient_array[$i]}"/SIMIND/spl256*
rm "${patient_array[$i]}"/SIMIND/run12*
rm "${patient_array[$i]}"/Cases/DMSA2*
rm "${patient_array[$i]}"/Cases/DMSA1*
rm "${patient_array[$i]}"/Reconstructions/DMSA*
done