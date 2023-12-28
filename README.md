# RNAtools_comparison

The objective of this project is to compare various RNA tools which predict the secondary RNA structure, based on the tertiary RNA structure.
The list of the analyzed tools is as follows: Barnaba, ClaRNA, DSSR, FR3D, MAXIT, MetBP, MC-Annotate, RNApolis, RNAView.
The analysis has been performed using a repository with 1790 PDB files downloaded from RNAsolo ("RNA_PDB.zip").
The analysis includes:
1) Creating Dockerfiles for each of the tool
2) Launching each tool and performing the predictions on all of the PDB files in RNA_PDB.zip
3) Standarizing the output
4) Filtering out the molecules for which no pairs were predicted
5) INF values calculations: first for each molecule and each set of tools, then an overall INF value for each set of tools, and finally, a mean value for each tool.
6) Obtaining visual results - tables and plots summarizing the INF values calculations

The analysis of the INF values was performed separately for all predicted pairs, only canonical pairs, and only non-canonical pairs. Additionally, for non-canonical pairs, an extra analysis was performed with a separation for each class of non-canonical pairs (cHH, cHW, cSW, cWW, cSS, cSH, tHH, tHW, tSW, tWW, tSS, THS).
