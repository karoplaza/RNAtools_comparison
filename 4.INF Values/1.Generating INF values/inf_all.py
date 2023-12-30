import pandas as pd
import math

# When Maxit1 = True only the pairs will be compared (without "type" column or "saenger" column)
Maxit1 = False
# When Maxit2 = True except from the pairs also "saenger" column will be compared
Maxit2 = False

#var1 and var2 are the tools to be compared
var1="dssr"
var2="rnapolis"
#names.csv is a csv including all the names of the molecules for which at least one tool predicted pairs (all the molecules without any pairs were filtered out)
mol_path = "/path/to/names.csv"
df_mol = pd.read_csv(mol_path)
mol_list = df_mol["Base name"].tolist()
type_list = ["all", "canonical","non-canonical"]


for type in type_list:
    all_results = []
    for mol in mol_list:
        print(type, mol)
        # path1 and path2 should be the paths so the correct csv files. Example paths are given below.
        path1 = f"/usr/Desktop/{var1}/awk_new/{mol}.out/{mol}-{type}.csv"
        path2 = f"/usr/Desktop/{var2}/awk_new/{mol}.out/{mol}-{type}.csv"
        df1 = pd.read_csv(path1)
        df2 = pd.read_csv(path2)


        # Creating a dataframe with both parts of each pair and the type/saenger column depending on the case
        # Such dataframes are created for both tools
        new_rows_df1 = []
        for index, row in df1.iterrows():
            pair1 = f"{row['chain1']}{row['resname1']}{row['resno1']}"
            pair2 = f"{row['chain2']}{row['resname2']}{row['resno2']}"
            if Maxit1:
                new_rows_df1.append([pair1, pair2, 'df1'])
            elif Maxit2:
                new_rows_df1.append([pair1, pair2, row['saenger'], 'df1'])
            else:
                new_rows_df1.append([pair1, pair2, row['type'], 'df1'])

        if Maxit1:
            new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'source_df'])
        elif Maxit2:
            new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'saenger', 'source_df'])
        else:
            new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'type', 'source_df'])


        new_rows_df2 = []
        for index, row in df2.iterrows():
            pair1 = f"{row['chain1']}{row['resname1']}{row['resno1']}"
            pair2 = f"{row['chain2']}{row['resname2']}{row['resno2']}"
            if Maxit1:
                new_rows_df2.append([pair1, pair2, 'df2'])
            elif Maxit2:
                new_rows_df2.append([pair1, pair2, row['saenger'], 'df2'])
            else:
                new_rows_df2.append([pair1, pair2, row['type'], 'df2'])

        if Maxit1:
            new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2','source_df'])
        elif Maxit2:
            new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2', 'saenger', 'source_df'])
        else:
           new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2', 'type', 'source_df'])


        #Combining both Dataframes, sorting pairs and count how many times each unique pair appears
        combined_df = pd.concat([new_df1, new_df2], ignore_index=True)
        try:
            combined_df['sorted_pairs'] = combined_df.apply(lambda row: '-'.join(sorted([row['pair1'], row['pair2']])),axis=1)
        except:
            combined_df['sorted_pairs'] = ''


        if Maxit1:
            pair_type_counts = combined_df.groupby(['sorted_pairs'],dropna=False).size().reset_index(name='count')
        elif Maxit2:
            pair_type_counts = combined_df.groupby(['sorted_pairs', 'saenger'],dropna=False).size().reset_index(name='count')
        else:
            pair_type_counts = combined_df.groupby(['sorted_pairs', 'type'], dropna=False).size().reset_index(name='count')

        #The pairs which have count = 2 are the ones which are identical in both csv files
        common_pairs = pair_type_counts[pair_type_counts['count'] == 2]
        # count_df1 and count_df2 state the overall number of pairs in df1 and df2
        count_df1 = combined_df[combined_df['source_df'] == 'df1'].shape[0]
        count_df2 = combined_df[combined_df['source_df'] == 'df2'].shape[0]

        # FP and FN values are calculated based on the absolute difference between overall number of pairs and TP
        TP = len(common_pairs)
        FP = abs(count_df1-TP)
        FN = abs(count_df2-TP)

       # The if statement eliminates cases in which only one tool predicted some pairs (in these cases INF value cant be calculated
        if TP > 0 or (FP > 0 and FN > 0):
            PPV = TP / (TP + FP)
            TPR = TP / (TP + FN)
            INF = math.sqrt(TPR * PPV)
        else:
            PPV = math.nan
            TPR = math.nan
            INF = math.nan

        # In case INF value is equal 0 because the chain IDs are switched
        # for example if tool1 says - AG16:BC17 and tool2 - BG16:AC17
        if INF == 0:
            new_rows_df1 = []
            for index, row in df1.iterrows():
                # here chain1 and chain2 have been switched, the rest of the code in the if statement is the same as above
                pair1 = f"{row['chain2']}{row['resname1']}{row['resno1']}"
                pair2 = f"{row['chain1']}{row['resname2']}{row['resno2']}"
                if Maxit1:
                    new_rows_df1.append([pair1, pair2, 'df1'])
                elif Maxit2:
                    new_rows_df1.append([pair1, pair2, row['saenger'], 'df1'])
                else:
                    new_rows_df1.append([pair1, pair2, row['type'], 'df1'])

            if Maxit1:
                new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'source_df'])
            elif Maxit2:
                new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'saenger', 'source_df'])
            else:
                new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'type', 'source_df'])

            new_rows_df2 = []
            for index, row in df2.iterrows():
                pair1 = f"{row['chain1']}{row['resname1']}{row['resno1']}"
                pair2 = f"{row['chain2']}{row['resname2']}{row['resno2']}"
                if Maxit1:
                    new_rows_df2.append([pair1, pair2, 'df2'])
                elif Maxit2:
                    new_rows_df2.append([pair1, pair2, row['saenger'], 'df2'])
                else:
                    new_rows_df2.append([pair1, pair2, row['type'], 'df2'])

            if Maxit1:
                new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2', 'source_df'])
            elif Maxit2:
                new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2', 'saenger', 'source_df'])
            else:
                new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2', 'type', 'source_df'])


            combined_df = pd.concat([new_df1, new_df2], ignore_index=True)
            try:
                combined_df['sorted_pairs'] = combined_df.apply(
                    lambda row: '-'.join(sorted([row['pair1'], row['pair2']])), axis=1)
            except:
                break

            if Maxit1:
                pair_type_counts = combined_df.groupby(['sorted_pairs'], dropna=False).size().reset_index(name='count')
            elif Maxit2:
                pair_type_counts = combined_df.groupby(['sorted_pairs', 'saenger'], dropna=False).size().reset_index(
                    name='count')
            else:
                pair_type_counts = combined_df.groupby(['sorted_pairs', 'type'],dropna=False).size().reset_index(name='count')
                

            common_pairs = pair_type_counts[pair_type_counts['count'] == 2]
            count_df1 = combined_df[combined_df['source_df'] == 'df1'].shape[0]
            count_df2 = combined_df[combined_df['source_df'] == 'df2'].shape[0]

            TP = len(common_pairs)
            FP = abs(count_df1 - TP)
            FN = abs(count_df2 - TP)

            if TP > 0 or (FP > 0 and FN > 0):
                PPV = TP / (TP + FP)
                TPR = TP / (TP + FN)
                INF = math.sqrt(TPR * PPV)
            else:
                PPV = math.nan
                TPR = math.nan
                INF = math.nan

        # Creating a dataframe for each analysed molecule for a given pair of tools
        result_df = pd.DataFrame({
            'Molecule': [mol],
            'TP': [TP],
            'FN': [FN],
            'FP': [FP],
            'PPV': [PPV],
            'TPR': [TPR],
            'INF': [INF]
        })
        # Adding the dataframe to a list of dataframes for a given pair of tools
        all_results.append(result_df)

    # Combining all results
    try:
        all_results_df = pd.concat(all_results, ignore_index=True)
    except:
        all_results_df = pd.DataFrame(columns=['Molecule', 'TP', 'FN', 'FP', 'PPV', 'TPR', 'INF'])
    # Checking the mean value of INF values for a given pair of tools
    #mean_inf =all_results_df['INF'].mean()
    #print("mean":mean_inf)

    # Saving the csv files, example paths and names are given below
    if type == "all":
        all_results_df.to_csv(f"/usr/Desktop/python/inf/{type}/{var1}/{var1}-{var2}-{type}.csv", index=False)
    if type == "canonical":
        all_results_df.to_csv(f"/usr/Desktop/python/inf/can/{var1}/{var1}-{var2}-can.csv", index=False)
    if type == "non-canonical":
        all_results_df.to_csv(f"/usr/Desktop/python/inf/ncan/{var1}/{var1}-{var2}-ncan.csv", index=False)
