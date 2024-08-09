import os
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Print the current working directory
print("Current working directory:", os.getcwd())

# Load the staff and team data
staff_df = pd.read_csv('data_set/staff.csv')
team_df = pd.read_csv('data_set/team.csv')

# Split staff into coaches and other roles
coaches_df = staff_df[staff_df['role'] == 'Coach']
other_staff_df = staff_df[staff_df['role'] != 'Coach']

# Initialize the works_for dataframe
works_for_df = pd.DataFrame(columns=['team_id', 'staff_id', 'contract_date', 'contract_termination_date', 'contract_period', 'contract_amount'])

# Function to generate contract details
def generate_contract_details(num_entries):
    contract_amounts = np.random.randint(30000, 150000, num_entries)
    contract_dates = [datetime.now() - timedelta(days=random.randint(0, 365*5)) for _ in range(num_entries)]
    contract_periods = [random.randint(1, 5) for _ in range(num_entries)]
    contract_termination_dates = [contract_dates[i] + timedelta(days=365*contract_periods[i]) for i in range(num_entries)]
    return contract_amounts, contract_dates, contract_termination_dates, contract_periods

# Assign one coach to each team
for team_id in team_df['team_id']:
    if not coaches_df.empty:
        coach = coaches_df.sample(1)
        coaches_df = coaches_df.drop(coach.index)

        contract_amount, contract_date, contract_termination_date, contract_period = generate_contract_details(1)

        works_for_df = pd.concat([works_for_df, pd.DataFrame({
            'team_id': [team_id],
            'staff_id': [coach['id'].values[0]],
            'contract_date': [contract_date[0].strftime('%Y-%m-%d')],
            'contract_termination_date': [contract_termination_date[0].strftime('%Y-%m-%d')],
            'contract_period': [contract_period[0]],
            'contract_amount': [contract_amount[0]]
        })], ignore_index=True)

# Assign up to three other staff members to each team
for team_id in team_df['team_id']:
    if not other_staff_df.empty:
        other_staff = other_staff_df.sample(min(3, len(other_staff_df)))
        other_staff_df = other_staff_df.drop(other_staff.index)

        contract_amounts, contract_dates, contract_termination_dates, contract_periods = generate_contract_details(len(other_staff))

        for i in range(len(other_staff)):
            works_for_df = pd.concat([works_for_df, pd.DataFrame({
                'team_id': [team_id],
                'staff_id': [other_staff['id'].values[i]],
                'contract_date': [contract_dates[i].strftime('%Y-%m-%d')],
                'contract_termination_date': [contract_termination_dates[i].strftime('%Y-%m-%d')],
                'contract_period': [contract_periods[i]],
                'contract_amount': [contract_amounts[i]]
            })], ignore_index=True)

# Save the works_for dataframe to a CSV file
works_for_df.to_csv('works_for.csv', index=False)
