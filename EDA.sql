## EDA 

-- All the Dataset.
SELECT * FROM netflix_data;

-- Number of Rows.
Select count(*) as total_content
from netflix_data;

-- Distint values in Type columns.
SELECT DISTINCT type
FROM netflix_data;

-- Total Number of Null Values in the Dataset.
SELECT count(*)
FROM netflix_data
WHERE show_id IS NULL
   OR type IS NULL
   OR title IS NULL
   OR director IS NULL
   OR cast IS NULL
   OR country IS NULL
   OR date_added IS NULL
   OR release_year IS NULL
   OR rating IS NULL
   OR duration IS NULL
   OR listed_in IS NULL
   OR description IS NULL;
   


