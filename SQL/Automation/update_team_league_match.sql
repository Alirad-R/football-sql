DELIMITER / / CREATE PROCEDURE UpdateTeamLeagueStats (IN matchId INT) BEGIN DECLARE home_team_id INT;

DECLARE away_team_id INT;

DECLARE home_goals INT;

DECLARE away_goals INT;

-- Get match details
SELECT
    home_team_id,
    away_team_id,
    SUBSTRING_INDEX (result, '-', 1) AS home_goals,
    SUBSTRING_INDEX (result, '-', -1) AS away_goals INTO home_team_id,
    away_team_id,
    home_goals,
    away_goals
FROM
    football_project.matches
WHERE
    match_id = matchId;

-- Update home team statistics
UPDATE football_project.team_league
SET
    goals_scored = goals_scored + home_goals,
    goals_received = goals_received + away_goals,
    games_played = games_played + 1,
    win = win + IF (home_goals > away_goals, 1, 0),
    draw = draw + IF (home_goals = away_goals, 1, 0),
    loss = loss + IF (home_goals < away_goals, 1, 0),
    points = points + IF (
        home_goals > away_goals,
        3,
        IF (home_goals = away_goals, 1, 0)
    )
WHERE
    team_id = home_team_id;

-- Update away team statistics
UPDATE football_project.team_league
SET
    goals_scored = goals_scored + away_goals,
    goals_received = goals_received + home_goals,
    games_played = games_played + 1,
    win = win + IF (away_goals > home_goals, 1, 0),
    draw = draw + IF (away_goals = home_goals, 1, 0),
    loss = loss + IF (away_goals < home_goals, 1, 0),
    points = points + IF (
        away_goals > home_goals,
        3,
        IF (away_goals = home_goals, 1, 0)
    )
WHERE
    team_id = away_team_id;

END / / DELIMITER;