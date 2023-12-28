#! /bin/bash 

mydir='/path/to/maxit_output_files'
cd $mydir
out=$( ls *cif.cif )
awkdir='/path/to/awk_scripts'
mkdir $mydir/awk_new

for file in $out
do 
  base=${file::-8}
  echo $base
  sed -i 's/\r//g' $file
  sed -i 's/\r//g' $awkdir/convert.awk
  awk -f $awkdir/convert.awk < $file > $base-all.csv
  sed -i 's/\r//g' $base-all.csv
  awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && ($NF==19 || $NF==20 ||$NF==28)' < $base-all.csv > $base-canonical.csv
  awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && !($NF==19 || $NF==20 || $NF==28)' < $base-all.csv > $base-non-canonical.csv
  mkdir $mydir/awk_new/$base.out
  mv *csv $mydir/awk_new/$base.out
done
  
  
  
