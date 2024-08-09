SELECT
	p.id,
    p.name AS player_name,
    t.name AS team_name,
    g.league_id
FROM
    player p
JOIN
    player_in_game pig ON p.id = pig.id
JOIN
    game g ON g.player_id = pig.id
JOIN
    team t ON t.team_id = g.team_id
JOIN
	matches m on g.match_id = m.match_id
WHERE
    pig.red_cards >= 1
GROUP BY
	p.id,
    p.name,
    t.name,
    g.league_id
HAVING
    SUM(pig.yellow_cards) % 3 = 0
    OR MAX(m.match_date_time) <= NOW();
