import numpy as np

# Generate mock data for the t20_matches table
np.random.seed(42)
years = list(range(2007, 2022, 2))
teams = ['India', 'Pakistan', 'Australia', 'England', 'South Africa', 'New Zealand', 'Sri Lanka', 'West Indies']
venues = ['Dubai', 'Sharjah', 'Melbourne', 'Lords', 'Eden Gardens', 'Wankhede', 'Adelaide', 'Sydney']
stages = ['Group', 'Semi Final', 'Final']

data = []
match_no = 1

for year in years:
    for _ in range(10):  # 10 matches per year for mock data
        team1, team2 = np.random.choice(teams, 2, replace=False)
        venue = np.random.choice(venues)
        stage = np.random.choice(stages, p=[0.7, 0.2, 0.1])
        score1 = np.random.randint(120, 220)
        score2 = np.random.randint(100, 200)
        if score1 > score2:
            winner, loser = team1, team2
            win_score, lose_score = score1, score2
        else:
            winner, loser = team2, team1
            win_score, lose_score = score2, score1
        player = np.random.choice(['Player A', 'Player B', 'Player C', 'Player D', 'Player E'])
        result = f"{winner} won by {abs(score1 - score2)} runs"

        data.append({
            "match_no": match_no,
            "date": f"{year}-{'%02d' % np.random.randint(1, 13)}-{'%02d' % np.random.randint(1, 29)}",
            "stage": stage,
            "match_between": f"{team1} vs {team2}",
            "venue": venue,
            "winning_team_score": win_score,
            "losing_team_score": lose_score,
            "winner_team": winner,
            "result": result,
            "player_of_the_match": player,
            "year": year
        })
        match_no += 1

# Create DataFrame
df_matches = pd.DataFrame(data)

# Save to Excel
file_path_with_data = "/mnt/data/t20_matches_data.xlsx"
df_matches.to_excel(file_path_with_data, index=False)

file_path_with_data
