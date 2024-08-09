select
	g.team_id,
    go.team_id as Opponent_team_id,
    t.name as team_name,
    top.name as op_team_name,
    tl.week_of_league,
    m.result,
    case
		when g.team_id = m.home_team_id then substring_index(m.result, '-',1)
        else substring_index(m.result, '-', -1)
	end as goals_scored,
    case
		when g.team_id = m.home_team_id then substring_index(m.result, '-', -1)
        else substring_index(m.result, '-',1)
	end as goals_received,
    sum(pig.fouls) as fouls,
    sum(pig.yellow_cards) as yellow_cards,
    sum(pig.red_cards) as red_cards,
    case
		when g.team_id = m.home_team_id then m.lineup_home
        else m.lineup_away
	end as lineup
from
	game g
left join 
	game go on g.match_id = go.match_id and g.team_id != go.team_id
left join
	team t on g.team_id = t.team_id
left join
	team top on go.team_id = top.team_id
join
	player_in_game pig on g.player_id = pig.id
join
	matches m on g.match_id = m.match_id
join
	team_league tl on tl.league_id = g.league_id
group by
	g.team_id,
    go.team_id,
    t.name,
    top.name,
    m.result,
    g.match_id,
    m.home_team_id,
    m.away_team_id,
    m.lineup_home,
    m.lineup_away,
    tl.week_of_league;
	
    
