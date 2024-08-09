import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Load the provided datasets
players_df = pd.read_csv('data_set/players.csv')
plays_for_df = pd.read_csv('data_set/plays_for.csv')
team_df = pd.read_csv('data_set/team.csv')

# Define age restrictions
age_restrictions = {
    "Bartar": (17, 30),
    "Daste aval": (17, 30),
    "Daste dovom": (17, 30),
    "Omid": (13, 17),
    "Javanan": (10, 13)
}

# Assign league types to teams
team_df['league_type'] = ['Bartar'] * 15 + ['Daste aval'] * 10 + ['Daste dovom'] * 7 + ['Omid'] * 25 + ['Javanan'] * 25

# Initialize the player_transfer dataframe
player_transfer_df = pd.DataFrame(columns=['player_id', 'team_id', 'contract_termination_date', 'contract_date', 'prev_team_id'])

# Function to generate a random date within the last 5 years
def generate_random_date():
    end_date = datetime.now()
    start_date = end_date - timedelta(days=365*5)
    return start_date + (end_date - start_date) * np.random.rand()

# Ensure each team does not have less than 11 players at any time
for team_id in team_df['team_id']:
    league_type = team_df.loc[team_df['team_id'] == team_id, 'league_type'].values[0]
    min_age, max_age = age_restrictions[league_type]
    
    # Get current players for the team
    current_players = plays_for_df[plays_for_df['team_id'] == team_id]
    
    if len(current_players) > 11:
        # Choose a random number of players to transfer (max 5)
        num_transfers = np.random.randint(1, min(6, len(current_players)-10))
        
        for _ in range(num_transfers):
            player = current_players.sample(1)
            player_id = player['player_id'].values[0]
            prev_team_id = team_id
            
            # Choose a new team for the player
            new_team = team_df[(team_df['league_type'] == league_type) & (team_df['team_id'] != team_id)].sample(1)
            new_team_id = new_team['team_id'].values[0]
            
            # Generate contract dates
            contract_termination_date = generate_random_date()
            contract_date = contract_termination_date + timedelta(days=np.random.randint(1, 365))
            
            # Create a new row for the transfer
            new_transfer = pd.DataFrame({
                'player_id': [player_id],
                'team_id': [new_team_id],
                'contract_termination_date': [contract_termination_date.strftime('%Y-%m-%d')],
                'contract_date': [contract_date.strftime('%Y-%m-%d')],
                'prev_team_id': [prev_team_id]
            })
            
            # Concatenate the new transfer to the player_transfer_df
            player_transfer_df = pd.concat([player_transfer_df, new_transfer], ignore_index=True)
            
            # Update the plays_for_df to reflect the transfer
            plays_for_df = plays_for_df[plays_for_df['player_id'] != player_id]
            plays_for_df = pd.concat([plays_for_df, pd.DataFrame({'player_id': [player_id], 'team_id': [new_team_id]})], ignore_index=True)

# Save the player_transfer dataframe to a CSV file
player_transfer_df.to_csv('player_transfer.csv', index=False)
