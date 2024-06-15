#!/bin/bash
#
# 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040
# 
for pt in  239n 247n 252n 254n 255n 261n 267n 269n 272n 279n 283n 290n 292n 300n 301n 310n 318n 320n 321n 323n 324n 328n 329n 333n 336n 342n 344n 346n 353n 357n 359n 369n 370n 373n 377n 379n 387n 388n 401n 415n 426n 428n 440n 441n 447n 462n 469n 476n 481n 493n 498n 519n 524n 532n 536n
do
	i=1
	echo "Recon Parameters for $pt" > ../pt"$pt"/Reconstructions/Reconstruction_Settings.txt
for cn in 10
do
	for a in 1
	do
	bsub -n 1 -q short -W 2:00 -oo ../recon_reports/pt"$pt"_"$a" -R "rusage[mem=2056]" "(python3 PreProcessing.py -pt $pt -c $a -rn $i) > ../recon_reports/report_${pt}_${a}.txt 2>&1"
	echo "Recon $i - Case: $a, Noise: F, Contrast: $cn (Divide by ten)" >> ../pt"$pt"/Reconstructions/Reconstruction_Settings.txt
	i=$(($i+1))
	done

	for a in 2 3 4 5 6 7 8 9
	do
	bsub -n 1 -q short -W 2:00 -oo ../recon_reports/pt"$pt"_"$a" -R "rusage[mem=2056]" "(python3 PreProcessing.py -pt $pt -c $a -an True -rn $i) > ../recon_reports/report_${pt}_${a}.txt 2>&1"
    echo "Recon $i - Case: $a, Noise: T, Contrast: $cn (Divide by ten)" >> ../pt"$pt"/Reconstructions/Reconstruction_Settings.txt
	i=$(($i+1))
	done
done
done










