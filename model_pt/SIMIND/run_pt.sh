#!/bin/bash
# Areas of Activity (variable i): 0-bgd, 1-spl, 2-liv, 3-lkid, 4-rkid, 5-ls1, 6-ls2, 7-ls3
# 0 1 2 3 4 5 6 7
for i in 0 1 2 3 4 5 6 7
do
for j in 1 2 3 4 5 6 7 8 9 10
do
bsub < run_scripts/Bsub_execute_run12_"$i"_"$j".sh
done
done





