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



SELECT 
	date,
	CASE WHEN hometeam_id = 8634 THEN 'FC Barcelona' 
         ELSE 'Real Madrid CF' END as home,
	CASE WHEN awayteam_id = 8634 THEN 'FC Barcelona' 
         ELSE 'Real Madrid CF' END as away,
	-- Identify all possible match outcomes
	case when home_goal > away_goal and hometeam_id = 8634 then 'Barcelona win!'
        WHEN home_goal > away_goal and hometeam_id = 8633 then 'Real Madrid win!'
        WHEN home_goal < away_goal and awayteam_id = 8634 then 'Barcelona win!'
        WHEN home_goal < away_goal and awayteam_id = 8633 then 'Real Madrid win!'
        else 'Tie!' end as outcome
FROM matches_spain
WHERE (awayteam_id = 8634 OR hometeam_id = 8634)
      AND (awayteam_id = 8633 OR hometeam_id = 8633);
      
      
      
-- Select the season, date, home_goal, and away_goal columns
SELECT 
	season,
    date,
	home_goal,
	away_goal
FROM matches_italy
WHERE 
-- Exclude games not won by Bologna
	case when hometeam_id = 9857 and home_goal > away_goal then 'Bologna Win'
		when awayteam_id = 9857 and away_goal > home_goal then 'Bologna Win' 
		end IS NOT null;
		
		
		
SELECT 
	c.name AS country,
    -- Count matches in each of the 3 seasons
	count(case when m.season = '2012/2013' then m.id end) AS matches_2012_2013,
	count(case when m.season = '2013/2014' then m.id end) AS matches_2013_2014,
	count(case when m.season = '2014/2015' then m.id end) AS matches_2014_2015
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
-- Group by country name alias
group by country;



SELECT 
	c.name AS country,
    -- Sum the total records in each season where the home team won
	sum(case when m.season = '2012/2013' AND m.home_goal > m.away_goal 
        THEN 1 ELSE 0 end) AS matches_2012_2013,
 	sum(case when m.season = '2013/2014' and m.home_goal > m.away_goal   
        THEN 1 else 0 end) AS matches_2013_2014,
	sum(case when m.season = '2014/2015' and m.home_goal > m.away_goal 
        then 1 else 0 end) AS matches_2014_2015
FROM country AS c
LEFT JOIN match AS m
ON c.id = m.country_id
-- Group by country name alias
GROUP BY country;



SELECT 
	c.name AS country,
    -- Round the percentage of tied games to 2 decimal points
	ROUND(AVG(CASE WHEN m.season='2013/2014' AND m.home_goal = m.away_goal THEN 1
			 WHEN m.season='2013/2014' AND m.home_goal != m.away_goal THEN 0
			 END),2) AS pct_ties_2013_2014,
	ROUND(AVG(CASE WHEN m.season='2014/2015' AND m.home_goal = m.away_goal THEN 1
			 WHEN m.season='2014/2015' AND m.home_goal != m.away_goal THEN 0
			 END),2) AS pct_ties_2014_2015
FROM country AS c
LEFT JOIN matches AS m
ON c.id = m.country_id
GROUP BY country;



