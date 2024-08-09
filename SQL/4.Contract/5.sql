select
	t.team_id,
    t.name,
    sum(wf.contract_amount) as overall_contracts
from
	team t
join
	works_for wf on t.team_id = wf.team_id
where
	wf.contract_termination_date > current_date() and wf.contract_draft_time < current_date()
group by
	t.team_id,
    t.name