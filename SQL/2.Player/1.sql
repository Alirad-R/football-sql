SELECT 
    p.id, 
    p.name AS player_name, 
    t.name AS team_name, 
    pf.contract_draft_time, 
    pf.contract_termination_date, 
    pf.contract_amount, 
    COALESCE(mp.matches_played, 0) AS matches_played,
    COALESCE(mp.goals_scored, 0) AS goals_scored,
    COALESCE(mp.fouls, 0) AS fouls,
    COALESCE(mp.yellow_cards, 0) AS yellow_cards,
    COALESCE(mp.red_cards, 0) AS red_cards,
    COALESCE(mp.player_score, 0) AS plyer_score,
    COALESCE(mp.subbed_out_games, 0) AS subbed_out_games
FROM 
    player p
JOIN 
    plays_for pf ON p.id = pf.player_ssn
JOIN 
    team t ON t.team_id = pf.team_id
LEFT JOIN (
    SELECT 
        pig.id AS player_id, 
        COUNT(g.match_id) AS matches_played,
        SUM(pig.goals) AS goals_scored,
        SUM(pig.fouls) AS fouls,
        SUM(pig.yellow_cards) AS yellow_cards,
        SUM(pig.red_cards) AS red_cards,
        AVG(pig.player_score) AS player_score,
        COUNT(CASE WHEN g.sub_out > 0 AND pig.is_main_lineup > 0 THEN 1 END) AS subbed_out_games
    FROM 
        player_in_game pig
    JOIN 
        game g ON pig.id = g.player_id
    GROUP BY 
        pig.id
) AS mp ON mp.player_id = p.id;
