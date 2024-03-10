show databases;
use ipl;

select * from batting_summary;
# most runs in last 3 ipl
SELECT batsmanName,sum(runs) as total_runs FROM batting_summary group by batsmanName order by total_runs desc limit 10;

#most runs By Playing Role
SELECT playingRole,sum(runs) as total_runs FROM batting_summary 
inner join players
on batting_summary.batsmanName =  `players`.`name`
group by playingRole order by total_runs desc ;

#total dismissed by each batsman
SELECT batsmanName, 
       COUNT(CASE WHEN `out/not_out`  = 'out' THEN 1 END) AS total_dismissed
FROM batting_summary
GROUP BY batsmanName;

#run getter by batting style
SELECT battingStyle,sum(`wickets`) as total_wickets FROM `ipl`.`bowling_summary` 
inner join players
on bowling_summary.bowlerName=players.name
group by battingStyle 
order by total_wickets desc limit 10;


# stike rate top 10
select batsmanName,(sum(runs)/sum(balls))*100 as Strike_rate,playingRole  from batting_summary
inner join players 
on batting_summary.batsmanName=players.`name` 
where playingRole in('Top Order batter','Middle order Batter','All rounder','Wicketkeeper','Bowler')
group by batsmanName,playingRole
having sum(balls)>=60
order by Strike_rate desc limit 10;

#strike rate by PlayingRole
SELECT playingRole,(sum(runs)/sum(balls))*100 as Strike_rate FROM batting_summary 
inner join players
on batting_summary.batsmanName =  `players`.`name`
group by playingRole order by Strike_rate desc ;



#top 10 batsman  w.r.t batting average
SELECT batsmanName,(sum(runs)/ COUNT(CASE WHEN `out/not_out`  = 'out' THEN 1 END)) as batting_average,playingRole
FROM batting_summary
inner join players 
on batting_summary.batsmanName=players.`name` 
GROUP BY batsmanName,playingRole
having sum(balls)>60
order by batting_average desc limit 10;

#boundary percentage
SELECT distinct(batsmanName),((sum(`4s`)*4+sum(`6s`)*6)/sum(runs))*100 as total_boundary_percentage,playingRole 
from `ipl`.`batting_summary`
inner join players
on batting_summary.batsmanName=players.`name` 
where playingRole in ('Top Order batter','Middle order Batter','All rounder','Wicketkeeper','Bowler')
group by batsmanName,playingRole 
having sum(balls)>60
order by total_boundary_percentage desc limit 5;

#most boundaries by player
select batsmanName,sum(`4s`) as total_fours,sum(`6s`) as total_sixes from  `ipl`.`batting_summary` group by batsmanName order by total_sixes desc;






# top 10 wicket taker
SELECT bowlerName,sum(`wickets`) as total_wickets FROM `ipl`.`bowling_summary` group by bowlerName order by total_wickets desc limit 10;


# top 10 bowlers with most dot ball percentage
SELECT bowlerName,
      round( (SUM(`0s`) / (SUM(overs) * 6)) * 100,2) AS Dot_Percentage,playingRole
FROM bowling_summary
inner join players
on bowling_summary.bowlerName=players.`name` 
where playingRole in ('Bowler','All rounder')
GROUP BY bowlerName ,playingRole
order by Dot_percentage desc limit 10;

#most maidens
select bowlerName,sum(maiden) as total_maidens from bowling_summary group by bowlerName order by total_maidens desc limit 5;

#economy rate
select bowlerName,round((sum(runs)/(sum(overs))),2) as economy_rate from bowling_summary 
inner join players
on bowling_summary.bowlerName=players.`name` 
where playingRole in ('Bowler','All rounder')
group by bowlerName 
having sum(overs)*6>=60
order by economy_rate;

#bowling Average
select bowlerName,(sum(runs)/sum(wickets)) as Bowling_avg,sum(wickets) AS TOTAL_WICKETS from bowling_summary 
inner join players
on bowling_summary.bowlerName=players.`name` 
where playingRole in ('Bowler','All rounder')
group by bowlerName 
having sum(overs)*6>=60
order by sum(wickets) desc
;

#total wins in last 3 years
SELECT winner,count(`winner`) as total_wins FROM `ipl`.`match summary1` group by winner order by total_wins desc;

# Chasing Time winner
SELECT `team2`,count('team2') as Won_by_chase
FROM `ipl`.`match summary1`
where team2=winner
group by team2
order by Won_by_chase desc;

#target defend
SELECT `team1`,count('team1') as target_defend
FROM `ipl`.`match summary1`
where team1=winner
group by team1
order by target_defend desc;

#won bY
SELECT `won_by`,count(won_by) AS won_by_count FROM `ipl`.`match summary1` where  year =2021 group by won_by;

# Batting avg by Playing Role
SELECT (sum(runs)/ COUNT(CASE WHEN `out/not_out`  = 'out' THEN 1 END)) as batting_average,playingRole
FROM batting_summary
inner join players 
on batting_summary.batsmanName=players.`name` 
GROUP BY playingRole
having sum(balls)>60
order by batting_average desc limit 10;

