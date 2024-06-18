#BSUB -n 1
#BSUB -W 4:00
#BSUB -R rusage[mem=100]
#BSUB -q short

export PATH=$PATH:/home/william.mccarthy-umw/simind
export SMC_DIR=/home/william.mccarthy-umw/simind/smc_dir/

