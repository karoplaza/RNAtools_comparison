#! /bin/bash 

mydir='/path/to/metbp_output_files'
cd $mydir
json=$( ls *json )
awkdir='/path/to/awk_scripts'
mkdir $mydir/awk_new


for file in $json
do 
  base=${file::-14}
  echo $base
  sed -i 's/\r//g' $file
  sed -i 's/\r//g' $awkdir/canonical.awk
  sed -i 's/\r//g' $awkdir/non-canonical.awk
  sed -i 's/\r//g' $awkdir/convert.py
  python3 $awkdir/convert.py $file > $base-all.csv
  sed -i 's/\r//g' $base-all.csv
  awk -f $awkdir/canonical.awk < $base-all.csv > $base-canonical.csv
  awk -f $awkdir/non-canonical.awk < $base-all.csv > $base-non-canonical.csv
  mkdir $mydir/awk_new/$base.out
  mv *csv $mydir/awk_new/$base.out
done
  
  

