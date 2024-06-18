#BSUB -n 1
#BSUB -W 120:00
#BSUB -R rusage[mem=100]
#BSUB -q long

export PATH=$PATH:/home/william.mccarthy-umw/simind
export SMC_DIR=/home/william.mccarthy-umw/simind/smc_dir/

