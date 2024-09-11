-- 1. Which movies and shows on Netflix ranked in the top 10 and bottom 10 based on their IMDB scores? 

use oot;
select title , type , imdb_score from netflix
where type = "MOVIE"
order by imdb_score desc
limit 10;

select title , type , imdb_score from netflix
where type = "SHOW" 
order by imdb_score desc
limit 10;

select title , type , imdb_score from netflix
where type = "MOVIE" and imdb_score is not null
order by imdb_score
limit 10;

select title , type , imdb_score from netflix
where type = "SHOW" and imdb_score is not null
order by imdb_score
limit 10;

-- How many movies and shows fall in each decade in Netflix's library? 

select concat(floor(release_year/10)*10,"s") as dacade  ,count(*) from netflix
group by dacade
order by dacade;

-- 3. How did age-certifications impact the dataset?

select distinct age_certification , count(*) from netflix
where age_certification is not null
group by age_certification 
order by count(*) desc;

select age_certification  , 
round(avg(imdb_score),2) as avg_imdb_score, 
round(avg(tmdb_score),2) as avg_tmdb_score from netflix
where age_certification is not null
group by age_certification
order by avg_imdb_score desc;

-- Which genres are the most common?

select genres , count(*) as title_count from netflix
where type = "MOVIE"
group by genres
order by count(*) desc
limit 10;



select genres , count(*) from netflix
group by genres
order by count(*) desc
limit 3;

-- count of total content which are produce by india
-- top 5 production_countries on the base of title count
select production_countries, count(*) as title_count from netflix
group by production_countries
having production_countries is not null
order by count(*) desc
limit 5;

-- highest imdb score movie and show in each counttry

select title, type , imdb_score, production_countries from (select title, type , imdb_score, production_countries, 
rank() over(partition by production_countries order by imdb_score desc ) as top_imdb_score from netflix
where production_countries is not null) x
where top_imdb_score = 1 and type = "MOVIE" and imdb_score is not null;

-- show with maximum runtime

SELECT title ,type, imdb_score , runtime FROM oot.netflix
where type = "SHOW"
order by runtime desc


