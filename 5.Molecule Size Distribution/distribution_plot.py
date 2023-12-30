import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# path to a file listing the number of nucleotides in each molecule
filepath1='/usr/3d-stats.csv'
df = pd.read_csv(filepath1)
residue_number = df['residues'].tolist()
series = pd.Series(residue_number)
counts = series.value_counts()
sorted_counts = counts.sort_index(ascending=True)
df2 = pd.DataFrame({'Number': sorted_counts.index, 'Count': sorted_counts.values})
#print(sorted(residue_number))
#print(max(residue_number))

sns.displot(df11, x="Number",kde="True",bins=100,color='blue')

# ENG: "Molecule size (number of nucleotides)
plt.xlabel('Rozmiar cząsteczki (liczba nukleotydów)')
# ENG: "Number of molecules"
plt.ylabel('Liczba cząsteczek')
# ENG: "Distribution of molecule size in the RNA set
plt.title('Rozkład rozmiaru cząsteczek RNA w zbiorze')

# showing and saving the plot
plt.show()
plt.savefig("distribution.pdf")

