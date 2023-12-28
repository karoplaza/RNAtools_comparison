#! /bin/bash 

mydir='/path/to/rnapolis_output_files'
cd $mydir
csv=$( ls *csv )
awkdir='path/to/awk_script'
mkdir $mydir/awk_new

for file in $csv
do 
  base=${file::-8}
  echo $base
  sed -i 's/\r//g' $file
  sed -i 's/\r//g' $awkdir/transform_ids.awk
  awk 'BEGIN {FS=",";} NR==1 || $3 == "base pair" && ($NF == "XIX" || $NF == "XX" || $NF == "XXVIII") {print $1 "," $2 "," $4 "," $5;}' < $file > $base-canonical0.csv
  awk -f $awkdir < $base-canonical0.csv > $base-canonical.csv
  awk 'BEGIN {FS=",";} NR==1 || $3 == "base pair" && !($NF == "XIX" || $NF == "XX" || $NF == "XXVIII") {print $1 "," $2 "," $4 "," $5;}' < $file > $base-non-canonical0.csv
  awk -f $awkdir < $base-non-canonical0.csv > $base-non-canonical.csv
  awk 'BEGIN {FS=",";} NR==1 || $3 == "base pair" {print $1 "," $2 "," $4 "," $5;}' < $file > $base-all0.csv
  awk -f $awkdir < $base-all0.csv > $base-all.csv
  mkdir $mydir/awk_new/$base.out
  mv *.csv $mydir/awk_new/$base.out
done

