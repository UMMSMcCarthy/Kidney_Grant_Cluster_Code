#!/bin/bash

src_dir="/home/william.mccarthy-umw/Framework/src"

patient_array=($src_dir/../pt5*)

len1=${#patient_array[@]}


for pt in  239 247 252 254 255 261 267 269 272 279 283 290 292 300 301 310 318 320 321 323 324 328 329 333 336 342 344 346 353 357 359 369 370 373 377 379 387 388 401 415 426 428 440 441 447 462 469 476 481 493 498 519 524 532 536
do

./run_pt.sh "$pt"

done


















