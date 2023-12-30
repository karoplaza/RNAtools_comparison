import pandas as pd
import math

#var1 and var2 are the tools to be compared
var1="barnaba"
var2="rnaview"
# path to a csv listing all the molecules for which pairs were predicted
mol_path = "/usr/name_list.csv"
df_mol = pd.read_csv(mol_path)
mol_list = df_mol["Base name"].tolist()
# types of non-canonical pairs to be analyzed
type_list = ["tHH","tHW","tSH","tSS","tSW","tWW","cHH","cHW","cSH","cSS","cSW","cWW"]


for type in type_list:
    # creating a list where output dataframes will be stored
    all_results = []
    for mol in mol_list:
        print(mol,type)
        # example paths to the standarized output for a given tool for each molecule in mol_list
        path1 = f"/usr/Desktop/{var1}/awk_new/{mol}.out/{mol}-non-canonical.csv"
        path2 = f"/usr/Desktop/{var2}/awk_new/{mol}.out/{mol}-non-canonical.csv"
        df1 = pd.read_csv(path1)
        df2 = pd.read_csv(path2)

        # Creating a dataframe with both parts of each pair and the type/saenger column depending on the case
        # Such dataframes are created for both tools
        new_rows = []
        new_rows_df1 = []
        for index, row in df1.iterrows():
            pair1 = f"{row['chain1']}{row['resname1']}{row['resno1']}"
            pair2 = f"{row['chain2']}{row['resname2']}{row['resno2']}"
            new_rows_df1.append([pair1, pair2, row['type'], 'df1'])
        new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'type', 'source_df'])
        

        new_rows_df2 = []
        for index, row in df2.iterrows():
            pair1 = f"{row['chain1']}{row['resname1']}{row['resno1']}"
            pair2 = f"{row['chain2']}{row['resname2']}{row['resno2']}"
            new_rows_df2.append([pair1, pair2, row['type'], 'df2'])
        new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2', 'type', 'source_df'])

        # Combining both Dataframes, sorting pairs and count how many times each unique pair appears
        combined_df = pd.concat([new_df1, new_df2], ignore_index=True)
        combined_df = combined_df[combined_df["type"] == type]
        #print(combined_df)
        try:
            combined_df['sorted_pairs'] = combined_df.apply(lambda row: '-'.join(sorted([row['pair1'], row['pair2']])),axis=1)
        except:
            combined_df['sorted_pairs'] = ''

        pair_type_counts = combined_df.groupby(['sorted_pairs', 'type']).size().reset_index(name='count')
        pair_type_counts = pair_type_counts[pair_type_counts['type'] == type]

        #The pairs which have count = 2 are the ones which are identical in both csv files
        common_pairs = pair_type_counts[pair_type_counts['count'] == 2]

        # count_df1 and count_df2 state the overall number of pairs in df1 and df2
        count_df1 = combined_df[combined_df['source_df'] == 'df1'].shape[0]
        count_df2 = combined_df[combined_df['source_df'] == 'df2'].shape[0]

        # FP and FN values are calculated based on the absolute difference between overall number of pairs and TP
        TP = len(common_pairs)
        FP = abs(count_df1 - TP)
        FN = abs(count_df2 - TP)

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
                new_rows_df1.append([pair1, pair2, row['type'], 'df1'])
            new_df1 = pd.DataFrame(new_rows_df1, columns=['pair1', 'pair2', 'type', 'source_df'])

            new_rows_df2 = []
            for index, row in df2.iterrows():
                pair1 = f"{row['chain1']}{row['resname1']}{row['resno1']}"
                pair2 = f"{row['chain2']}{row['resname2']}{row['resno2']}"
                new_rows_df2.append([pair1, pair2, row['type'], 'df2'])
            new_df2 = pd.DataFrame(new_rows_df2, columns=['pair1', 'pair2', 'type', 'source_df'])

            combined_df = pd.concat([new_df1, new_df2], ignore_index=True)
            combined_df = combined_df[combined_df["type"] == type]
            try:
                combined_df['sorted_pairs'] = combined_df.apply(lambda row: '-'.join(sorted([row['pair1'], row['pair2']])), axis=1)
                # print(combined_df)
            except:
                break

            pair_type_counts = combined_df.groupby(['sorted_pairs', 'type']).size().reset_index(name='count')
            pair_type_counts = pair_type_counts[pair_type_counts['type'] == type]

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

    # Saving the dataframe with results for all molecules to a csv file
    all_results_df.to_csv(f"/usr/inf_type/{type}/{var1}/{var1}-{var2}-{type}.csv", index=False)
    all_results_df.to_csv(f"/usr/inf_type/{type}/{var2}/{var2}-{var1}-{type}.csv", index=False)


