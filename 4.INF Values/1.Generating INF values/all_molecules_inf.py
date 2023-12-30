import os
import pandas as pd
import math

# "all" for all pairs
# "can" for canonical pairs
# "ncan" for non-canonical pairs
type='ncan'
#example path to output for selected type of pairs
root_directory = f"/usr/inf/{type}"

csv_files = []
var_list = ['clarna','dssr','fred','maxit','mc','metbp','rnapolis','rnaview',"barnaba"]

# using a file listing the number of pairs in all molecules to get a list of molecules to analyze
names_path = f"/usr/numpairs-{type}.csv"
df_names = pd.read_csv(names_path)
molecule_list = df_names['name'].tolist()

# creating a dataframe, every row includes:
# 1) molecule name
# 2) The mean of INF value calculated based on INF values from all possible sets of tools
# 3) Percentage of tool sets which gave an output for a given molecuke
output = {'molecule': molecule_list,
          'inf_mean': [0]* len(molecule_list),
          'matrix_perc [%]':[0]* len(molecule_list)
          }

df_out = pd.DataFrame(output)

# iterating through molecules and creating a list of INF values for each molecule (inf_list)
for mol in molecule_list:
    inf_list=[]
    for root, dirs, files in os.walk(root_directory):
        for file in files:
            if file.endswith('.csv'):
               csv_files.append(os.path.join(root, file))
               parts = file.split("-")
               var1 = parts[0]
               var2 = parts[1]
               # example path to the csv output with INF values for a given set of tools
               file_path = f"{root_directory}/{var1}/{file}"
               df2 = pd.read_csv(file_path)
               df2 = df2[df2['INF'] != '']
               try:
                   matching_row = df2[df2['Molecule'] == mol]
                   inf_value = matching_row['INF'].values[0]
                   inf_list.append(inf_value)
               except:
                   print("no inf")
                   break

    # the number of items in inf_list is calculated (without the "nan" values)
    inf_num = len([x for x in inf_list if not math.isnan(x)])
    # the sum of items in inf_list is calculated (without the "nan" values)
    sum_inf = math.fsum(x for x in inf_list if not math.isnan(x))

    # the mean value is calculated (value) and teh percentage of sets of tools which give a not "nan" output
    try:
       value = sum_inf/inf_num
       perc = inf_num / 72 * 100
    except:
        value = math.nan
        perc = math.nan

    # the molecule name, INF value and percantage are added as a new row to the dataframe
    df_out.loc[df_out['molecule'] == mol, 'inf_mean'] = value
    df_out.loc[df_out['molecule'] == mol, 'matrix_perc [%]'] = perc

# The numbers in dataframe being changed to a format more pleasant to read
def format_number(num):
    return '{:.2f}'.format(num)

df_out['inf_mean'] = pd.to_numeric(df_out['inf_mean'], errors='coerce')
df_out['matrix_perc [%]'] = pd.to_numeric(df_out['matrix_perc [%]'], errors='coerce')
columns_to_format = ['inf_mean', 'matrix_perc [%]']
df_out[columns_to_format] = df_out[columns_to_format].applymap(format_number)

# Saving the dataframe to a csv file
print(df_out)
df_out.to_csv(f"{type}-newinftable.csv", index=False)





