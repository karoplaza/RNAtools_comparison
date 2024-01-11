#! /bin/bash 

mydir='/path/to/barnaba_output_files'

cd $mydir
out=$( ls *.out )
awkdir='/path/to/awk_scripts'
mkdir $mydir/awk_new


for file in $out
do 
  base=${file::-25}
  echo $base
  sed -i 's/\r//g' $file
  sed -i 's/\r//g' $awkdir/convert.awk
  awk -f $awkdir/convert.awk < $file > $base-all0.csv
  sed -e '2,4d' $base-all0.csv > $base-all.csv
  sed -i 's/\r//g' $base-all.csv
  awk -f $awkdir/canonical.awk < $base-all.csv > $base-canonical.csv
  awk -f $awkdir/non-canonical.awk < $base-all.csv > $base-non-canonical.csv
  mkdir $mydir/awk_new/$base.out
  sudo rm $base-all0.csv 
  sudo rm $base-all1.csv
  mv *.csv $mydir/awk_new/$base.out
done
