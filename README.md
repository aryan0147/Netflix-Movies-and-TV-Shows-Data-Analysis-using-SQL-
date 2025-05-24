# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## 📌 Table of Contents

* [Dataset Overview](#dataset-overview)
* [Business Problems & SQL Solutions](#business-problems--sql-solutions)

  * [1. Movies vs TV Shows Count](#1-movies-vs-tv-shows-count)
  * [2. Most Common Rating](#2-most-common-rating)
  * [3. Movies Released in 2020](#3-movies-released-in-2020)
  * [4. Top 5 Countries with Most Content](#4-top-5-countries-with-most-content)
  * [5. Longest Movie](#5-longest-movie)
  * [6. Content Added in the Last 5 Years](#6-content-added-in-the-last-5-years)
  * [7. Content by Rajiv Chilaka](#7-content-by-rajiv-chilaka)
  * [8. TV Shows with More Than 5 Seasons](#8-tv-shows-with-more-than-5-seasons)
  * [9. Content Count by Genre](#9-content-count-by-genre)
  * [10. Content Released in India Over Years](#10-content-released-in-india-over-years)
  * [11. Documentary Movies](#11-documentary-movies)
  * [12. Content Without Director Info](#12-content-without-director-info)
  * [13. Salman Khan's Appearances in 10 Years](#13-salman-khans-appearances-in-10-years)
  * [14. Top 10 Movie-Producing Countries](#14-top-10-movie-producing-countries)
  * [15. Content Categorization (Good/Bad)](#15-content-categorization-goodbad)
* [Technologies Used](#technologies-used)
* [License](#license)

---

## 📁 Dataset Overview

The dataset used contains detailed information on Netflix content including:

* Title
* Type (Movie/TV Show)
* Director, Cast, Genre
* Country
* Release Year
* Duration
* Date Added
* Description

---

## 📊 Business Problems & SQL Solutions

### 1. Movies vs TV Shows Count

```sql
SELECT type, COUNT(*) AS total_content
FROM netflix_data
GROUP BY type;
```

### 2. Most Common Rating

```sql
WITH X AS (
    SELECT type, rating, COUNT(*) AS rating_count,
           RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix_data
    GROUP BY type, rating
)
SELECT type, rating
FROM X
WHERE ranking = 1;
```

### 3. Movies Released in 2020

```sql
SELECT type, title, release_year
FROM netflix_data
WHERE release_year = 2020 AND type = 'Movie';
```

### 4. Top 5 Countries with Most Content

```sql
SELECT country, COUNT(*) AS total_content
FROM netflix_data
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;
```

### 5. Longest Movie

```sql
SELECT *
FROM netflix_data
WHERE type = 'Movie'
  AND duration = (
      SELECT MAX(duration)
      FROM netflix_data
      WHERE type = 'Movie'
  );
```

### 6. Content Added in the Last 5 Years

```sql
SELECT *, DATE_FORMAT(date_added, '%m-%d-%Y') AS added_date
FROM netflix_data
WHERE date_added >= CURDATE() - INTERVAL 5 YEAR;
```

### 7. Content by Rajiv Chilaka

```sql
SELECT *
FROM netflix_data
WHERE director LIKE '%Rajiv Chilaka%';
```

### 8. TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM netflix_data
WHERE type = 'TV Show' AND duration > '5 Season';
```

### 9. Content Count by Genre

```sql
SELECT listed_in, COUNT(*) AS genre_count
FROM netflix_data
GROUP BY listed_in
ORDER BY genre_count DESC;
```

### 10. Content Released in India Over Years (Top 5)

```sql
SELECT YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS year, COUNT(*) AS content_count
FROM netflix_data
WHERE country LIKE '%India%'
GROUP BY year
ORDER BY content_count DESC
LIMIT 5;
```

### 11. Documentary Movies

```sql
SELECT *
FROM netflix_data
WHERE type = 'Movie' AND listed_in LIKE '%Documentaries%';
```

### 12. Content Without Director Info

```sql
SELECT *
FROM netflix_data
WHERE director IS NULL;
```

### 13. Salman Khan’s Appearances in Last 10 Years

```sql
SELECT *
FROM netflix_data
WHERE cast LIKE '%Salman Khan%'
  AND release_year >= YEAR(CURDATE()) - 10;
```

### 14. Top 10 Movie-Producing Countries

```sql
SELECT country, COUNT(*) AS movie_count
FROM netflix_data
WHERE type = 'Movie'
GROUP BY country
ORDER BY movie_count DESC
LIMIT 10;
```

### 15. Content Categorization (Good/Bad)

```sql
SELECT category, type, COUNT(*) AS content_count
FROM (
    SELECT *,
           CASE
               WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
               ELSE 'Good'
           END AS category
    FROM netflix_data
) AS categorized_content
GROUP BY category, type
ORDER BY type;
```

---

**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.

## 🛠️ Technologies Used

* SQL (MySQL syntax)
* Jupyter Notebook / SQL Editor
* Netflix Dataset (public)
