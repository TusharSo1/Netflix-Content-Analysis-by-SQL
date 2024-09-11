 # Netflix Content Analysis Project
 ![netfix_image](https://github.com/user-attachments/assets/c984ae4f-0e14-416c-b5fb-ab4542d3b279)


 
#### TOOL USED : Excel and MY SQL

This project focuses on analyzing Netflix's movie and show data, offering insights into IMDb scores, decade distribution, age certifications, genres, and more. The project structure includes the introduction, objectives, methodology, SQL queries, and conclusions.

### 1. Introduction
The entertainment industry is a massive data source, and Netflix has become one of the largest content providers globally. This project aims to analyze various aspects of Netflix's content library, including IMDb scores, content distribution over decades, the impact of age certification, and more.

### 2. Information about dataset
This dataset has two files containing the titles (titles.csv). This dataset contains +5k unique titles on Netflix with 15 columns containing their information, including :

id: The title ID on JustWatch.
title: The name of the title.
show_type: TV show or movie.
description: A brief description.
release_year: The release year.
age_certification: The age certification.
runtime: The length of the episode (SHOW) or movie.
genres: A list of genres.
production_countries: A list of countries that produced the title.
seasons: Number of seasons if it's a SHOW.
imdb_id: The title ID on IMDB.
imdb_score: Score on IMDB.
imdb_votes: Votes on IMDB.
tmdb_popularity: Popularity on TMDB.
tmdb_score: Score on TMDB.

dataset have so much null values.

### 3. Objectives
Netflix is a leading global streaming platform with a vast library of movies and shows. Understanding the nuances of content quality, distribution, and viewer preferences is crucial for enhancing its content strategy and viewer engagement. To achieve this, Netflix needs to analyze various aspects of its content library. Specifically, the company seeks to :
1.	Identify the top 10 and bottom 10 ranked movies and shows on Netflix based on IMDb scores.
2.	Analyze content distribution by decades in Netflix's library.
3.	Examine how age certifications impact IMDb and TMDB scores.
4.	Identify the most common genres.
5.	Count the total content produced by India.
6.	Find the highest IMDb-rated movie and show for each country.
7.	Identify the show with the maximum runtime.

### 4. SQL Queries and Analysis
### 4.1 Top 10 and Bottom 10 Movies and Shows Based on IMDb Scores

##### ● Top 10 Movies by IMDb Score - 

```sql
SELECT title, type, imdb_score 
FROM netflix
WHERE type = "MOVIE"
ORDER BY imdb_score DESC
LIMIT 10;
```
![Screenshot 2024-09-11 213731](https://github.com/user-attachments/assets/380205e8-beaf-49a4-9a74-52536a967d98)

##### ● Top 10 Shows by IMDb Score
```sql
SELECT title, type, imdb_score 
FROM netflix
WHERE type = "SHOW"
ORDER BY imdb_score DESC
LIMIT 10;
```
![Screenshot 2024-09-11 215354](https://github.com/user-attachments/assets/cf24761d-4de2-41bb-b427-252024707572)

##### ● Bottom 10 MOVIE by IMDb Score
```sql
select title , type , imdb_score from netflix
where type = "MOVIE" and imdb_score is not null
order by imdb_score
limit 10;
```
![Screenshot 2024-09-11 215837](https://github.com/user-attachments/assets/410f0b41-72b4-4586-87bc-e92d66d8ba68)

##### ● Bottom 10 SHOW by IMDb score
```sql
select title , type , imdb_score from netflix     
where type = "SHOW" and imdb_score is not null
order by imdb_score
limit 10;
```
![Screenshot 2024-09-11 220040](https://github.com/user-attachments/assets/7caa162c-aac0-4968-8d8e-5395b70570e0)

IMDb scores are a key indicator of a movie or show's quality and popularity. The top 10 ranked titles on Netflix, with exceptional IMDb scores, reflect strong viewer approval and critical acclaim, making them appealing to those seeking high-quality content. In contrast, the bottom 10 titles received lower ratings, likely due to factors like weak plot, poor acting, or production quality. This analysis highlights the varying audience reception, offering valuable insights for viewers looking for top-rated content and guiding Netflix in refining its recommendations and content strategy # we can add genres in the column aswell to find out the genres of the Top 10 and bottom 10 MOVIES and SHOWS which help us to find more information about the data.

### 4.2 Content Distribution by Decades in NETFLIX"S LIBRARY
This query groups the content by release decade and counts the number of movies and shows released in each decade which are in Netflix.

```sql
select concat(floor(release_year/10)*10,"s") as release_dacade , type ,count(id) as total_release from netflix
-- concat(floor(release_year/10)*10,"s") --> lets consider release year = 1997, then as formula 1997/10 = 199.7 where floor function
-- convert this into lower round 199 then * 10 convert this into 199*10 = 1990 and concate with s which finally convert this into dacade 1990s
group by release_dacade , type
order by release_dacade;
```
![Screenshot 2024-09-11 224817](https://github.com/user-attachments/assets/b72190e1-0e29-45c6-bf3f-4d6071191d4b)

The SQL query results reveal a dramatic shift in Netflix's content distribution over decades. The data shows count of MOVIES and SHOWS increase from the 2000s onward aswell as we can analys the demant or growth of shows as incresed more campare with movies, with the 2010s featuring a total 3,304 movies and shows. This surge highlights Netflix's focus on contemporary content that meets current trends. Although the 2020s are ongoing, the dataset already includes 1,972 titles, underscoring Netflix's strong commitment to recent content. Overall, the increasing volume of MOIVES and SHOWs from the 2000s reflects Netflix's strategy to provide a diverse and up-to-date library, catering to various audience preferences across different eras.

### 4.3 Impact of Age Certifications on the MOVIES AND SHOWS
```sql
select age_certification, count(*) as total_certification from netflix
where age_certification is not null
group by age_certification
order by count(*) desc;
```
![Screenshot 2024-09-11 230508](https://github.com/user-attachments/assets/15edc753-20cc-477d-87c3-53b81caf343a)
##### ● Age Certification impact on IMDb Score 
```sql
select age_certification  , 
round(avg(imdb_score),2) as avg_imdb_score, 
round(avg(tmdb_score),2) as avg_tmdb_score from netflix
where age_certification is not null
group by age_certification
order by avg_imdb_score desc;
```
![Screenshot 2024-09-11 231113](https://github.com/user-attachments/assets/1a154bfc-5ad5-428f-91e3-648b80f5a0cc)

The analysis of IMDb scores by age certification reveals that content rated TV-14 has the highest average score of 7.22, indicating strong viewer approval for this age group. TV-G content also fares well with an average score of 6.33. Conversely, ratings for NC17 and PG are lower, yet they still maintain a solid audience.

In terms of content distribution, the dataset shows thatTV-MA ()show are the most common, with 882 entries, followed by R-rated(for mocies) with 556 certification. PG-rated content totals 233, and G-rated content has 124 cretification, while NC-17 is the least represented with only 16 titles. Overall, the data highlights Netflix’s broad range of content across different age certifications and suggests that certain ratings, especially TV-14, TV-MA and , R-rated are more favorably received by viewers.

### Most Common Genre:
##### ● Top 10 most common genres for MOVIES
```sql
select genres , count(*) as title_count from netflix
where type = "MOVIE"
group by genres
order by count(*) desc
limit 10;
```
![Screenshot 2024-09-11 233437](https://github.com/user-attachments/assets/a02b7338-05c2-4648-8b6b-6813b6918438)

##### ● Top 10 most common genres for SHOWS
```sql
select genres , count(*) as title_count from netflix
where type = "SHOW"
group by genres
order by count(*) desc
limit 10;
```
![Screenshot 2024-09-11 233643](https://github.com/user-attachments/assets/d5e1ca91-87f5-4ac5-85e3-54aca75912ee)
Analyzing genre frequency reveals key insights into Netflix's content. For movies, Comedy tops the list with 384 entries, followed by Documentary and Drama with 230 and 224, respectively. Popular genre combinations include Comedy + Documentary and Comedy + Drama, highlighting audience preference for blended genres.

For shows, Reality leads with 113 entries, followed by Drama and Comedy with 104 and 100, respectively. Multi-genre combinations like Comedy + Drama and Drama + Romance are also notable.

Overall, Comedy dominates with 484 entries, followed by Documentary (329) and Drama (328). These findings illustrate Netflix’s focus on diverse content to meet varied viewer preferences.

### Top 5 Production Pountries on the Base of Title Count
```sql
select production_countries, count(*) as title_count from netflix
group by production_countries
having production_countries is not null
order by count(*) desc
limit 5;
```
![Screenshot 2024-09-11 234819](https://github.com/user-attachments/assets/0b8e4ef9-89bc-4728-9587-db7a75099fa2)
The query reveals the top 5 countries producing the most titles on Netflix. This highlights key regions contributing to Netflix's content library, reflecting both audience demand and Netflix's investment in diverse global content. The results showcase the platform’s strategy to appeal to a broad audience by offering culturally varied programming from major production hubs.

###  highest IMDb-rated movie from each production countries
```sql
select title, type , imdb_score, production_countries from (select title, type , imdb_score, production_countries, 
rank() over(partition by production_countries order by imdb_score desc ) as top_imdb_score from netflix
where production_countries is not null) x
where top_imdb_score = 1 and type = "MOVIE" and imdb_score is not null;
```
![Screenshot 2024-09-12 023758](https://github.com/user-attachments/assets/83c3d0cf-a33a-4a58-9f98-1168346e3895)


This query identifies the highest-rated IMDb movie from each production country on Netflix. It highlights the top-performing films globally, showcasing the diversity and quality of content from different regions. This analysis provides insight into Netflix's international content offerings and reflects audience preferences for critically acclaimed movies across various countries.

###  Conclusion

This Netflix Content Analysis project offers valuable insights into the platform's extensive library by examining IMDb scores, genre diversity, age certifications, and production countries. Key findings include the dominance of comedy as the most common genre across movies and shows, the increasing content distribution from the 2000s onwards, and the popularity of TV-14 and TV-MA content based on IMDb ratings. Additionally, the analysis highlights the global reach of Netflix by identifying top-producing countries and their highest-rated films. Overall, the project provides a comprehensive overview of Netflix's diverse content offerings, helping to understand viewer preferences and content trends.
















