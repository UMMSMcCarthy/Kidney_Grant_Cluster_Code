#!/bin/bash
########################################
#Name: Justin Pijanowski
#Date: 8/4/21
#Purpose: Run SIMIND for each patient
#######################################
src_dir="/home/william.mccarthy-umw/Framework/src"

rm -f "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub*
#cd '/project/umw_michael_king/Justin/new_simind_data'
array_2=(simind_bg256.smc simind_spl256.smc simind_liv256.smc simind_lkid256.smc simind_rkid256.smc simind_ls1256.smc simind_ls2256.smc simind_ls3256.smc)
#array_2=(simind_bg256.smc)
array_4=(bgd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR: 
	spl256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	lvr256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	lkd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	rkd256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	ls1256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	ls2256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:
	ls3256_run12/PX:0.23976/FW:windows/nn:3/41:0/RR:)

height_hold=$(awk 'NR==6' "$src_dir"/../pt"$1"/SIMIND/Pt_data.txt)
height=${height_hold:11:2}
Orbit=$(awk 'NR==5' "$src_dir"/../pt"$1"/SIMIND/Pt_data.txt)
orbital=${Orbit:19:4}

len2=${#array_2[@]}

#echo ${#orbital_array[@]}
#echo ${#height_array[@]}



	for ((j=0;j<$len2;j++))
	do
		
		index=$j

		for ((k=1;k<11;k++)) #11
		do

			if [[ $j -eq 0 || $j -eq 2 || $j -eq 3 || $j -eq 4 || $j -eq 5 ]]
			then

				echo "#BSUB -n 1" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
				echo "#BSUB -W 120:00" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
				echo "#BSUB -R rusage[mem=100]" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
				echo "#BSUB -q long" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh

			else

				echo "#BSUB -n 1" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
				echo "#BSUB -W 4:00" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
				echo "#BSUB -R rusage[mem=100]" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
				echo "#BSUB -q short" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
		
			fi

		echo "export PATH=\$PATH:$src_dir/SIMIND" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
		echo "export SMC_DIR=$src_dir/SIMIND/smc_dir/" >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh

		string1=${array_4[$j]:0:12}
		string2=${array_4[$j]:12}
		string1+="_$k"
		string2+=$k
		string1+=$string2
		string1+="/12:"
		string1+=${height}
		string1+="/42:"
		string1+=${orbital}

		temp2="(simind ${array_2[$j]} $string1) > run12_"$index"_$k.txt 2>&1"

		echo $temp2 >> "$src_dir"/../pt"$1"/SIMIND/run_scripts/Bsub_execute_run12_"$index"_$k.sh
	

		done		
	done
