# Project Description
The objective of this project is to compare various RNA tools which predict the secondary RNA structure, based on the tertiary RNA structure. The list of the analyzed tools is as follows: Barnaba, ClaRNA, DSSR, FR3D, MAXIT, MetBP, MC-Annotate, RNApolis, RNAView. The analysis has been performed using a repository with 1790 PDB files downloaded from RNAsolo ("RNA_PDB.zip"). The analysis includes:

- Creating Dockerfiles for each tool, launching each tool and performing the predictions on all of the PDB files in RNA_PDB.zip
- Standarizing the output
- Filtering out the molecules for which no pairs were predicted
- Calculating INF values: first for each molecule and each set of tools, then an overall INF value for each set of tools, and finally, a mean value for each tool. Obtaining visual results - tables and plots summarizing the INF values calculations.
- The analysis of the INF values was performed separately for all predicted pairs, only canonical pairs, and only non-canonical pairs. Additionally, for non-canonical pairs, an extra analysis was performed with a separation for each class of non-canonical pairs (cHH, cHW, cSW, cWW, cSS, cSH, tHH, tHW, tSW, tWW, tSS, THS).
- Analyzing the distribution of molecule size in the RNA set.

## Example Analysis
The example analysis is showed for a molecule 1A9N_1_Q.pdb. 

**Tool Launching**

Before launching each tool, a Docker image has to be built based on a Dockerfile for the given tool. An example of building a Docker image for the ClaRNA tool is shown below. 
```sh
docker build -t clarna-image .
```
In this project, all the necessary files to create the respective Docker images are provided for most tools. The only exception is the DSSR tool, for which a license is required

Generally, PDB files are required as input to launch the tools. The output file formats vary based on the tool. Sample output files for 1A9N_1_Q.pdb can be found in the '1.Dockerfiles and Tool Launching' directory, within the folders corresponding to the respective tools used to generate the results.

1) Barnaba
```sh
docker run --rm -v /path:/path barnaba-image barnaba ANNOTATE --pdb 1A9N_1_Q.pdb -o 1A9N_1_Q.out
```
The ouput file is written to a file with a suffix ".ANNOTATE.pairing.out"
2) ClaRNA
```sh
docker run --rm -v /path:/path clarna-image rna_clarna_run.py -ipdb 1A9N_1_Q.pdb >> 1A9N_1_Q.out
```
3) DSSR
```sh
run --rm -v /path:/path --entrypoint ./x3dna-dssr dssr-image -i=1A9N_1_Q.pdb > 1A9N_1_Q.out
```
4) FR3D
```sh
docker run --rm -v /path:/path fred-image python NA_pairwise_interactions.py -i 1A9N_1_Q -o /path 1A9N_1_Q.out
```
5) MAXIT 
When launching MAXIT tool, to obtain correct results the Docker image needs to be used twice, as shown below.
```sh
docker run --rm -v /path:/path maxit-10.0:latest -input 1A9N_1_Q.pdb -output 1A9N_1_Q.cif -o 1
```
```sh
awk -f filter.awk < 1A9N_1_Q.cif > 1A9N_1_Q_filtered.cif
```
```sh
docker run --rm -v /path:/path maxit-10.0:latest -input 1A9N_1_Q_filtered.cif -output 1A9N_1_Q.cif.cif -o 8
```
The ouput file is written to a file with a suffix ".cif.cif"
6) MC-Annotate
```sh
docker run --rm -v /path:/path --entrypoint ./MC-Annotate mc-image 1A9N_1_Q.pdb > 1A9N_1_Q.out
```
7) MetBP
```sh
docker run --rm -v /path:/path --entrypoint ./metbp.linux metbp-image 1A9N_1_Q.pdb -mode=dev
```
The output file is written to a file with a suffix "basepair.json"
8) RNAView
```sh
docker run --rm -v /path:/path --entrypoint ./rnaview rnaview-image 1A9N_1_Q.pdb 
```
9) RNApolis
```sh
docker run --rm -v /path:/path --entrypoint annotator rnapolis-image --csv 1A9N_1_Q_out.csv 1A9N_1_Q.pdb 
```

**Standarization**

Depending on the tool, various standardization steps were necessary to apply. Below are example standardization commands. For each tool, the final output consists of three files listing standardized pairs: one includes all generated pairs, one for only canonical pairs, and one for only non-canonical pairs. Example Standarization Results are included in the directory called 'Example Results'.
1. DSSR, MAXIT, MC-Annotate and RNAView
For the tools listed above, the following commands are used to standarize the data. In Maxit's case 1A9N_1_Q.cif.cif instead of 1A9N_1_Q.out should be used.
```sh
awk -f convert.awk < 1A9N_1_Q.out > 1A9N_1_Q-all.csv
```
```sh
awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && ($NF==19 || $NF==20 || $NF==28)' < 1A9N_1_Q-all.csv > 1A9N_1_Q-canonical.csv
```
```sh
awk 'BEGIN {FS=",";} NR==1 {print $0;} (NR>1) && !($NF==19 || $NF==20 || $NF==28)' < 1A9N_1_Q-all.csv > 1A9N_1_Q-non-canonical.csv
```
2. ClaRNA, MetBP, Barnaba, FR3D
For the tools listed above, the following commands are used to standarize the data. In MetBP's case 1A9N_1_Q.basepair.json should be used instead of 1A9N_1_Q.out and in Barnaba's case 1A9N_1_Q.ANNOTATE.pairing.out should be used instead of 1A9N_1_Q.out
```sh
awk -f convert.awk < 1A9N_1_Q.out > 1A9N_1_Q-all.csv
```
```sh
awk -f canonical.awk < 1A9N_1_Q-all.csv > 1A9N_1_Q-canonical.csv
```
```sh
awk -f non-canonical.awk < 1A9N_1_Q-all.csv > 1A9N_1_Q-non-canonical.csv
```
3. Barnaba - additional standarization
In Barnaba's case extra steps for data standarization are required.
- Modyfing the output file
```sh
sed -e '2,4d' 1A9N_1_Q-all.csv > 1A9N_1_Q-all.csv
```
- Standardizing the chain identifiers involves using two different scripts: 'barnaba_chains_mapping.awk' and 'barnaba_chains_mapping2.awk'. Depending on which script is included in 'mapping.awk', different chain IDs are obtained. Both output files are later needed for a precise INF value analysis. Two example result files are included in the 'Example Standarization Results' directory called respectively 'barnaba_results' and 'barnaba_results2'.
```sh
echo 1A9N_1_Q-all.csv | awk -v u=1 -f barnaba_chains_mapping2.awk > mapping.csv
```
```sh
awk -f mapping.awk mapping.csv 1A9N_1_Q-all.csv > 1A9N_1_Q-all_changed.csv
```
```sh
awk -f mapping.awk mapping.csv 1A9N_1_Q-canonical.csv > 1A9N_1_Q-canonical_changed.csv
```
```sh
awk -f mapping.awk mapping.csv 1A9N_1_Q-non-canonical.csv > 1A9N_1_Q-non-canonical.csv
```
4. RNApolis
The standarization process for RNApolis tool requires commands shown below.
```sh
awk 'BEGIN {FS=",";} NR==1 || $3 == "base pair" {print $1 "," $2 "," $4 "," $5;}' < 1A9N_1_Q_out.pdb > 1A9N_1_Q-all0.csv
```
```sh
awk -f transform_ids.awk < 1A9N_1_Q-all0.csv > 1A9N_1_Q-all.csv
```
```sh
awk 'BEGIN {FS=",";} NR==1 || $3 == "base pair" && ($NF == "XIX" || $NF == "XX" || $NF == "XXVIII") {print $1 "," $2 "," $4 "," $5;}' < 1A9N_1_Q_out.csv > 1A9N_1_Q-canonical0.csv
```
```sh
awk -f transform_ids.awk < 1A9N_1_Q-canonical0.csv > 1A9N_1_Q-canonical.csv
```
```sh
awk 'BEGIN {FS=",";} NR==1 || $3 == "base pair" && !($NF == "XIX" || $NF == "XX" || $NF == "XXVIII") {print $1 "," $2 "," $4 "," $5;}' < 1A9N_1_Q_out.csv > 1A9N_1_Q-non-canonical0.csv
```
```sh
awk -f transform_ids.awk < 1A9N_1_Q-non-canonical0.csv > 1A9N_1_Q-non-canonical.csv
```

**Further Analysis**

Next steps of the Evaluation included filtering out the molecules for which no pairs were generated, calculating the Interaction Netwrok Fidelity (INF) values and analysing both size distribution and its influence on the obtained INF results. For this reason, scripts included in directories 'Number of Pairs','INF Values' and 'Molecule Size Distribution' have been used. 

When calculating the INF value, the tools have been compared in pairs. Each tool has been compared as both the reference tools and compared tool. In python scripts provided in 'INF Values' directory, the differences in information provided by the tools (Leontis Westhof's classification, Saenger's classification or both) are taken into account and it's possible to modify the scripts accordingly.

