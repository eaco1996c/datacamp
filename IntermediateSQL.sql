-- Identify the home team as Bayern Munich, Schalke 04, or neither
SELECT 
	CASE when hometeam_id = 10189 then 'FC Schalke 04'
        when hometeam_id = 9823 then 'FC Bayern Munich'
         ELSE 'Other' END AS home_team,
	COUNT(id) AS total_matches
FROM matches_germany
-- Group by the CASE statement alias
GROUP BY home_team;



SELECT 
	m.date,
	t.team_long_name AS opponent,
    -- Complete the CASE statement with an alias
	case when m.home_goal > m.away_goal then 'Barcelona win!'
        when m.home_goal < m.away_goal then 'Barcelona loss :(' 
        else 'Tie' end as outcome 
FROM matches_spain AS m
LEFT JOIN teams_spain AS t 
ON m.awayteam_id = t.team_api_id
-- Filter for Barcelona as the home team
WHERE m.hometeam_id = 8634; 


-- Select matches where Barcelona was the away team
SELECT  
	m.date,
	t.team_long_name AS opponent,
	case when m.home_goal < m.away_goal then  'Barcelona win!'
        WHEN m.home_goal > m.away_goal then 'Barcelona loss :(' 
        else 'Tie' end as outcome
FROM matches_spain AS m
-- Join teams_spain to matches_spain
LEFT JOIN teams_spain AS t 
ON m.hometeam_id = t.team_api_id
WHERE m.awayteam_id = 8634;

