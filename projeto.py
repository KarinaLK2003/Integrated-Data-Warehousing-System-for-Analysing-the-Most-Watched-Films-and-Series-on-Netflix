import pandas as pd
import numpy as np

titles = pd.read_csv('titles_new.csv',delimiter=',')
# print(titles)

import random
import datetime

# Number of rows in your dataframe
num_rows = len(titles)  # You can change this number as needed

# Generate random date values
random_dates = [datetime.date(
    random.randint(2000, 2024),
    random.randint(1, 12),
    random.randint(1, 28)
) for _ in range(num_rows)]

# Add a column with random date values
titles['date'] = random_dates

# Specify the file path where you want to save the Excel file
excel_file_path = 'titles_new_new.csv'

# Use the to_excel() method to save the DataFrame to Excel
titles.to_csv(excel_file_path, index=False)
print(titles)

