#! /bin/bash

mydir='/path/to/all_PDB_files'
pdb=$( ls *.pdb )

for value in $pdb
do
  output=$( sudo docker run --rm -v /tmp:/tmp --entrypoint ./metbp.linux metbp-image $mydir/$value -mode=dev )
done 

basepairs=$( ls *basepair.json )
mkdir $mydir/metbp

for file in $basepairs
do
  mv $mydir/$file $mydir/metbp
done

#Removing files iles not useful for this project
sudo rm *metbp.json *metnuc.json *.sum *.met *.det *.pml