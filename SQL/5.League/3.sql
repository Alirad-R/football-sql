select
	p.name as player_name,
    p.id as player_id,
    g.league_id,
    t.name as team_name,
    count(g.match_id) as games_played,
    sum(pig.goals) as goals_scored,
    sum(pig.fouls) as fouls,
    sum(pig.yellow_cards) as yellow_cards,
    sum(pig.red_cards) as red_cards,
    avg(pig.player_score) as player_rating
from
	player p
join
	player_in_game pig on p.id = pig.id
join
	game g on g.player_id = pig.id
join
	team t on t.team_id = g.team_id
group by
	p.id,
    g.league_id,
    t.name