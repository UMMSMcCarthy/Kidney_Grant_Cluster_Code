#!/bin/bash
# 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040

src_dir="/home/william.mccarthy-umw/Framework/src"
for i in 239 #247 252 254 255 261 267 269 272 279 283 290 292 300 301 310 318 320 321 323 324 328 329 333 336 342 344 346 353 357 359 369 370 373 377 379 387 388 401 415 426 428 440 441 447 462 469 476 481 493 498 519 524 532 536 
do

echo "$i"

mkdir "$src_dir"/../pt"$i"
mkdir "$src_dir"/../pt"$i"/Cases
mkdir "$src_dir"/../pt"$i"/Projections
mkdir "$src_dir"/../pt"$i"/Reconstructions
mkdir "$src_dir"/../pt"$i"/SIMIND
mkdir "$src_dir"/../pt"$i"/SIMIND/run_scripts
 

cp -r "$src_dir"/model_pt/SIMIND/windows.win "$src_dir"/../pt"$i"/SIMIND/
cp -r "$src_dir"/model_pt/SIMIND/*.smc "$src_dir"/../pt"$i"/SIMIND/ 
cp -r "$src_dir"/model_pt/Cluster_Recon_Input.txt "$src_dir"/../pt"$i"/ 
cp -r "$src_dir"/model_pt/SIMIND/run_pt.sh "$src_dir"/../pt"$i"/SIMIND/ 


../SIMIND_Scripts/make_run_scripts.sh "$i"


done
