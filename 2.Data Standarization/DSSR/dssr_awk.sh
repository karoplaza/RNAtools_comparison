#! /bin/bash 

mydir='/path/to/dssr_output_files'
cd $mydir
pdb=$( ls *pdb )
awkdir='/path/to/convert.awk'
mkdir $mydir/awk_new

for file in $pdb
do 
  base=${file::-4}
  echo $base
  sed -i 's/\r//g' $file
  sed -i 's/\r//g' $awkdir/convert.awk
  awk -f $awkdir/convert.awk < $file > $base-all.csv
  sed -i 's/\r//g' $base-all.csv
  awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && ($NF==19 || $NF==20 || $NF==28)' < $base-all.csv > $base-canonical.csv
  awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && !($NF==19 || $NF==20 || $NF==28)' < $base-all.csv > $base-non-canonical.csv
  mkdir $mydir/awk_new/$base.out
  mv *csv $mydir/awk_new/$base.out
done
