#! /bin/bash

cd /path/to/all_PDB_files


# the names refer to numbers of models, chains and residues
echo "molecule name,models,chains,residues" >> 3d-stats.csv

# names.csv is a csv listing all molecules for which any pairs were predicted
mapfile -t names < name_list.csv

for name in "${names[@]}"; do
   if [ -f "$name.pdb" ]; then
      echo "$name.pdb"
      python3 process-3d.py "$name.pdb" >> 3d-stats.csv
    fi
done

