import pandas as pd
import numpy as np

# Load the staff data
staff_df = pd.read_csv('data_set/staff.csv')

# Function to generate a random date between 01.01.1950 and 01.01.2004
def generate_random_date(start, end):
    return (start + (end - start) * np.random.rand()).strftime('%Y-%m-%d')

# Define the date range
start_date = pd.to_datetime('1950-01-01')
end_date = pd.to_datetime('2004-01-01')

# Fill NULL values in date_of_birth with random dates
staff_df['date_of_birth'] = staff_df['date_of_birth'].apply(
    lambda x: generate_random_date(start_date, end_date) if pd.isnull(x) else x
)

# Save the corrected dataframe to a CSV file
staff_df.to_csv('corrected_staff.csv', index=False)
