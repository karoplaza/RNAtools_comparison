import os
import pandas as pd
import math

file_extension = '.csv'

# for all pairs set type to "all
# for only canonical set type to "can"
# for only non-canonical set type to "ncan"
# for a certain type = "cSH" / "cSS" / "cSW" / "cWW" / "cHH" / "cWH" / "tHH" / "tWH" / "tWW" / "tSS" / "tSH" / "tSW"
type = 'all'
# root directory with all the results for all/canonical/non-canonical pairs
root_directory = f"/usr/inf/{type}"

csv_files = []
var_list = ['clarna', 'dssr', 'fred', 'maxit', 'mc', 'metbp', 'rnapolis', 'rnaview', 'barnaba']

# creating a dataframe with columns and rows corresponding to the analyzed tools
# the last 2 columns correspond to mean INF value for a given tool and a standard deviation values
data = {'var': var_list}
for col in var_list:
    data[col] = [math.nan] * len(var_list)
data['mean values'] = [math.nan] * len(var_list)
data['standard deviation values'] = [math.nan] * len(var_list)

df = pd.DataFrame(data)

# iterating through the csv files and calculating the mean INF value for all the pairs of tools
for root, dirs, files in os.walk(root_directory):
    for file in files:
        if file.endswith(file_extension):
            csv_files.append(os.path.join(root, file))
            print(file)
            parts = file.split("-")
            var1 = parts[0]
            var2 = parts[1]
            file_path = os.path.join(root_directory, var1, file)
            df2 = pd.read_csv(file_path)
            mean_inf = df2['INF'].mean()
            print("Mean of the 'INF' column:", mean_inf)
            loc1 = str(var1)
            loc2 = str(var2)
            # assigning mean INF value to the correct place in the dataframe
            df.loc[df['var'] == loc1, loc2] = mean_inf

# calculating the mean value for each tool based on the values in the dataframe
# calculating the standard deviation values
# in other words, a mean and standard deviation from each row of the dataframe are calculated
def calculate_stats(data_frame):
    numeric_columns = data_frame.columns.difference(['var', 'mean values', 'std values'])
    data_frame['mean values'] = data_frame[numeric_columns].mean(axis=1, skipna=True)
    data_frame['std values'] = data_frame[numeric_columns].std(axis=1, skipna=True)

calculate_stats(df)

# the numbers are modified to look better visually
def format_number(num):
    return '{:.2f}'.format(num)

numeric_cols = df.select_dtypes(include=[float, int]).columns
df[numeric_cols] = df[numeric_cols].applymap(format_number)
df.columns = [None] + list(df.columns[1:])
df = df.set_index(None)

# Replacing nan values with "-"
df.replace('nan', '-', inplace=True)
print(df)

# saving the csv file
csv_name = str(type) + '-ref_table3.csv'
df.to_csv(csv_name)
