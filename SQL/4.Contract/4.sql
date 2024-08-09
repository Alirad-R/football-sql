select
	t.team_id,
    t.name,
    sum(pf.contract_amount) as overall_contracts
from
	team t
join
	plays_for pf on t.team_id = pf.team_id
where
	pf.contract_termination_date > current_date() and pf.contract_draft_time < current_date()
group by
	t.team_id,
    t.name