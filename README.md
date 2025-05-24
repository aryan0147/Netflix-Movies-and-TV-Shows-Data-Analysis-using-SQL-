# Netflix-Movies-and-TV-Shows-Data-Analysis-using-SQL.

# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)


## Netflix Data Analysis using SQL

-- Read the Data
select * from netflix_data;

 -- Bussiness Problems Sets 
 
-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows.

select type,count(*) as "total content"
from netflix_data
group by type;

-- 2. Find the most common rating for movies and TV shows.
with X as (
select 
	type, 
    rating, count(*),
    Rank() Over(partition by type order by count(*) desc) as ranking
from netflix_data
group by type, rating
order by 1,3 desc)

select type, rating 
from X
where ranking = 1;


-- 3. List all movies released in a specific year (e.g., 2020).

select type,title ,release_year from netflix_data
where release_year in (2020) and
type = "Movie";


-- 4. Find the top 5 countries with the most content on Netflix.

select country, count(*) 
from netflix_data
group by 1
order by 2 desc limit 5;


-- 5. Identify the longest movie.

select *
from netflix_data
where type = "Movie"
and duration = (select Max(duration) from netflix_data);


-- 6. Find content added in the last 5 years

SELECT *, DATE_FORMAT(date_added, "%m-%d-%Y") AS added_date
FROM netflix_data
WHERE date_added <= CURDATE() - INTERVAL 5 YEAR;
;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select * from netflix_data
where director Like "%Rajiv Chilaka%";

-- 8. List all TV shows with more than 5 seasons

select * from netflix_data
where type = "TV Show"
and
duration > "5 Season";

-- 9. Count the number of content items in each genre

select distinct(listed_in), count(*)
from netflix_data
group by 1
order by 2 desc;


-- 10.Find each year and the average numbers of content release in India on netflix. 
-- return top 5 year with highest avg content release!

SELECT 
    YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year,
    COUNT(*) AS count
FROM netflix_data
WHERE country LIKE '%India%'
GROUP BY year
ORDER BY year;


-- 11. List all movies that are documentaries.

select * from netflix_data
where type = "Movie" and
listed_in like '%Documentaries%';

-- 12. Find all content without a director.

select * from netflix_data
where director is null;


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT *
FROM netflix_data
WHERE 
  cast LIKE '%Salman Khan%'
  AND release_year >= YEAR(CURDATE()) - 10;
;


-- 14.Find the top 10 countries that have produced the highest number of movies in the netflix table.

SELECT country, COUNT(*) AS movie_count
FROM netflix_data
GROUP BY country
ORDER BY movie_count DESC
LIMIT 10;


-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.


SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix_data
) AS categorized_content
GROUP BY 1,2
ORDER BY 2;


**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.
