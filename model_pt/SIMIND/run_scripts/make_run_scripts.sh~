#!/bin/bash
########################################
#Name: Justin Pijanowski
#Date: 8/4/21
#Purpose: Run SIMIND for each patient
#######################################

#cd '/project/umw_michael_king/Justin/new_simind_data'
array_1=(/project/umw_michael_king/will/simind_data/simulation/cluster_arms_data/pt*)
array_2=(simind_bgd256.smc simind_spl256.smc simind_lvr256.smc simind_lkd256.smc simind_rkd256.smc simind_stm256.smc)
array_4=(bgd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR: 
	spl256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	lvr256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	lkd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	rkd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	stm256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:)

orbital_array=(1.75 1.9 1.75 1.85 1.75 1.4 2 1.9 2.2 1.9 2 2.2 2.2 1.65	1.9 1.75 2 2.2 2.4 2.4 2 1.9 1.9 2.2 1.9 2.2 2.2 2.2 1.9 1.6667 1.75 2.4 1.75 2	2.2 2 1.85 1.9 2.2 2.2 1.9 1.9 1.85 2 2.2 2 2 1.7 1.75 1.9 1.9 1.6667 1.85 1.6667 1.75 1.75)

height_array=(17 14 15 15 15 19	13 14 12 14 13 12 12 20 14 16 13 12 11 11 13 14 14 12 14 12 12 12 14 16 15 11 15 13 12 13 15 14	12 12 14 14 15 13 12 13	13 20 15 14 14 16 16 16	15 15)


len1=${#array_1[@]}
len2=${#array_2[@]}

#echo ${#orbital_array[@]}
#echo ${#height_array[@]}



for ((i=0;i<$len1;i++))
do
	cd ${array_1[$i]}
	
	
	for ((j=0;j<$len2;j++))
	do
		
		index=$j
		if [[ $j -eq 0 || $j -eq 3 || $j -eq 4 || $j -eq 5 ]]
		then
			for ((k=1;k<11;k++)) #11
			do
				cat /home/wm11w/simind/Bsub_Justin2.sh >> Bsub_execute_run12_"$index"_$k.sh
				string1=${array_4[$j]:0:12}
				string2=${array_4[$j]:12}
				#echo $string1
				#echo $string2
				string1+="_$k"
				string2+=$k
				string1+=$string2
				string1+="/12:"
				string1+=${height_array[$i]}
				string1+="/42:"
				string1+=${orbital_array[$i]}
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
				cat /home/wm11w/simind/Bsub_Justin3.sh >> Bsub_execute_run12_"$index"_$l.sh
				string1=${array_4[$j]:0:12}
				string2=${array_4[$j]:12}
				#echo $string1
				#echo $string2
				string1+="_$l"
				string2+=$l
				string1+=$string2
				string1+="/12:"
				string1+=${height_array[$i]}
				string1+="/42:"
				string1+=${orbital_array[$i]}
				#echo $string1
				temp2="(simind ${array_2[$index]} $string1) > run12_"$index"_$l.txt 2>&1"
				#echo $temp2
				echo $temp2 >> Bsub_execute_run12_"$index"_$l.sh
				#bsub < Bsub_execute_run12_"$index"_$l.sh
				#rm Bsub_execute_run12_"$index"_$l.sh
			done	
			
		fi
				
	done
done
