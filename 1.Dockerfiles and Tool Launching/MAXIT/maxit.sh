#! /bin/bash

mydir='/path/to/all_PDB_files'
cd $mydir
awkdir='/path/to/filter.awk'
pdb=$( ls *.pdb )

for value in $pdb
do
  echo $value
  sudo docker run --rm -v $mydir:$mydir maxit-10.0:latest -input $mydir/$value -output $mydir/$value.cif -o 1 
done 

cif=$( ls *.cif )

for item in $cif
do
  base=${item::-8}
  echo $base 
  awk -f $awkdir/filter.awk < $item > $base_p.cif
  sudo docker run --rm -v $mydir:$mydir maxit-10.0:latest -input $mydir/$base_p.cif -output $mydir/$base.cif.cif -o 8
done
 
cifcif=$( ls *cif.cif )
mkdir $mydir/maxit_cifcif

for cifcif in $cifcif
do
  mv $cifcif $mydir/maxit_cifcif
done





