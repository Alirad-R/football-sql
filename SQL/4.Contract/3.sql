select
	t.team_id,
    t.name,
	s.id,
    s.name,
    s.role,
    wf.contract_draft_time,
    wf.contract_termination_date,
    wf.contract_period,
    wf.contract_amount
from
	staff s
join
	works_for wf on s.id = wf.staff_id
join
	team t on t.team_id = wf.team_id
where contract_termination_date > '2020-01-01' and contract_termination_date < '2023-01-01'