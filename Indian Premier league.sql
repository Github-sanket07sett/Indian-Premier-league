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




