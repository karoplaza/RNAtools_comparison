#! /bin/bash

mydir='/path/to/all_PDB_files'
pdb=$( ls *.pdb )
mkdir $mydir/mc

for value in $pdb
do
  sudo docker run --rm -v $mydir:$mydir --entrypoint ./MC-Annotate mc-image $mydir/$value > $mydir/mc/$value
done 
