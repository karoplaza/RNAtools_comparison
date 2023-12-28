#! /bin/bash

mydir='/path/to/all_PDB_files'
pdb=$( ls *.pdb )

for value in $pdb
do
  base=$( basename -s .pdb $mydir/$value | cut -c1-4 )
  echo $base
  mkdir $mydir/$base
  cp $value $mydir/$base
  sudo docker run --rm -v $mydir:$mydir fred-image python NA_pairwise_interactions.py -i $mydir/$base -o $mydir/out $value
done 

