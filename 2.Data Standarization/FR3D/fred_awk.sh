#! /bin/bash 

mydir='/path/to/fred_output_files'
cd $mydir
txt=$( ls *txt )
awkdir='/path/to/awk_scripts'
mkdir $mydir/awk_new

for file in $txt
do 
  base=${file::-13}
  echo $base
  #sed -i 's/\r//g' $file
  #sed -i 's/\r//g' $awkdir/canonical.awk
  #sed -i 's/\r//g' $awkdir/non-canonical.awk
  #sed -i 's/\r//g' $awkdir/convert.awk
  awk -f $awkdir/convert.awk < $file > $base-all.csv
  #sed -i 's/\r//g' $base-all.csv
  awk -f $awkdir/canonical.awk < $base-all.csv > $base-canonical.csv
  awk -f $awkdir/non-canonical.awk < $base-all.csv > $base-non-canonical.csv
  mkdir $mydir/awk_new/$base.out
  mv *csv $mydir/awk_new/$base.out
done
