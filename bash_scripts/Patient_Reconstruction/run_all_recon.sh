#!/bin/bash
#
# 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040
# 
src_dir="/home/william.mccarthy-umw/Framework/src"

for pt in  239 247 #252 254 255 261 267 269 272 279 283 290 292 300 301 310 318 320 321 323 324 328 329 333 336 342 344 346 353 357 359 369 370 373 377 379 387 388 401 415 426 428 440 441 447 462 469 476 481 493 498 519 524 532 536
do
	i=1
	echo "Recon Parameters for $pt" > "$src_dir"/../pt"$pt"/Reconstructions/Reconstruction_Settings.txt
for cn in 10
do
	for a in 1
	do
	bsub -n 1 -q short -W 2:00 -oo "$src_dir"/../recon_reports/pt"$pt"_"$a" -R "rusage[mem=2056]" "(python3 $src_dir/Reconstruction_Python/Reconstruct.py -pt $pt -c $a -rn $i) > $src_dir/../recon_reports/report_${pt}_${a}.txt 2>&1"
	echo "Recon $i - Case: $a, Noise: F, Contrast: $cn (Divide by ten)" >> "$src_dir"/../pt"$pt"/Reconstructions/Reconstruction_Settings.txt
	i=$(($i+1))
	done

	for a in 2 #3 4 5 6 7 8 9
	do
	bsub -n 1 -q short -W 2:00 -oo "$src_dir"/../recon_reports/pt"$pt"_"$a" -R "rusage[mem=2056]" "(python3 $src_dir/Reconstruction_Python/Reconstruct.py -pt $pt -c $a -an True -rn $i) > $src_dir/../recon_reports/report_${pt}_${a}.txt 2>&1"
    echo "Recon $i - Case: $a, Noise: T, Contrast: $cn (Divide by ten)" >> "$src_dir"/../pt"$pt"/Reconstructions/Reconstruction_Settings.txt
	i=$(($i+1))
	done
done
done










