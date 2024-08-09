select g.g_id, g.match_id, t.team_id, p.id, t.name, p.name, g.foul_time, g.foul_type
from game g
join team t on t.team_id = g.team_id
join player_in_game pig on pig.id = g.player_id
join player p on pig.id = p.id
where pig.fouls > 0 and g.foul_time IS NOT NULL