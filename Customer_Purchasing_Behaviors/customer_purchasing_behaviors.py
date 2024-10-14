"""
    Description: In this file I want to explore the functionalities of the pandas library and do some basic
    data analysis.
"""
import pandas as pd


# Saving the file path to the dataset.
path = "Customer Purchasing Behaviors.csv"

# Loading the data into a dataframe.
df = pd.read_csv(path)

# Displaying 5 rows of the data.
print(df.head())

# Displaying the last 5 rows of the data.
print(df.tail())

# Displaying the column names of the data.
print(df.columns)

# Saving every column as a variable.
user_id = df["user_id"]
age = df["age"]
annual_income = df["annual_income"]
purchase_amount = df["purchase_amount"]
loyalty_score = df["loyalty_score"]
region = df["region"]
purchase_frequency = df["purchase_frequency"]

# Displaying the values of the columns.
print(user_id)
print(age)
print(annual_income)
print(purchase_amount)
print(loyalty_score)
print(region)
print(purchase_frequency)

# Computing some statistics for the variable annual_income.
annual_income_sum = annual_income.sum()
print(annual_income_sum)

annual_income_mean = annual_income.mean()
print(annual_income_mean)

annual_income_min = annual_income.min()
print(annual_income_min)

annual_income_max = annual_income.max()
print(annual_income_max)

annual_income_median = annual_income.median()
print(annual_income_median)

annual_income_varianz = annual_income.var()
print(annual_income_varianz)

annual_income_standard_deviation = annual_income.std()
print(annual_income_standard_deviation)
