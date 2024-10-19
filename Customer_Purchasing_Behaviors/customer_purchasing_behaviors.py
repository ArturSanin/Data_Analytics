"""
    Description: In this project I want to analyze the Customer Purchasing Behaviors dataset. You can find the dataset
    following this link: https://www.kaggle.com/datasets/hanaksoy/customer-purchasing-behaviors
"""
import pandas as pd

# Loading the csv file into a Dataframe.
path = "Customer Purchasing Behaviors.csv"

df = pd.read_csv(path)

# Displaying the first 10 rows of the dataset.
print(df.head(10))

# Displaying the last 10 rows of the dataset.
print(df.tail(10))

# Looking at the shape of the DataFrame.
df_shape = df.shape

print("Row count:", df_shape[0])
print("Column count:", df_shape[1])

# Getting an overview on some important statistics for all numerical columns in the dataset.
print(df.describe())

# The count for every column is the same. The count function counts all non-NULL values.
# This means, that there are no NULL values in the numerical columns.

# Looking if there are NULL values in the column region.
print(df["region"].count())

# The column region has no NULL values.

"""
    What is the average annual income per region? Which region has the highest average annual income?
"""

# To answer this question, we need to group the data by the column region, and then apply the mean() function on
# every value. Then we sort the values descending.
avg_annual_income_per_region = df.groupby("region")["annual_income"].mean().round(2).sort_values(ascending=False)
avg_annual_income_per_region.name = "average_annual_income"
print(avg_annual_income_per_region)


"""
    The mean is sensitive towards outliers. The median is a more robust statistic.
    What is the median annual income per region? In which region has the highest median? 
"""

# To answer this question, we need to group the data by the column region, and then apply the median() function on
# every value. Then we sort the values descending.
median_annual_income_per_region = df.groupby("region")["annual_income"].median().sort_values(ascending=False)
median_annual_income_per_region.name = "median_annual_income"
print(median_annual_income_per_region)


"""
    To do a better comparison of the average and median annual income per region, we combine the two Series into a
     DataFrame.
"""
comparison_avg_median_annual_income = pd.concat(
    [avg_annual_income_per_region, median_annual_income_per_region], axis=1
)
print(comparison_avg_median_annual_income)


"""
    Demographic analysis: In this part we look at the users demographic.
"""


"""
    How many users are from each region?  
    We see, that meanwhile the user count from north, south and west is pretty much the same, there are only 2.5% of 
    the users coming from the east.
    This could be a topic of further analysis, if more information is provided.
    Further we can question, if the data is really representative, especially for the east.
"""

# Computing the user count per region.
users_per_region = df.groupby("region")["user_id"].count()
users_per_region.name = "users"
total_user_count = df["user_id"].count()

# Computing the percentage of the users.
users_per_region_percent = round((users_per_region / total_user_count) * 100, 2)
users_per_region_percent.name = "users_percent"

# Combining the two Series into one DataFrame.
df_users_per_region = pd.concat([users_per_region, users_per_region_percent], axis=1)
print(df_users_per_region)


"""
    What is the users age demographics? 
    We have an age range from 22 to 55. The age demographic varies from young adults to middle-aged users. 
    There is a 4 year gap between the youngest age in the dataset and a user who has just become an adult 
    (ages 18 - 21 are missing). 
    There are no purchases coming from older age demographics (age > 60), which implies, that the products are not 
    interesting for this age group or, that the purchasing process might be to difficult for this age group.
"""

# Computing the user count per age.
users_per_age = df.groupby("age")["user_id"].count()
users_per_age.name = "users"
total_user_count = df["user_id"].count()

# Computing the percentage of the users per age.
users_per_age_percent = round((users_per_age / total_user_count) * 100, 2)
users_per_age_percent.name = "users_percent"

# Combining the two Series into one DataFrame.
df_users_per_age = pd.concat([users_per_age, users_per_age_percent], axis=1)
print(df_users_per_age)


"""
    What ages have the highest user count?
    We see, there are big groups of users in the young adults age group and the middle-age age group.
"""
print(df_users_per_age[df_users_per_age["users"] == df_users_per_age["users"].max()])
