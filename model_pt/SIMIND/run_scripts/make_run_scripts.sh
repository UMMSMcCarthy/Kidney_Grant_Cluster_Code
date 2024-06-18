#!/bin/bash
########################################
#Name: Justin Pijanowski
#Date: 8/4/21
#Purpose: Run SIMIND for each patient
#######################################
rm -f Bsub*
#cd '/project/umw_michael_king/Justin/new_simind_data'
array_2=(simind_bg256.smc simind_spl256.smc simind_liv256.smc simind_lkid256.smc simind_rkid256.smc simind_ls1256.smc simind_ls2256.smc simind_ls3256.smc)
array_4=(bgd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR: 
	spl256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	lvr256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	lkd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	rkd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	ls1256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	ls2256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	ls3256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:)

height_hold=$(awk 'NR==6' ../Pt_data.txt)
height=${height_hold:11:2}
Orbit=$(awk 'NR==5' ../Pt_data.txt)
orbital=${Orbit:19:4}







len2=${#array_2[@]}

#echo ${#orbital_array[@]}
#echo ${#height_array[@]}



	for ((j=0;j<$len2;j++))
	do
		
		index=$j
		if [[ $j -eq 0 || $j -eq 2 || $j -eq 3 || $j -eq 4 || $j -eq 5 ]]
		then
			for ((k=1;k<11;k++)) #11
			do
				cat ../../../src/bsub_files/Bsub_Justin2.sh >> Bsub_execute_run12_"$index"_$k.sh
				string1=${array_4[$j]:0:12}
				string2=${array_4[$j]:12}
				#echo $string1
				#echo $string2
				string1+="_$k"
				string2+=$k
				string1+=$string2
				string1+="/12:"
				string1+=${height}
				string1+="/42:"
				string1+=${orbital}
				#echo $string1
				temp2="(simind ${array_2[$j]} $string1) > run12_"$index"_$k.txt 2>&1"
				#echo $temp2
				echo $temp2 >> Bsub_execute_run12_"$index"_$k.sh
				#bsub < Bsub_execute_run12_"$index"_$k.sh	
				#rm Bsub_execute_run12_"$index"_$k.sh	 
			done
			
		else
			for ((l=1;l<11;l++)) #11
			do
				cat ../../../src/bsub_files/Bsub_Justin3.sh >> Bsub_execute_run12_"$index"_$l.sh
				string1=${array_4[$j]:0:12}
				string2=${array_4[$j]:12}
				#echo $string1
				#echo $string2
				string1+="_$l"
				string2+=$l
				string1+=$string2
				string1+="/12:"
				string1+=${height}
				string1+="/42:"
				string1+=${orbital}
				#echo $string1
				temp2="(simind ${array_2[$index]} $string1) > run12_"$index"_$l.txt 2>&1"
				#echo $temp2
				echo $temp2 >> Bsub_execute_run12_"$index"_$l.sh
				#bsub < Bsub_execute_run12_"$index"_$l.sh
				#rm Bsub_execute_run12_"$index"_$l.sh
			done	
			
		fi
				
	done
