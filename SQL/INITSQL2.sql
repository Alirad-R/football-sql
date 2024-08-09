CREATE SCHEMA football_project;

CREATE TABLE
	football_project.league (
		league_id int NOT NULL,
		name varchar(100) NOT NULL,
		champion varchar(100),
		season varchar(10) NOT NULL,
		league_type varchar(20) NOT NULL,
		top_scorrer varchar(100) NOT NULL,
		top_assister varchar(100) NOT NULL,
		best_keeper varchar(100) NOT NULL,
		CONSTRAINT pk_league_name PRIMARY KEY (name, league_id),
		CONSTRAINT unq_league_league_id UNIQUE (league_id)
	) engine = InnoDB;

ALTER TABLE football_project.league COMMENT 'leagues of the football';

ALTER TABLE football_project.league MODIFY champion varchar(100) COMMENT 'the team who got first in the league';

-- CREATE TABLE football_project.`match` ( 
-- 	match_id             int  NOT NULL    PRIMARY KEY,
-- 	injured              varchar(100)      ,
-- 	cards_yellow         int      ,
-- 	cards_red            int      ,
-- 	fouls                int   DEFAULT 0   ,
-- 	match_date_time      datetime      ,
-- 	home_team_id         int  NOT NULL    ,
-- 	away_team_id         int  NOT NULL    ,
-- 	result               varchar(20)  NOT NULL DEFAULT '0-0'   ,
-- 	lineup_home          varchar(20)  NOT NULL    ,
-- 	lineup_away          varchar(20)  NOT NULL    
--  ) engine=InnoDB;
-- ALTER TABLE football_project.`match` COMMENT 'descriptions about a match';
-- ALTER TABLE football_project.`match` MODIFY injured varchar(100)     COMMENT 'names of players who got injured in a match';
-- ALTER TABLE football_project.`match` MODIFY cards_yellow int     COMMENT 'amount of yellow cards given in the match';
-- ALTER TABLE football_project.`match` MODIFY cards_red int     COMMENT 'amount of red cards given in the match';
-- ALTER TABLE football_project.`match` MODIFY fouls int   DEFAULT 0  COMMENT 'amount of fouls in the match';
-- ALTER TABLE football_project.`match` MODIFY result varchar(20)  NOT NULL DEFAULT '0-0'  COMMENT 'written in this format\nhome_team_result - away_team_result';
CREATE TABLE
	football_project.matches (
		match_id int NOT NULL PRIMARY KEY,
		injured varchar(100),
		cards_yellow int,
		cards_red int,
		fouls int DEFAULT 0,
		match_date_time datetime,
		home_team_id int NOT NULL,
		away_team_id int NOT NULL,
		result varchar(20) NOT NULL DEFAULT '0-0',
		lineup_home varchar(20) NOT NULL,
		lineup_away varchar(20) NOT NULL
	);

ALTER TABLE football_project.matches COMMENT 'descriptions about a match';

ALTER TABLE football_project.matches MODIFY injured varchar(100) COMMENT 'names of players who got injured in a match';

ALTER TABLE football_project.matches MODIFY cards_yellow int COMMENT 'amount of yellow cards given in the match';

ALTER TABLE football_project.matches MODIFY cards_red int COMMENT 'amount of red cards given in the match';

ALTER TABLE football_project.matches MODIFY fouls int DEFAULT 0 COMMENT 'amount of fouls in the match';

ALTER TABLE football_project.matches MODIFY result varchar(20) NOT NULL DEFAULT '0-0' COMMENT 'written in this format\nhome_team_result - away_team_result';

CREATE TABLE
	football_project.player (
		id int NOT NULL PRIMARY KEY,
		name varchar(100) NOT NULL,
		age int NOT NULL,
		address varchar(100),
		current_shirt_no int NOT NULL,
		injury int NOT NULL DEFAULT 0,
		total_time_played int NOT NULL DEFAULT 0,
		player_overall_score float (4, 2) NOT NULL DEFAULT 0,
		goals int NOT NULL DEFAULT 0,
		fouls int NOT NULL DEFAULT 0,
		most_played_position varchar(100) NOT NULL,
		red_cards int NOT NULL DEFAULT 0,
		yellow_cards int NOT NULL DEFAULT 0
	) engine = InnoDB;

ALTER TABLE football_project.player MODIFY current_shirt_no int NOT NULL COMMENT 'this could change for a player and will be distinguishable in the play relation';

ALTER TABLE football_project.player MODIFY injury int NOT NULL DEFAULT 0 COMMENT 'how many injuries a player has had in their career';

ALTER TABLE football_project.player MODIFY total_time_played int NOT NULL DEFAULT 0 COMMENT 'total time played in the player''s career';

ALTER TABLE football_project.player MODIFY most_played_position varchar(100) NOT NULL COMMENT 'a position for a player can change accordingly. we will just get their most played position.';

CREATE TABLE
	football_project.player_in_game (
		id int NOT NULL PRIMARY KEY,
		shirt_no int NOT NULL,
		position varchar(100),
		played boolean NOT NULL DEFAULT false,
		yellow_cards int NOT NULL DEFAULT 0,
		red_cards int NOT NULL DEFAULT 0,
		fouls int NOT NULL DEFAULT 0,
		goals int NOT NULL DEFAULT 0,
		player_score float (4, 2) NOT NULL,
		time_played int NOT NULL DEFAULT 0,
		injury boolean NOT NULL DEFAULT false,
		is_main_lineup boolean NOT NULL
	) engine = InnoDB;

ALTER TABLE football_project.player_in_game COMMENT 'attributes of a player in a single game';

ALTER TABLE football_project.player_in_game MODIFY time_played int NOT NULL DEFAULT 0 COMMENT 'in minutes';

CREATE TABLE
	football_project.referee_observer (
		id int NOT NULL PRIMARY KEY,
		name varchar(100) NOT NULL,
		date_of_birth date,
		address varchar(100),
		role varchar(30) NOT NULL
	) engine = InnoDB;

ALTER TABLE football_project.referee_observer MODIFY role varchar(30) NOT NULL COMMENT 'either a referee or an observer';

CREATE TABLE
	football_project.stadium (
		id int NOT NULL PRIMARY KEY,
		name varchar(100) NOT NULL,
		capacity int,
		stadium_type varchar(100),
		city varchar(100)
	) engine = InnoDB;

CREATE TABLE
	football_project.staff (
		id int NOT NULL PRIMARY KEY,
		name varchar(100) NOT NULL,
		date_of_birth date,
		address varchar(100),
		role varchar(50) NOT NULL
	) engine = InnoDB;

ALTER TABLE football_project.staff COMMENT 'includes technical comittee and coaches';

CREATE TABLE
	football_project.team (
		team_id int NOT NULL PRIMARY KEY,
		name varchar(100) NOT NULL
	) engine = InnoDB;

ALTER TABLE football_project.team MODIFY team_id int NOT NULL COMMENT 'this is the id of the team which differes for each team. this will make computations easier';

ALTER TABLE football_project.team MODIFY name varchar(100) NOT NULL COMMENT 'this is the name of the team';

CREATE TABLE
	football_project.team_league (
		league_id int NOT NULL,
		team_id int NOT NULL,
		win int NOT NULL DEFAULT 0,
		draw int NOT NULL DEFAULT 0,
		loss int NOT NULL DEFAULT 0,
		games_played int NOT NULL DEFAULT 1,
		place int NOT NULL,
		points int NOT NULL DEFAULT 0,
		goals_scored int NOT NULL DEFAULT 0,
		goals_received int NOT NULL DEFAULT 0,
		week_of_league int NOT NULL,
		yellow_cards int NOT NULL DEFAULT 0,
		red_cards int NOT NULL DEFAULT 0,
		CONSTRAINT pk_team_league_league_id PRIMARY KEY (league_id, team_id)
	) engine = InnoDB;

CREATE INDEX fk_team_league_team ON football_project.team_league (team_id);

ALTER TABLE football_project.team_league COMMENT 'this is the relation that connects each team to their league specifying their stats in that league';

ALTER TABLE football_project.team_league MODIFY win int NOT NULL DEFAULT 0 COMMENT 'amount of wins for a single team';

ALTER TABLE football_project.team_league MODIFY draw int NOT NULL DEFAULT 0 COMMENT 'amount of games drawed for a single team.';

ALTER TABLE football_project.team_league MODIFY loss int NOT NULL DEFAULT 0 COMMENT 'amount of losses for a single team';

ALTER TABLE football_project.team_league MODIFY games_played int NOT NULL DEFAULT 1 COMMENT 'amount of games played by a single team';

ALTER TABLE football_project.team_league MODIFY place int NOT NULL COMMENT 'the place of the team on the leaderboard for the league';

ALTER TABLE football_project.team_league MODIFY points int NOT NULL DEFAULT 0 COMMENT 'this will be evaluated by the amount of wins, losses and draws for a single team in that league';

ALTER TABLE football_project.team_league MODIFY goals_scored int NOT NULL DEFAULT 0 COMMENT 'amount of goals made by a team in a league';

CREATE TABLE
	football_project.ticket (
		ticket_number int NOT NULL PRIMARY KEY,
		ticket_type varchar(100),
		price int
	) engine = InnoDB;

CREATE TABLE
	football_project.ticket_soldby_stadium (
		ticket_no int NOT NULL,
		stadium_id int NOT NULL,
		CONSTRAINT pk_ticket_soldby_stadium_ticket_no PRIMARY KEY (ticket_no, stadium_id)
	) engine = InnoDB;

CREATE INDEX fk_ticket_soldby_stadium_stadium ON football_project.ticket_soldby_stadium (stadium_id);

CREATE TABLE
	football_project.works_for (
		team_id int NOT NULL,
		staff_id int NOT NULL,
		contract_period int,
		contract_draft_time datetime,
		contract_amount int,
		contract_termination_date date NOT NULL,
		CONSTRAINT pk_works_for_team_id PRIMARY KEY (team_id, staff_id)
	) engine = InnoDB;

CREATE INDEX fk_works_for_staff ON football_project.works_for (staff_id);

ALTER TABLE football_project.works_for COMMENT 'details of contract between team staff and team';

ALTER TABLE football_project.works_for MODIFY contract_period int COMMENT 'in months';

ALTER TABLE football_project.works_for MODIFY contract_amount int COMMENT 'in dollars';

CREATE TABLE
	football_project.game (
		team_id int NOT NULL,
		match_id int NOT NULL,
		player_id int NOT NULL,
		league_id int NOT NULL,
		g_id int NOT NULL,
		sub_in boolean DEFAULT false,
		sub_out boolean DEFAULT false,
		sub_time int,
		goal_time int,
		foul_time int,
		foul_type varchar(20),
		CONSTRAINT unq_game_match_id UNIQUE (match_id),
		CONSTRAINT unq_game_player_id UNIQUE (player_id),
		CONSTRAINT pk_game_team_id PRIMARY KEY (team_id, match_id, player_id, league_id, g_id)
	) engine = InnoDB;

CREATE INDEX fk_game_league ON football_project.game (league_id);

ALTER TABLE football_project.game COMMENT 'game played that connects match and player and team';

ALTER TABLE football_project.game MODIFY sub_in boolean DEFAULT false COMMENT 'if player has been subbed in or not';

ALTER TABLE football_project.game MODIFY sub_out boolean DEFAULT false COMMENT 'if player has been subbed out';

ALTER TABLE football_project.game MODIFY sub_time int COMMENT 'time of sub';

CREATE TABLE
	football_project.match_referee (
		match_id int NOT NULL,
		ref_id int NOT NULL,
		details mediumtext,
		game_rating int NOT NULL,
		game_home_result int NOT NULL DEFAULT 0,
		game_away_result int NOT NULL DEFAULT 0,
		CONSTRAINT `pk_match/referee_match_id` PRIMARY KEY (match_id, ref_id)
	) engine = InnoDB;

CREATE INDEX `fk_match/referee_referee/observer` ON football_project.match_referee (ref_id);

ALTER TABLE football_project.match_referee COMMENT 'details of match described by referee or observer';

ALTER TABLE football_project.match_referee MODIFY game_rating int NOT NULL COMMENT 'out of 100';

CREATE TABLE
	football_project.match_stadium (
		amount_of_spectators int,
		stadium_id int NOT NULL,
		match_id int NOT NULL,
		CONSTRAINT `pk_match/stadium_stadium_id` PRIMARY KEY (stadium_id, match_id)
	) engine = InnoDB;

CREATE INDEX `fk_match/stadium_match` ON football_project.match_stadium (match_id);

ALTER TABLE football_project.match_stadium COMMENT 'details about a match which is played in a stadium';

CREATE TABLE
	football_project.player_transfer (
		player_ssn int NOT NULL,
		team_id int NOT NULL,
		contranct_termination_date date NOT NULL,
		contract_draft_date date NOT NULL,
		prev_team_id int NOT NULL,
		CONSTRAINT pk_player_transfer PRIMARY KEY (player_ssn, team_id)
	) engine = InnoDB;

CREATE INDEX fk_player_transfer_to_team ON football_project.player_transfer (team_id);

CREATE TABLE
	football_project.plays_for (
		team_id int NOT NULL,
		player_ssn int NOT NULL,
		contract_amount int NOT NULL,
		contract_draft_time timestamp NOT NULL,
		contract_termination_date date NOT NULL,
		contract_period int,
		CONSTRAINT pk_plays_for_team_id PRIMARY KEY (team_id, player_ssn)
	) engine = InnoDB;

CREATE INDEX fk_player_plays_for ON football_project.plays_for (player_ssn);

ALTER TABLE football_project.plays_for COMMENT 'date and time and amount of contracts made between team and player';

CREATE TABLE
	football_project.spectator (
		id int NOT NULL,
		ticket_no int NOT NULL,
		name varchar(100),
		date_of_birth date,
		age int,
		address varchar(100),
		CONSTRAINT pk_spectator_id PRIMARY KEY (id, ticket_no)
	) engine = InnoDB;

CREATE INDEX fk_spectator_ticket ON football_project.spectator (ticket_no);

ALTER TABLE football_project.game ADD CONSTRAINT fk_game_team FOREIGN KEY (team_id) REFERENCES football_project.team (team_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ALTER TABLE football_project.game ADD CONSTRAINT fk_game_match FOREIGN KEY ( match_id ) REFERENCES football_project.`match`( match_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE football_project.game ADD CONSTRAINT fk_game_player_in_game FOREIGN KEY (player_id) REFERENCES football_project.player_in_game (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.game ADD CONSTRAINT fk_game_league FOREIGN KEY (league_id) REFERENCES football_project.league (league_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.game ADD CONSTRAINT fk_game_matches FOREIGN KEY (match_id) REFERENCES football_project.matches (match_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ALTER TABLE football_project.match_referee ADD CONSTRAINT `fk_match/referee_match` FOREIGN KEY ( match_id ) REFERENCES football_project.`match`( match_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE football_project.match_referee ADD CONSTRAINT `fk_match/referee_referee/observer` FOREIGN KEY (ref_id) REFERENCES football_project.referee_observer (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.match_referee ADD CONSTRAINT fk_match_referee_matches FOREIGN KEY (match_id) REFERENCES football_project.matches (match_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.match_stadium ADD CONSTRAINT `fk_match/stadium_stadium` FOREIGN KEY (stadium_id) REFERENCES football_project.stadium (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ALTER TABLE football_project.match_stadium ADD CONSTRAINT `fk_match/stadium_match` FOREIGN KEY ( match_id ) REFERENCES football_project.`match`( match_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE football_project.match_stadium ADD CONSTRAINT fk_match_stadium_matches FOREIGN KEY (match_id) REFERENCES football_project.matches (match_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.player_in_game ADD CONSTRAINT fk_player_to_player_in_game FOREIGN KEY (id) REFERENCES football_project.player (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.player_transfer ADD CONSTRAINT fk_player_transfer_to_player FOREIGN KEY (player_ssn) REFERENCES football_project.player (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.player_transfer ADD CONSTRAINT fk_player_transfer_to_team FOREIGN KEY (team_id) REFERENCES football_project.team (team_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.plays_for ADD CONSTRAINT fk_plays_for_team FOREIGN KEY (team_id) REFERENCES football_project.team (team_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.plays_for ADD CONSTRAINT fk_player_plays_for FOREIGN KEY (player_ssn) REFERENCES football_project.player (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.spectator ADD CONSTRAINT fk_spectator_ticket FOREIGN KEY (ticket_no) REFERENCES football_project.ticket (ticket_number) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.team_league ADD CONSTRAINT fk_team_league_league FOREIGN KEY (league_id) REFERENCES football_project.league (league_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.team_league ADD CONSTRAINT fk_team_league_team FOREIGN KEY (team_id) REFERENCES football_project.team (team_id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.ticket_soldby_stadium ADD CONSTRAINT fk_ticket_soldby_stadium_ticket FOREIGN KEY (ticket_no) REFERENCES football_project.ticket (ticket_number) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.ticket_soldby_stadium ADD CONSTRAINT fk_ticket_soldby_stadium_stadium FOREIGN KEY (stadium_id) REFERENCES football_project.stadium (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.works_for ADD CONSTRAINT fk_works_for_staff FOREIGN KEY (staff_id) REFERENCES football_project.staff (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE football_project.works_for ADD CONSTRAINT fk_works_for_team FOREIGN KEY (team_id) REFERENCES football_project.team (team_id) ON DELETE NO ACTION ON UPDATE NO ACTION;