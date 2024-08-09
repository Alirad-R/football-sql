SELECT 
    t.team_id, 
    t.name, 
    g.match_id,
    SUM(pig.goals) AS goals_scored, 
    CASE 
        WHEN t.team_id = m.home_team_id THEN SUBSTRING_INDEX(m.result, '-', -1)
        ELSE SUBSTRING_INDEX(m.result, '-', 1)
    END AS goals_received, 
    SUM(pig.fouls) AS fouls, 
    SUM(pig.yellow_cards) AS yellow_cards, 
    SUM(pig.red_cards) AS red_cards,
    CASE 
        WHEN t.team_id = m.home_team_id THEN m.lineup_home
        ELSE m.lineup_away
    END AS lineup
FROM 
    game g
JOIN 
    player_in_game pig ON g.player_id = pig.id
JOIN 
    team t ON t.team_id = g.team_id
JOIN 
    matches m ON m.match_id = g.match_id
GROUP BY 
    g.team_id, g.player_id, g.match_id;
