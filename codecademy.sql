-- mastering postgre sql

 --movies 

CREATE TABLE films (
  name TEXT,
  release_year INTEGER
);

INSERT INTO films (name, release_year)
VALUES ('The Matrix', 1999);

INSERT INTO films (name, release_year)
VALUES ('Monsters, Inc.', 2001);

INSERT INTO films (name, release_year)
VALUES ('Call Me By Your Name', 2017);

SELECT * FROM films WHERE release_year = 1999;

ALTER TABLE films ADD COLUMN runtime INTEGER;
ALTER TABLE films ADD COLUMN category TEXT;
ALTER TABLE films ADD COLUMN rating REAL;
ALTER TABLE films ADD COLUMN box_office BIGINT;

UPDATE films
SET runtime = 150,
    category = 'sci-fi',
    rating = 8.7,
    box_office = 465300000   
WHERE name = 'The Matrix';

UPDATE films
SET runtime = 92,
    category = 'animation',
    rating = 8,
    box_office = 5774000000   
WHERE name = 'Monsters, Inc.';

UPDATE films
SET runtime = 132,
    category = 'drama',
    rating = 7.9,
    box_office = 41900000  
WHERE name = 'Call Me By Your Name';

ALTER TABLE films
ADD CONSTRAINT unique_name UNIQUE(name);


--nomnom 

SELECT name, 
CASE
  WHEN review > 4.5 THEN 'Extraordinary'
  WHEN review > 4 THEN 'Excellent'
  WHEN review > 3 THEN 'Good'
  WHEN review > 2 THEN 'Fair'
ELSE 'Poor'
END AS 'review'
FROM nomnom;

-- use group by 
-- instead of this
SELECT AVG(imdb_rating)
FROM movies
WHERE year = 1999;

SELECT AVG(imdb_rating)
FROM movies
WHERE year = 2000;

SELECT AVG(imdb_rating)
FROM movies
WHERE year = 2001;

-- use this instead of the above query
SELECT year,
   AVG(imdb_rating)
FROM movies
GROUP BY year
ORDER BY year;

-- calculate total download for each category
SELECT CATEGORY, SUM(downloads)
FROM fake_apps
GROUP BY CATEGORY;


-- avoid this -----------------
SELECT ROUND(imdb_rating),
   COUNT(name)
FROM movies
GROUP BY ROUND(imdb_rating)
ORDER BY ROUND(imdb_rating);
--  do this instead ----------------------
SELECT ROUND(imdb_rating),
   COUNT(name)
FROM movies
GROUP BY 1
ORDER BY 1;


-- having 
SELECT price,
      ROUND(AVG(downloads)) AS downloads,
      COUNT(*)
FROM fake_apps
GROUP BY price
HAVING COUNT(price) > 10;

-- number of user clicks to web
SELECT CASE
  WHEN url LIKE '%github.com%' THEN 'github'
  WHEN url LIKE '%medium.com%' THEN 'medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  ELSE 'ETC'
  END AS 'Source',
  COUNT(*)
FROM hacker_news
GROUP BY Source;

-- best time to post a story
-- sql query to get the best time most user post 
SELECT strftime('%H', timestamp) AS hour,
      ROUND(AVG(score), 2) AS score,
      COUNT(*) AS count
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;


-- joins --
SELECT * FROM orders
JOIN subscriptions
ON orders.subscription_id = subscriptions.subscription_id;

SELECT * FROM orders
JOIN subscriptions
ON orders.subscription_id = subscriptions.subscription_id
WHERE subscriptions.description = 'Fashion Magazine';


-- A left join will keep all rows from the first table, 
-- regardless of whether there is a matching row in the second table.
-- ex. finding users who subscribed to the newspaper but not on the online
SELECT *
FROM newspaper
LEFT JOIN online
ON newspaper.id = online.id
WHERE online.id IS NULL;

-- cross join
SELECT COUNT(*)
FROM newspaper
WHERE start_month <= 3
AND end_month >= 3;

SELECT * 
FROM newspaper
CROSS JOIN months
WHERE newspaper.start_month <= months.month
AND newspaper.end_month >= months.month;     

SELECT month,
   COUNT(*) AS 'subscribers'
FROM newspaper
CROSS JOIN months
WHERE start_month <= month 
   AND end_month >= month
GROUP BY month;