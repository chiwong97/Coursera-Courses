import pandas as pd 

# Create a key:value colletion of series to use to populate the data frame for testing 
data = {'Month': pd.Series(['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']), 
        'Rainfall': pd.Series([1.65, 1.25, 1.94, 2.75, 3.14, 3.65, 5.05, 1.50, 1.33, 0.07, 0.50, 2.30])}

# Create a dataframe using the static data
df = pd.DataFrame(data)

print(df, '\n')

# Reading the csv file 
dfc = pd.read_csv(r'./rain.csv')

print(dfc, '\n')

# Reading the json file 
dfj = pd.read_json(r'./rain.json')

print(dfj, '\n')

# DATA CLEANING METHODS/STRATEGIES: 
# Method 1:
# Fill in the missing values with zeroes 
dfzeros = dfj.fillna(0)

print(dfzeros)

# Method 2:
# Remove the rows with missing values 
dfclean = dfj.dropna(0)

print(dfclean)

# Create a count of all the rows that contain NaN

count = 0 
for index, row in dfj.iterrows():
    if any(row.isnull()):
        count += 1
print('\nNumber of rows with NaNs: ' + str(count))

# Statistical Analysis on the Data Using Pandas 
# Mean 
print('Mean :')
print(dfclean.mean())

# Median 
print('Median: ')
print(dfclean.median())

# Standard Deviation 
print('Standard Deviation: ')
print(dfclean.std())

# SELECTING PARTS OF A DATAFRAME 
# SELECTING COLUMNS - indexing 
dfclean_temp = dfclean['Temperature']
print(dfclean_temp)

dfclean_temp_rainfall = dfclean[['Temperature', 'Rainfall']]
print(dfclean_temp_rainfall)
print('Temperature and Rainfall mean: ')
print(dfclean_temp_rainfall.mean())

# SELECTING ROWS - loc, iloc
# selecting the third row - iloc
print(dfclean.iloc[2])

# selecting a row using a certain value - loc
# IMPORTANT!!!!!! always remember that you have to set an index first before using loc 
dfIndexed = dfclean.set_index(dfclean['Month'])
print(dfIndexed.loc['March'])

# printing the rainfall and mean for the first few months 
rainfall = dfclean['Rainfall'][0:3]
print(rainfall)
print(rainfall.mean)

