select
	l.league_id,
    l.name as league_name,
    t.name as home_team_name,
    top.name as away_team_name,
    m.result,
    m.match_date_time,
    sta.id as stadium_id,
    sta.name as stadium_name,
    sta.city,
	count(spec.id) as amount_of_spectators,
    -- ms.amount_of_spectators,
    sum(tic.price) as total_revenue,
    r.id as referee_observer_id,
    r.name as referee_observer_name,
    r.role
from
	game g
join
	league l on l.league_id = g.league_id
join
	team t on t.team_id = g.team_id
join
	matches m on m.match_id = g.match_id
join
	match_stadium ms on ms.match_id = m.match_id
join
	stadium sta on sta.id = ms.stadium_id
join
	ticket_soldby_stadium tss on tss.stadium_id = sta.id
join
	ticket tic on tic.ticket_number = tss.ticket_no
join
	spectator spec on spec.ticket_no = tic.ticket_number
join
	match_referee mr on mr.match_id = m.match_id
join
	referee_observer r on r.id = mr.ref_id
join
	team top on top.team_id = m.away_team_id
group by
	l.league_id,
    l.name,
    t.name,
    top.name,
    m.result,
    m.match_date_time,
    sta.id,
    sta.name,
    sta.city,
    r.id,
    r.name,
    r.role
    -- ms.amount_of_spectators; 
