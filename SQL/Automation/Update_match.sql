DELIMITER / / CREATE PROCEDURE UpdateMatchResult (IN matchId INT) BEGIN DECLARE home_goals INT;

DECLARE away_goals INT;

DECLARE home_team_id INT;

DECLARE away_team_id INT;

SELECT
    m.home_team_id,
    m.away_team_id,
    SUM(
        CASE
            WHEN g.team_id = m.home_team_id THEN pig.goals
            ELSE 0
        END
    ) AS home_goals,
    SUM(
        CASE
            WHEN g.team_id = m.away_team_id THEN pig.goals
            ELSE 0
        END
    ) AS away_goals INTO home_team_id,
    away_team_id,
    home_goals,
    away_goals
FROM
    football_project.match m
    JOIN football_project.game g ON m.match_id = g.match_id
    JOIN football_project.player_in_game pig ON g.g_id = pig.g_id
WHERE
    m.match_id = matchId
GROUP BY
    m.match_id;

-- Update match result
UPDATE football_project.`match`
SET
    result = CONCAT (home_goals, '-', away_goals)
WHERE
    match_id = matchId;

-- Also update the matches table if needed
UPDATE football_project.matches
SET
    result = CONCAT (home_goals, '-', away_goals)
WHERE
    match_id = matchId;

END / / DELIMITER;