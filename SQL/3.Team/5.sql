select
	*
from
	staff s
join
	works_for wf on wf.staff_id = s.id
join
	team t on wf.team_id = t.team_id
where s.role != 'Coach' and wf.contract_termination_date > current_date()
order by
	t.team_id