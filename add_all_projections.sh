#!/bin/bash
#
for pt in  239n 247n 252n 254n 255n 261n 267n 269n 272n 279n 283n 290n 292n 300n 301n 310n 318n 320n 321n 323n 324n 328n 329n 333n 336n 342n 344n 346n 353n 357n 359n 369n 370n 373n 377n 379n 387n 388n 401n 415n 426n 428n 440n 441n 447n 462n 469n 476n 481n 493n 498n 519n 524n 532n 536n
do

		bsub -n 1 -q short -W 1:00 -R "rusage[mem=1028]" "(python3 Justin_modified.py -pt $pt)"

done











