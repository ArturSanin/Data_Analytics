"""
    Project description:
"""
import pandas as pd


def df_report(file_path):
    """

    :param file_path: File Path to the csv file of the data.
    :return: Creates a full report on the Data.
    """
    # Getting the name of the file, by separating the file_path at / and getting the last string from the list
    # created by the methode split.
    split_list = file_path.split("/")
    file_name = split_list[len(split_list) - 1]
    print("This is a report on the dataset" + "\033[1m", file_name + ".", "\033[0m")

    # Saving the Dataset in a global variable df.
    global df
    df = pd.read_csv(file_path)
    print("The Dataset is stored in the variable" + "\033[1m" + " df" + "\033[0m" + ".")

    # Printing out the first 5 rows of the Dataset.
    print("To get a little overview on the data, here are the first 5 rows.")
    print(df.head())

    # Printing out the last 5 rows of the Dataset.
    print("Further here are the last 5 rows of the Data.")
    print(df.tail())

    # Printing information about the shape of the dataset.
    print(
        "============================== " + "\033[1m" + "Dataset Shape" + "\033[0m" + " ==============================")
    global df_number_rows, df_number_columns, df_number_entries, df_number_missing_entries
    df_number_rows = df.shape[0]
    df_number_columns = df.shape[1]
    df_number_entries = df.shape[0] * df.shape[1]
    df_number_missing_entries = df.isnull().sum().sum()
    print("The dataset has a total of:")
    print("   " + "\033[1m", df_number_rows,
          "rows." + "\033[0m" + " You can access on the number of rows through the variable " + "\033[1m" +
          "df_number_rows." + "\033[0m")
    print("   " + "\033[1m", df_number_columns,
          "columns." + "\033[0m" + " You can access on the number of columns through the variable " + "\033[1m" +
          "df_number_columns." + "\033[0m")
    print("   " + "\033[1m", df_number_entries,
          "entires." + "\033[0m" + " You can access on the number of entries through the variable " + "\033[1m" +
          "df_number_entries." + "\033[0m")
    print("   " + "\033[1m", df_number_missing_entries,
          "missing entries" + "\033[0m" +
          " (in the whole dataset). You can access on the number of missing entries through the variable " + "\033[1m" +
          "df_number_missing_entries." + "\033[0m")

    # Printing all column labels and the datatypes of the columns.
    print("============================== " + "\033[1m" + "Columns" + "\033[0m" + " ==============================")
    global df_all_columns
    df_all_columns = list(df.columns)
    print("The Dataset has the following", df_number_columns, "columns:\n" + "\033[1m", df_all_columns,
          "\033[0m\n" + "The column labels are stored as a python list in the variable " + "\033[1m" +
          "df_all_columns." + "\033[0m")
    print("The datatypes of the columns are:")
    for col in df_all_columns:
        print("   ", col, ":", str(df[col].dtype))

    # Printing all categorical columns, with all unique values for each column and there relative frequency.
    print(
        "============================== " + "\033[1m" + "Categorical Columns" + "\033[0m" +
        " ==============================")
    global df_categorical_columns
    df_categorical_columns = [column for column in df_all_columns if df[column].dtype == "object"]
    df_number_categorical_columns = len(df_categorical_columns)
    print("The Dataset has the following", df_number_categorical_columns, "categorical columns:\n" + "\033[1m",
          df_categorical_columns,
          "\033[0m\n" + "The categorical column labels are stored as a python list in the variable " + "\033[1m" +
          "df_categorical_columns." + "\033[0m")
    for categorical_column in df_categorical_columns:
        unique_values_in_column = list(df[categorical_column].unique())
        count_unique_values = len(unique_values_in_column)
        print("The column", "\033[1m" + categorical_column + "\033[0m", "has" + "\033[1m", count_unique_values,
              "\033[0m" + "unique values:\n" + "\033[1m", unique_values_in_column, "\033[0m")
        for unique_value in unique_values_in_column:
            count_unique_value = df.loc[df[categorical_column] == unique_value].shape[0]
            unique_value_relative_frequency = count_unique_value / df_number_rows
            unique_value_relative_frequency_percent = round(unique_value_relative_frequency * 100, 3)
            print("   The value" + "\033[1m", unique_value, "\033[0m" + "occurs" + "\033[1m", count_unique_value,
                  "\033[0m" + "times out of" + "\033[1m", df_number_rows,
                  "\033[0m." + " This is a relative frequency of" + "\033[1m",
                  unique_value_relative_frequency, "\033[0m" + "or" + "\033[1m",
                  unique_value_relative_frequency_percent,
                  "%." + "\033[0m")

    print(
        "============================== " + "\033[1m" + "Numerical Columns" + "\033[0m" +
        " ==============================")
    global df_numerical_columns
    df_numerical_columns = list(set(df_all_columns) - set(df_categorical_columns))
    df_number_numerical_columns = len(df_numerical_columns)
    df_only_numerical_columns = df[df_numerical_columns]
    df_correlations = df_only_numerical_columns.corr()
    print("The Dataset has the following", df_number_numerical_columns, "numerical columns:\n" + "\033[1m",
          df_numerical_columns,
          "\033[0m\n" + "The numerical column labels are stored as a python list in the variable " + "\033[1m" +
          "df_numerical_columns." + "\033[0m")
    # Printing summary statistics and correlations.
    for numerical_column in df_numerical_columns:
        df_removed_numerical_column = df_numerical_columns.copy()
        df_removed_numerical_column.remove(numerical_column)
        print("========== " + "\033[1m" + "Summary statistics of " + numerical_column + "\033[0m" + " ==========")
        print("The dataset has a total of" + "\033[1m", df.describe()[numerical_column].iloc[0],
              "non empty entries " + "\033[0m" + "in the column" + "\033[1m",
              numerical_column, "\033[0m")
        print("The column" + "\033[1m", numerical_column, "\033[0m" + "has a " + "\033[1m" + "mean of",
              round(df.describe()[numerical_column].iloc[1], 2), "\033[0m")
        print("The column" + "\033[1m", numerical_column, "\033[0m" + "has a standard deviation of" + "\033[1m",
              round(df.describe()[numerical_column].iloc[2], 2), "\033[0m")
        print("The " + "\033[1m" + "minimal value " + "\033[0m" + "of the column" + "\033[1m", numerical_column,
              "\033[0m" + "is" + "\033[1m", df.describe()[numerical_column].iloc[3], "\033[0m")
        print("The " + "\033[1m" + "25% percentile " + "\033[0m" "of column" + "\033[1m", numerical_column,
              "\033[0m" + "is" + "\033[1m", df.describe()[numerical_column].iloc[4],
              "\033[0m." + " This means, that 25% of the Data in the column" + "\033[1m", numerical_column,
              "\033[0m" + "is less than" + "\033[1m", df.describe()[numerical_column].iloc[4],
              "\033[0m" + "and 75% of the Data is over" + "\033[1m", df.describe()[numerical_column].iloc[4],
              "\033[0m" + ".")
        print("The " + "\033[1m" + "50% percentile " + "\033[0m" "of column" + "\033[1m", numerical_column,
              "\033[0m" + "is" + "\033[1m", df.describe()[numerical_column].iloc[5],
              "\033[0m." + " This means, that 50% of the Data in the column" + "\033[1m", numerical_column,
              "\033[0m" + "is less than" + "\033[1m", df.describe()[numerical_column].iloc[5],
              "\033[0m" + "and 50% of the Data is over" + "\033[1m", df.describe()[numerical_column].iloc[5],
              "\033[0m" + ".")
        print("The " + "\033[1m" + "75% percentile " + "\033[0m" "of column" + "\033[1m", numerical_column,
              "\033[0m" + "is" + "\033[1m", df.describe()[numerical_column].iloc[6],
              "\033[0m." + " This means, that 75% of the Data in the column" + "\033[1m", numerical_column,
              "\033[0m" + "is less than" + "\033[1m", df.describe()[numerical_column].iloc[6],
              "\033[0m" + "and 25% of the Data is over" + "\033[1m", df.describe()[numerical_column].iloc[6],
              "\033[0m" + ".")
        print("The " + "\033[1m" + "maximal value " + "\033[0m" + "of the column" + "\033[1m", numerical_column,
              "\033[0m" + "is" + "\033[1m", df.describe()[numerical_column].iloc[7], "\033[0m")
        for rest_numerical_column in df_removed_numerical_column:
            correlation = round(df_correlations[numerical_column][rest_numerical_column], 2)
            print("The column" + "\033[1m", numerical_column, "\033[0m" + "has a correlation of" + "\033[1m",
                  correlation, "\033[0m" + "with the column" + "\033[1m", rest_numerical_column, "\033[0m.")
