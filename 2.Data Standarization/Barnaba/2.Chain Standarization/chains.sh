#! /bin/bash

mydir="/path/to/barnaba_output_files"
cd $mydir
awkdir="/path/to/awk_scripts"

dirname=$(find "$mydir" -type d -name "*.out" -exec basename {} \; | sort -t '_' -k1.1,1n -k1)


# Depending on the awk script (barnaba_chains_mapping.awk or barnaba_chains_mapping2.awk the chain IDs will be different
# The results can be saved for example as "$base-all.csv" and "$base-all2.csv" to distinguish between the differently standarized files
# Both standarization methods are needed to get the correct INF values 

for file in $dirname
do
    echo $file
    cd $mydir/$file
    base=${file::-4}
    echo $base-all.csv | awk -v u=1 -f $awkdir/barnaba_chains_mapping2.awk > mapping.csv
    awk -f $awkdir/mapping.awk mapping.csv $base-all.csv > $base-all.csv
    awk -f $awkdir/mapping.awk mapping.csv $base-canonical.csv > $base-canonical.csv
    awk -f $awkdir/mapping.awk mapping.csv $base-non-canonical.csv > $base-non-canonical.csv
done
    
