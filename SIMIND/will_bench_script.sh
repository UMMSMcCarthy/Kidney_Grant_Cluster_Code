#BSUB -L /bin/bash
#BSUB -R select[rh=8]
#BSUB -n 1
#BSUB -W 20:00
#BSUB -R rusage[mem=1024]
#BSUB -oo test.out
#BSUB -eo test.err
#BSUB -q long

export PATH=$PATH:/home/wm11w/simind
export SMC_DIR=/home/wm11w/simind/smc_dir/

(time ./simind bench.smc) > test.txt 2>&1
