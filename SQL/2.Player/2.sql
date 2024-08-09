select 
	pig.id,	
    g.league_id,
    g.team_id,
    t.name,
    p.name,
    sum(pig.time_played) as time_played,
    sum(pig.goals) as goals_scored,
    avg(pig.player_score) as player_score
from
	game g
join
	player_in_game pig on g.player_id = pig.id
join
	player p on p.id = pig.id
join
	team t on g.team_id = t.team_id
group by
	pig.id,
    g.league_id,
    g.team_id,
    t.name,
    p.name
    
-- SELECT 
--     pig.id AS player_id,
--     SUM(pig.time_played) AS time_played,
--     SUM(pig.goals) AS goals_scored,
--     AVG(pig.player_score) AS player_score,
--     GROUP_CONCAT(DISTINCT g.league_id) AS leagues,
--     GROUP_CONCAT(DISTINCT g.team_id) AS teams,
--     GROUP_CONCAT(DISTINCT t.name) AS team_names,
--     p.name AS player_name
-- FROM
--     game g
-- JOIN
--     player_in_game pig ON g.player_id = pig.id
-- JOIN
--     player p ON p.id = pig.id
-- JOIN
--     team t ON g.team_id = t.team_id
-- GROUP BY
--     pig.id;
