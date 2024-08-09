select t.team_id, g.g_id,  t.name, g.match_id, g.player_id, g.goal_time
from game g
join team t on t.team_id = g.team_id
join player_in_game pig on pig.id = g.player_id
where pig.goals > 0