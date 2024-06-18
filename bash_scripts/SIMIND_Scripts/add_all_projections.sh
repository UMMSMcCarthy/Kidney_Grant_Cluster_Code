#!/bin/bash
#
src_dir="/home/william.mccarthy-umw/Framework/src"
for pt in  239 247 252 254 255 261 267 269 272 279 283 290 292 300 301 310 318 320 321 323 324 328 329 333 336 342 344 346 353 357 359 369 370 373 377 379 387 388 401 415 426 428 440 441 447 462 469 476 481 493 498 519 524 532 536
do

		bsub -n 1 -q short -W 1:00 -R "rusage[mem=1028]" "(python3 $src_dir/Reconstruction_Python/Justin_modified.py -pt $pt)"

done











