CREATE DATABASE cricket_db;
USE cricket_db;



CREATE TABLE t20_matches (
    match_no INT,
    date DATE,
    stage VARCHAR(50),
    match_between VARCHAR(100),
    venue VARCHAR(100),
    winning_team_score INT,
    losing_team_score INT,
    winner_team VARCHAR(50),
    result VARCHAR(100),
    player_of_the_match VARCHAR(100),
    year INT
);


SELECT 
    year,
    winner_team,
    COUNT(*) AS total_wins
FROM t20_matches
GROUP BY year, winner_team
ORDER BY year, total_wins DESC;



-- Wins per team
WITH wins AS (
    SELECT winner_team AS team, COUNT(*) AS win_count
    FROM t20_matches
    GROUP BY winner_team
),

-- Losses inferred from match_between and winner
losses AS (
    SELECT 
        CASE 
            WHEN SUBSTRING_INDEX(match_between, ' vs ', 1) = winner_team THEN SUBSTRING_INDEX(match_between, ' vs ', -1)
            ELSE SUBSTRING_INDEX(match_between, ' vs ', 1)
        END AS team,
        COUNT(*) AS loss_count
    FROM t20_matches
    WHERE result NOT LIKE '%No Result%'
    GROUP BY team
)

SELECT 
    w.team,
    w.win_count,
    COALESCE(l.loss_count, 0) AS loss_count,
    ROUND(w.win_count / NULLIF(l.loss_count, 0), 2) AS win_loss_ratio
FROM wins w
LEFT JOIN losses l ON w.team = l.team
ORDER BY win_loss_ratio DESC;



SELECT 
    COUNT(*) AS total_matches,
    SUM(winning_team_score + losing_team_score) AS total_runs,
    COUNT(DISTINCT year) AS total_editions
FROM t20_matches;



SELECT 
    venue,
    COUNT(*) AS match_count
FROM t20_matches
GROUP BY venue
ORDER BY match_count DESC
LIMIT 10;



SELECT 
    winner_team,
    ROUND(AVG(winning_team_score), 2) AS avg_winning_score
FROM t20_matches
GROUP BY winner_team
ORDER BY avg_winning_score DESC;



SELECT 
    player_of_the_match,
    COUNT(*) AS awards
FROM t20_matches
GROUP BY player_of_the_match
ORDER BY awards DESC
LIMIT 10;



SELECT 
    year,
    ROUND(AVG((winning_team_score + losing_team_score) / 40), 2) AS avg_run_rate
FROM t20_matches
GROUP BY year
ORDER BY year;



SELECT 
    stage,
    COUNT(*) AS match_count
FROM t20_matches
GROUP BY stage
ORDER BY match_count DESC;



SELECT 
    year,
    COUNT(*) AS matches_played
FROM t20_matches
GROUP BY year
ORDER BY year;
