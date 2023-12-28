#! /bin/bash

mydir='/path/to/all_PDB_files'
cd $mydir
pdb=$( ls *pdb )
mkdir $mydir/barnaba

for i in $pdb
do
  sudo docker run --rm -v /tmp:/tmp barnaba-image barnaba ANNOTATE --pdb $mydir/$i -o $mydir/barnaba/$i
  mkdir $mydir/barnaba/$i
  cd $mydir/barnaba
  sudo mv *pairing.out $mydir/barnaba/$i
  sudo rm *stacking.out
done


