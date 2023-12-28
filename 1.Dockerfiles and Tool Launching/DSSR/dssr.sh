#! /bin/bash

mydir='/path/to/all_PDB_files'
pdb=$( ls *.pdb )
mkdir $mydir/dssr

for value in $pdb
do
  sudo docker run --rm -v $mydir:$mydir --entrypoint ./x3dna-dssr dssr-image -i=$mydir/$value > $mydir/dssr/$value
done 
