import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

EgeriaDaphniaAccu = pd.read_excel("C:/Users/uysal/OneDrive/Documents/eDNA_RProject/data/Data.xlsx", sheet_name="EgeriaDaphniaAccu", header=None, skiprows=1, usecols="A:L", na_values="na")
EgeriaDaphniaCopyNumberAccuFiltered = EgeriaDaphniaAccu[(EgeriaDaphniaAccu[10] != "") & (~EgeriaDaphniaAccu[10].isna())]


# Assuming EgeriaDaphniaCopyNumberAccuFiltered is already defined
# If not, you need to load the data and filter it as you did before

# Convert the x-axis values (time) to strings (categorical data)
EgeriaDaphniaCopyNumberAccuFiltered[0] = EgeriaDaphniaCopyNumberAccuFiltered[0].astype(str)

# Create the scatter plot
plt.figure()
sns.scatterplot(data=EgeriaDaphniaCopyNumberAccuFiltered, x=EgeriaDaphniaCopyNumberAccuFiltered[0], y=EgeriaDaphniaCopyNumberAccuFiltered[11], hue=EgeriaDaphniaCopyNumberAccuFiltered[11])
plt.yscale('log')
plt.xlabel('Time (Hours)')
plt.ylabel('DNA Copies/g')
plt.title('')
plt.legend(loc='lower left')

# Show the plot
plt.show()
