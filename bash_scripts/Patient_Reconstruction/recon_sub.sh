#!/bin/bash

src_dir="/home/william.mccarthy-umw/Framework/src"

conda init bash
conda activate test_env

bsub -n 1 -q short -W 2:00 -oo ../recon_reports/pt"$pt"_"$a" -R "rusage[mem=2056]" "(python3 $src_dir/Reconstruction_Python/Reconstruct.py -pt 001 -c 1 -cn 10) > $src_dir/../recon_reports/report_001_1_cn10.txt 2>&1"
	




