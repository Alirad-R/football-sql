select
	s.id,
    s.name,
    wf.contract_draft_time as contract_date,
    wf.contract_termination_date,
    wf.contract_period,
    wf.contract_amount,
    count(g.match_id) as matches,
    sum(pig.fouls) as fouls,
    sum(case
		when g.team_id = m.home_team_id then cast(substring_index(m.result, '-',1) as unsigned)
        else cast(substring_index(m.result, '-', -1) as unsigned)
	end) as goals
from
	staff s
join
	works_for wf on s.id = wf.staff_id
join
	team t on t.team_id = wf.team_id
join
	game g on g.team_id = t.team_id
join
	matches m on g.match_id = m.match_id
join
	player_in_game pig ON g.player_id = pig.id
where
	s.role = 'Coach'
group by
	s.id,
    s.name,
    wf.contract_draft_time,
    wf.contract_termination_date,
    wf.contract_period,
    wf.contract_amount;