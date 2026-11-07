
-- TrendPulse: Part 4 - SQL Analysis
-- Database recreation script

DROP DATABASE IF EXISTS trendpulse_db;
CREATE DATABASE trendpulse_db;
USE trendpulse_db;

-- 1. Categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- 2. Videos table
CREATE TABLE videos (
    video_id VARCHAR(50) PRIMARY KEY,
    title TEXT,
    channel_title VARCHAR(255),
    category_id INT,
    publish_time DATETIME,
    tags TEXT,
    thumbnail_link TEXT,
    description TEXT,
    comments_disabled BOOLEAN,
    ratings_disabled BOOLEAN,
    video_error_or_removed BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 3. Trending records table
CREATE TABLE trending_records (
    video_id VARCHAR(50),
    trending_date DATE,
    country VARCHAR(10),
    views BIGINT,
    likes BIGINT,
    dislikes BIGINT,
    comment_count BIGINT,
    PRIMARY KEY (video_id, trending_date, country),
    FOREIGN KEY (video_id) REFERENCES videos(video_id)
);

-- CSV import instructions:
-- Import categories.csv into categories first.
-- Import videos.csv into a staging table with the three
-- BOOLEAN fields defined as VARCHAR(10).
-- Convert 'True'/'False' into 1/0 before inserting into videos.
-- Import trending_records.csv into trending_records last.
-- Use MySQL Shell util.importTable() with dialect "csv-unix".

-- Query 1: SELECT and WHERE
SELECT video_id, country, views, likes, comment_count
FROM trending_records
WHERE country = 'US' AND views >= 1000000
LIMIT 10;

-- Query 2: ORDER BY and LIMIT
SELECT video_id, country, trending_date, views
FROM trending_records
ORDER BY views DESC
LIMIT 10;

-- Query 3: DISTINCT
SELECT DISTINCT country
FROM trending_records
ORDER BY country;

-- Query 4: Aliases and aggregate functions
SELECT
    country AS country_name,
    ROUND(AVG(views), 2) AS average_views,
    SUM(likes) AS total_likes,
    SUM(comment_count) AS total_comments
FROM trending_records
GROUP BY country
ORDER BY average_views DESC;

-- Query 5: GROUP BY, HAVING and INNER JOIN
SELECT
    c.category_name,
    COUNT(*) AS record_count,
    ROUND(AVG(tr.views), 2) AS average_views
FROM trending_records tr
INNER JOIN videos v ON tr.video_id = v.video_id
INNER JOIN categories c ON v.category_id = c.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(*) >= 1000
ORDER BY average_views DESC;

-- Query 6: INNER JOIN
SELECT v.video_id, v.title, c.category_name
FROM videos v
INNER JOIN categories c ON v.category_id = c.category_id
LIMIT 10;

-- Query 7: LEFT JOIN
SELECT c.category_name, COUNT(v.video_id) AS total_videos
FROM categories c
LEFT JOIN videos v ON c.category_id = v.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_videos DESC;

-- Query 8: RIGHT JOIN
SELECT c.category_name, COUNT(v.video_id) AS total_videos
FROM videos v
RIGHT JOIN categories c ON v.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_videos DESC;

-- Bonus: Country-wise category analysis
SELECT
    tr.country,
    c.category_name,
    COUNT(*) AS record_count,
    ROUND(AVG(tr.views), 2) AS average_views
FROM trending_records tr
INNER JOIN videos v ON tr.video_id = v.video_id
INNER JOIN categories c ON v.category_id = c.category_id
GROUP BY tr.country, c.category_name
ORDER BY tr.country, average_views DESC;
