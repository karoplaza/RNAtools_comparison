#! /bin/bash 

mydir='/path/to/clarnas_output_files'
cd $mydir
out=$( ls *out )
awkdir='path/to/convert.awk'
mkdir $mydir/awk_new

for file in $out
do 
  base=${file::-8}
  echo $base
  sed -i 's/\r//g' $file
  sed -i 's/\r//g' $awkdir/convert.awk
  awk -f $awkdir/convert.awk < $file > $base-all.csv
  sed -i 's/\r//g' $base-all.csv
  awk -f $awkdir/canonical.awk < $base-all.csv > $base.canonical-only.csv
  awk -f $awkdir/non-canonical.awk < $base-all.csv > $base-non-canonical_only.csv
  mkdir $mydir/awk_new/$base.out
  mv *.csv $mydir/awk_new/$base.out
done


