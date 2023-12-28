import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

# for all pairs type = "all"
# for canonical type = "can"
# for non-canonical type = "ncan"
# for a certain type = "cSH" / "cSS" / "cSW" / "cWW" / "cHH" / "cWH" / "tHH" / "tWH" / "tWW" / "tSS" / "tSH" / "tSW"
type='ncan'
csv_name = str(type) + '-ref_table3.csv'
df = pd.read_csv(csv_name)
df = df.replace('-', np.nan)
# setting x_labels to tool names
# the plot will show the inf plots for each tool separately so that it is easy to compare the results
x_labels = ["ClaRNA",'DSSR','FR3D','MAXIT','MC-Annotate','MetBP','RNApolis','RNAView','Barnaba']

columns_to_plot = [col for col in df.columns if col not in ['std values', 'mean values','Unnamed: 0']]
df[columns_to_plot] = df[columns_to_plot].apply(pd.to_numeric)
sns.set_palette("Set3")
plt.figure(figsize=(10, 6))
sns.violinplot(data=df[columns_to_plot])
plt.xticks(range(len(x_labels)), x_labels)

# setting the right title
if type == "all":
    plt.title("Wykres Skrzypcowy dla Wszystkich Parowań")
elif type == "can":
    plt.title("Wykres Skrzypcowy dla Parowań Kanonicznych")
elif type == "ncan":
    plt.title("Wykres Skrzypcowy dla Parowań Niekanonicznych")
else:
    plt.title(f"Wykres Skrzypcowy dla Parowań Niekanonicznych typu {type}")
plt.xlabel("Narzędzia")
plt.ylabel("Wartość INF")

plt.ylim(0,1.1)
plt.show()
# saving the plot, example name
plt.savefig(f"plot-{type}.pdf")