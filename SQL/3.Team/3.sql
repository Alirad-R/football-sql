select
	*
from
	player p
join
	plays_for pf on p.id = pf.player_ssn
join
	team t on t.team_id = pf.team_id
where pf.contract_termination_date > current_date()