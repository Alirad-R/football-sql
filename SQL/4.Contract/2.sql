SELECT
    p.id AS player_id,
    p.name AS player_name,
    p.age,
    p.address,
    p.current_shirt_no,
    p.injury,
    p.player_overall_score,
    p.goals,
    p.fouls,
    p.most_played_position,
    p.red_cards,
    p.yellow_cards,
    pf.contract_draft_time,
    pf.contract_termination_date,
    pf.contract_period,
    pf.contract_amount,
    pt.contract_draft_date as new_contract,
    nt.team_id AS new_team_id,
    nt.name AS new_team_name,
    ot.team_id AS old_team_id,
    ot.name AS old_team_name
FROM
    player p
LEFT JOIN
    plays_for pf ON pf.player_ssn = p.id
LEFT JOIN
    player_transfer pt ON pt.player_ssn = p.id
LEFT JOIN 
    team nt ON (pt.team_id = nt.team_id OR pf.team_id = nt.team_id)
LEFT JOIN
    team ot ON pt.prev_team_id = ot.team_id
where pf.contract_termination_date > '2020-01-01' AND pf.contract_termination_date < CURRENT_DATE();