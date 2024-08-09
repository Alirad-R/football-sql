select t.team_id, g.match_id, g.g_id, pig.id, p.name, t.name, g.sub_in, g.sub_out, g.sub_time
from game g
join team t on g.team_id = t.team_id
join player_in_game pig on pig.id = g.player_id
join player p on pig.id = p.id
where sub_time IS NOT NULL