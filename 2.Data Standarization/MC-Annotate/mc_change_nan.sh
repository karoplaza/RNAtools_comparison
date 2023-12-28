#! /bin/bash

#This script should be performed after the general standarization (mc_awk.sh)
mydir="/path/to/mc_standarized_files"

dirname=$(find "$mydir" -type d -name "*.out")

for dir in $dirname; do
   echo $dir
   find $dir -type f -name "*.csv" -exec sed -i 's/,$/ /' {} +
done


