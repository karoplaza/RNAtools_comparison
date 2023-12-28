#! /bin/bash

mydir='/path/to/all_PDB_files'
pdb=$( ls *.pdb )

for value in $pdb
do
  output=$( sudo docker run --rm -v $mydir:$mydir --entrypoint ./rnaview rnaview-image $mydir/$value )
done 

pdb_out=$( ls *pdb.out )
mkdir $mydir/rnaview

for files in $pdb_out
do
  mv $mydir/$files $mydir/rnaview
done
