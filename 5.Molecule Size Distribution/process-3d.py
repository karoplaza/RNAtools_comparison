from Bio.PDB import *
import sys
from pathlib import Path
parser = PDBParser(QUIET=True)
structure = parser.get_structure("str", sys.argv[1])
models_no = len(list(structure.get_models()))
chains_no = len(list(structure.get_chains()))
residues_no = len(list(structure.get_residues()))
print('{},{},{},{}'.format(Path(sys.argv[1]).stem,models_no, chains_no,
residues_no))