#! /bin/bash

mydir='/path/to/all_PDB_files'
pdb=$( ls *pdb )
mkdir $mydir/log.txt

for i in $pdb
do
  (sudo docker run --rm -v $mydir:$mydir clarna-image rna_clarna_run.py -ipdb $mydir/$i) >> $mydir/log.txt/$i.out
done

