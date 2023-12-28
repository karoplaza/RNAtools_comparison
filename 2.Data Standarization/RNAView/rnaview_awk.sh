#! /bin/bash 

mydir='/path/to/rnaview_output_files'
cd $mydir
out=$( ls *out )
awkdir='/path/to/awk_scripts'
mkdir $mydir/awk_new

for file in $out
do 
  base=${file::-8}
  echo $base
  sudo chmod +x $file
  sed -i 's/\r//g' $file
  sed -i 's/\r//g' $awkdir/convert.awk
  sudo awk -f $awkdir/convert.awk < $file > $base-all.csv
  sed -i 's/\r//g' $base-all.csv
  sudo chmod +x $base-all.csv
  sudo awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && ($NF==19 || $NF==20 || $NF==28)' < $base-all.csv > $base-canonical.csv
  sudo awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && !($NF==19 || $NF==20 || $NF==28)' < $base-all.csv > $base-non-canonical.csv
  sudo mkdir $mydir/awk_new/$base.out
  sudo mv *.csv /$mydir/awk_new/$base.out
done
