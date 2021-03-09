- select basics -

select population from world
  where name = 'Germany';

----------------------------

select name, population from world
  where name in ('Sweden', 'Norway', 'Denmark');

----------------------------

select name, area from world
  where area BETWEEN 200000 AND 250000;

----------------------------

- select from WORLD Tutorial -

select name, continent, population from world;

----------------------------

select name
  from world
  where population > 200000000;

----------------------------

select name, gdp/population
  from world
  where population > 200000000;

----------------------------

select name, population/1000000
  from world
  where continent = 'south america';

----------------------------

select name, population
  from world
  where name in ('france', 'germany', 'italy');

----------------------------

select name
  from world
  where name like '%united%';

----------------------------

select name, population, area
  from world
  where area > 3000000 or population > 250000000;
----------------------------

select name, population, area
  from world
  where ( population > 250000000 and area < 3000000 ) or ( area > 3000000 and population < 250000000 );

----------------------------

select name, round(population / 1000000, 2), round(gdp / 1000000000, 2)
  from world
  where continent = 'south america';

----------------------------

select name, round(gdp / population, -3)
  from world
  where gdp > 1000000000000;

----------------------------

select name,capital
  from world
  where length(name) = length(capital);

----------------------------

select name, capital
  from world
  where left(name, 1) = left(capital, 1) and (name <> capital);

----------------------------

select name
  from world
  where name like '%a%' and name like '%e%' and name like '%i%' and name like '%o%' and name like '%u%' and name not like '% %';

----------------------------

- SELECT from Nobel Tutorial -

select yr, subject, winner
  from nobel
  where yr = 1950;

----------------------------

select winner
  from nobel
  where yr = 1962 and subject = 'literature';

----------------------------

select yr, subject
  from nobel
  where winner = 'albert einstein';

----------------------------

select winner
  from nobel
  where yr >= 2000 and subject = 'peace';

----------------------------

select yr, subject, winner
  from nobel
  where yr >= 1980 and yr <= 1989 and subject = 'literature';

----------------------------

select * 
  from nobel
  where winner = 'theodore roosevelt' or winner = 'woodrow wilson' or winner = 'jimmy carter' or winner = 'barack obama';

----------------------------

select winner 
  from nobel
  where winner like 'john%';

----------------------------

select yr, subject, winner 
  from nobel
  where (subject = 'physics' and yr = 1980) or (subject = 'chemistry' and yr = 1984);

----------------------------

select yr, subject, winner 
  from nobel
  where yr = 1980 and (subject <> 'chemistry' and subject <> 'medicine');

----------------------------

select yr, subject, winner 
  from nobel
  where (yr < 1910 and subject = 'medicine') or (yr >= 2004 and subject = 'literature');

----------------------------

select * 
  from nobel
  where winner = 'peter grünberg';

----------------------------

select * 
  from nobel
  where winner = 'eugene o''neill';

----------------------------

select winner, yr, subject 
  from nobel
  where winner like 'sir%'
  order by yr desc, winner;

----------------------------

SELECT winner, subject
  FROM nobel
  WHERE yr = 1984
  ORDER BY subject IN ('Physics', 'Chemistry'), subject, winner;

----------------------------

- SELECT within SELECT Tutorial -

select name 
  from world
  where population > (select population from world where name='russia');

----------------------------

select name
  from world 
  where gdp/population > (select gdp/population from world where name = 'united kingdom') and continent = 'europe';

----------------------------

select name, continent
  from world
  where continent in (select continent from world where name in ('argentina','australia')) order by name;

----------------------------

select name, population 
  from world
  where population > (select population from world where name = 'canada') and population < (select population from world where name = 'poland');

----------------------------

select name,concat(round(population/(select population from world where name = 'germany')*100, 0), '%') from world
where continent = 'europe';

----------------------------

select name 
  from world
  where gdp >= all(select gdp from world where gdp >=0 and continent = 'europe') and continent != 'europe';

----------------------------

select continent, name, area 
  from world x
  where area >= all (select area from world y where y.continent=x.continent and area>0);

----------------------------

select continent, name 
  from world x
  where name <= all (select name from world y where y.continent=x.continent);

----------------------------

select name, continent, population 
  from world x
  where 25000000 > all(select population from world y where x.continent = y.continent and y.population > 0);

----------------------------

select name, continent 
  from world x
  where population > all(select population*3 from world y where x.continent = y.continent and population > 0 and y.name != x.name);

----------------------------

- SUM and COUNT -


select sum(population) 
  from world;

----------------------------

select distinct continent 
  from world;

----------------------------

select sum(gdp) 
  from world
  where continent = 'africa';

----------------------------

select count (name) 
  from world
  where area > 1000000;

----------------------------

select sum(population) 
  from world
  where name in ('estonia', 'latvia', 'lithuania');

----------------------------

select continent, count(name) 
  from world
  group by continent;

----------------------------

select continent, count(name) 
  from world
  where population > 10000000 group by continent;

----------------------------

select continent  
  from world
  group by continent having sum(population) > 100000000;

----------------------------

- The JOIN operation -


select matchid, player
  from goal 
  where  teamid = 'ger';

----------------------------

select id,stadium,team1,team2
  from game
  where id = 1012;

----------------------------

select player, teamid, game.stadium, mdate
  from game join goal on (game.id=goal.matchid)
  where teamid = 'GER';

----------------------------

select team1, team2, player
  from game
  join goal 
  on (id=matchid and player like ('mario%'));

----------------------------

select player, teamid, coach, gtime
  from goal 
  join eteam 
  on (gtime <= 10 and teamid = id);

----------------------------

select mdate, teamname
  from game 
  join eteam 
  on (team1=eteam.id and coach = 'fernando santos');

----------------------------

select player
  from game 
  join goal  
  on (stadium = 'national stadium, warsaw' and id = matchid);

----------------------------

select distinct player 
  from game 
  join goal 
  on matchid = id 
  where ((team1='ger' or team2='ger') and teamid!='ger');

----------------------------

select teamname, count(player) 
  from eteam 
  join goal 
  on id=teamid
  group by teamname;

----------------------------

select stadium, count(player) 
  from game 
  join goal 
  on matchid=id 
  group by stadium;

----------------------------

select matchid,mdate,count(player) 
  from game 
  join goal 
  on matchid = id 
  where (team1 = 'pol' or team2 = 'pol') group by matchid, mdate;

----------------------------

select matchid,mdate,count(player) 
  from goal 
  join game 
  on id=matchid
  where teamid = 'ger' group by matchid,mdate;

----------------------------

select mdate,team1,sum(case when teamid = team1 then 1 else 0 end) as score1, team2,sum(case when teamid = team2 then 1 else 0 end) as score2 
  from game 
  left join goal 
  on (id = matchid)
  group by mdate,team1,team2 
  order by mdate, matchid, team1, team2;

----------------------------

- More JOIN operations -

select id, title
  from movie
  where yr=1962;

----------------------------

select yr
  from movie
  where title = 'Citizen Kane';

----------------------------

select id, title, yr 
  from movie 
  where title like 'star trek%' 
  order by yr;

----------------------------

select id 
  from actor 
  where name = 'glenn close';

----------------------------

select id 
  from movie
  where title = 'casablanca';

----------------------------

select name 
  from actor, casting
  where id=actorid and movieid = 11768;

----------------------------

select name 
  from actor, casting 
  where id=actorid and movieid = (select id from movie where title = 'alien');

----------------------------

select title
  from movie 
  join casting 
  on (id=movieid and actorid = (select id from actor where name = 'harrison ford'));

----------------------------

select title 
  from movie 
  join casting 
  on (id=movieid and actorid = (select id from actor where name = 'harrison ford' and ord != 1));

----------------------------

select title, name 
  from movie 
  join casting 
  on (id=movieid) join actor on (actor.id = actorid)
  where ord=1 and yr = 1962;

----------------------------

select yr,count(title) 
  from movie 
  join casting 
  on movie.id=movieid join actor on actorid=actor.id
  where name='rock hudson' 
  group by yr having count(title) > 2;

----------------------------

select title, name 
  from movie
  join casting x 
  on movie.id = movieid
  join actor 
  on actor.id =actorid
  where ord=1 and movieid in (select movieid from casting y
  join actor 
  on actor.id=actorid
  where name='julie andrews');

----------------------------

select name 
  from actor 
  join casting on (id=actorid and (select count(ord) from casting where actorid = actor.id and ord=1)>=15)
  group by name;

----------------------------

select title, count(actorid) 
  from movie 
  join casting on movie.id = movieid 
  where yr = 1978 group by title order by count(actorid) desc, title;

----------------------------

select distinct name 
  from actor 
  join casting on id=actorid
  where movieid in (select movieid from casting join actor on (actorid=id and name='art garfunkel')) and name != 'art garfunkel';

----------------------------

- Using Null -

select name 
  from teacher
  where dept is null;

----------------------------

select teacher.name,dept.name 
  from teacher
  inner join dept on (teacher.dept = dept.id);

----------------------------

select teacher.name, dept.name 
  from teacher 
  left join dept on (teacher.dept=dept.id);

----------------------------

select teacher.name, dept.name 
  from teacher 
  right join dept on (teacher.dept=dept.id);

----------------------------

select teacher.name, coalesce(teacher.mobile, '07986 444 2266')
  from teacher 
  left join dept on (teacher.dept=dept.id);

----------------------------

select teacher.name, coalesce(dept.name, 'None') 
  from teacher 
  left join dept on (teacher.dept=dept.id);

----------------------------

select count(name), count(mobile) 
  from teacher;

----------------------------

select dept.name, count(teacher.name) from teacher 
  right join dept on (teacher.dept=dept.id)
  group by dept.name;

----------------------------

select teacher.name,
  case when dept.id = 1 then 'Sci' when dept.id = 2 then 'Sci' else 'Art' end
  from teacher 
  left join dept on (teacher.dept=dept.id);

----------------------------

select teacher.name,
  case when dept.id = 1 then 'sci' when dept.id = 2 then 'sci' when dept.id = 3 then 'art' else 'none' end
  from teacher 
  left join dept on (dept.id=teacher.dept);

----------------------------

select teacher.name,
  case when dept.id = 1 then 'Sci' when dept.id = 2 then 'Sci' when dept.id = 3 then 'Art' else 'None' end
  from teacher 
  left join dept on (dept.id=teacher.dept);

----------------------------

- Self join -

select count(name) 
  from stops;

----------------------------

select id  
  from stops 
  where name = 'craiglockhart';

----------------------------

select id, name 
  from stops
  join route on id = stop
  where num = '4' and company = 'lrt';

----------------------------

select company, num, count(*) as cnt 
  from route where stop=149 or stop=53
  group by company, num
  having cnt=2;

----------------------------

select a.company, a.num, a.stop, b.stop 
  from route a 
  join route b on (a.company=b.company and a.num=b.num)
  where a.stop=53 and b.stop=149;

----------------------------

select a.company, a.num, stopa.name, stopb.name 
  from route a 
  join route b on (a.company=b.company and a.num=b.num)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
  where stopa.name='craiglockhart' and stopb.name='london road';

----------------------------

select distinct a.company, a.num 
  from route a 
  join route b on (a.company =b.company and a.num=b.num)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
  where stopa.name='haymarket' and stopb.name='leith';

----------------------------

select distinct a.company, a.num 
  from route a
  join route b on (a.num=b.num and a.company=b.company)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
  where stopa.name = 'craiglockhart' and stopb.name = 'tollcross';

----------------------------

select distinct stopb.name, a.company, a.num 
  from route a 
  join route b on a.company = b.company and a.num = b.num
  join stops stopa on a.stop = stopa.id
  join stops stopb on b.stop = stopb.id
  where stopa.name = 'craiglockhart';

----------------------------
