DELIMITER / / CREATE PROCEDURE AddNewMatch (
    IN home_team INT,
    IN home_team_lineup varchar(20),
    IN away_team INT,
    IN away_team_lineup varchar(20),
    IN league INT
) BEGIN
-- Insert the new match into the matches table (if needed)
INSERT INTO
    football_project.matches (
        home_team_id,
        away_team_id,
        result,
        lineup_home,
        lineup_away,
        match_date_time
    )
VALUES
    (
        home_team,
        away_team,
        league,
        '0-0',
        home_team_lineup,
        away_team_lineup,
        NOW ()
    );

-- Print the new match ID
SELECT
    LAST_INSERT_ID () AS new_match_id;

END / / DELIMITER;