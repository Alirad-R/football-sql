select p.name, pig.id, g.team_id, g.match_id
from game g
join player_in_game pig on pig.id = g.player_id
join team t on t.team_id = g.team_id
join matches m on m.match_id = g.match_id
join player p on p.id = pig.id
where is_main_lineup = 1