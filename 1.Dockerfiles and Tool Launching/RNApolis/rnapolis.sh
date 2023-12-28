#! /bin/bash

mydir='/path/to/all_PDB_files'
pdb=$( ls *.pdb )
mkdir $mydir/rnapolis

for value in $pdb
do
  base=$( basename -s .pdb $mydir/$value | cut -c1-4 )
  output=$( sudo docker run --rm -v /tmp:/tmp --entrypoint annotator rnapolis-image --csv $mydir/$base.csv $mydir/$value )
  cp $mydir/$base.csv /$mydir/rnapolis/$value.csv
done 

