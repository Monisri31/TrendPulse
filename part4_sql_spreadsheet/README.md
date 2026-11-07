# Part 4 – SQL and Spreadsheet Analysis

## Project: TrendPulse – What's Actually Trending Right Now?

### 1. Objective

The objective of Part 4 is to organize the cleaned trending-video dataset into related relational database tables, perform SQL analysis using MySQL, and create an Excel workbook for spreadsheet-based analysis.

The dataset is synthetic and is used for educational purposes. The findings should not be interpreted as actual YouTube trends.

### 2. Files and Folder Structure

```text
part4_sql_spreadsheet/
│
├── data/
│   ├── categories.csv
│   ├── videos.csv
│   ├── trending_records.csv
│   ├── TrendPulse_Analysis (1).xlsx
│   ├── USvideos.csv
│   ├── GBvideos.csv
│   └── INvideos.csv
│
├── part4.ipynb
├── part4.sql
└── README.md
```

### 3. Data Preparation

The cleaned dataset from Part 2 was used to prepare three related CSV files.

| Dataset | Description | Records |
|---|---|---:|
| categories | Unique video categories | 14 |
| videos | Unique videos and their details | 14,699 |
| trending_records | Video trending observations by date and country | 46,000 |

The three tables have the following relationships:

- `categories.category_id` is the primary key in the categories table.
- `videos.video_id` is the primary key in the videos table.
- `videos.category_id` references `categories.category_id`.
- `trending_records` uses a composite primary key: `video_id`, `trending_date`, and `country`.
- `trending_records.video_id` references `videos.video_id`.

### 4. MySQL Database Design

**Database:** `trendpulse_db`

Three related tables were created:

1. `categories`
2. `videos`
3. `trending_records`

Primary keys and foreign keys were added to maintain data integrity.

#### Data import

MySQL Server 8.0.35 and MySQL Shell were used.

The CSV files were imported using MySQL Shell's `util.importTable()` with the `csv-unix` dialect and the header row skipped.

Import order:

1. Import `categories.csv`.
2. Import `videos.csv`.
3. Import `trending_records.csv`.

For the videos table, the three Boolean columns were initially imported into a staging table as text (`True`/`False`) and then converted into Boolean values in the main table.

#### Validation results

| Validation | Result |
|---|---:|
| Categories records | 14 |
| Videos records | 14,699 |
| Trending records | 46,000 |
| Duplicate video IDs in videos | 0 |
| Duplicate video/date/country records | 0 |
| Videos with missing category references | 0 |
| Trending records with missing video references | 0 |

The database structure, import guidance, and SQL queries are available in `part4.sql`.

### 5. SQL Queries and Results

The following queries demonstrate SELECT, WHERE, ORDER BY, LIMIT, DISTINCT, aliases, aggregate functions, GROUP BY, HAVING, INNER JOIN, LEFT JOIN, and RIGHT JOIN.

#### Query 1 – SELECT and WHERE

```sql
SELECT video_id, country, views, likes, comment_count
FROM trending_records
WHERE country = 'US' AND views >= 1000000
LIMIT 10;
```

**Result:** Returned 10 US trending records with at least 1 million views.

#### Query 2 – ORDER BY and LIMIT

```sql
SELECT video_id, country, trending_date, views
FROM trending_records
ORDER BY views DESC
LIMIT 10;
```

**Result:** Returned the 10 records with the highest views. The highest record had 360,760,164 views.

#### Query 3 – DISTINCT

```sql
SELECT DISTINCT country
FROM trending_records
ORDER BY country;
```

**Result:**

| Country |
|---|
| GB |
| IN |
| US |

#### Query 4 – Aliases and Aggregate Functions

```sql
SELECT
    country AS country_name,
    ROUND(AVG(views), 2) AS average_views,
    SUM(likes) AS total_likes,
    SUM(comment_count) AS total_comments
FROM trending_records
GROUP BY country
ORDER BY average_views DESC;
```

**Result:**

| Country | Average views | Total likes | Total comments |
|---|---:|---:|---:|
| GB | 1,584,041.32 | 978,784,527 | 60,735,115 |
| US | 1,013,904.38 | 632,843,352 | 49,919,896 |
| IN | 952,100.76 | 497,075,672 | 48,084,115 |

#### Query 5 – GROUP BY, HAVING and INNER JOIN

```sql
SELECT
    c.category_name,
    COUNT(*) AS record_count,
    ROUND(AVG(tr.views), 2) AS average_views
FROM trending_records tr
INNER JOIN videos v
    ON tr.video_id = v.video_id
INNER JOIN categories c
    ON v.category_id = c.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(*) >= 1000
ORDER BY average_views DESC;
```

**Result:** Returned 12 categories with at least 1,000 trending records.

| Category | Record count | Average views |
|---|---:|---:|
| Music | 10,310 | 3,190,950.48 |
| Entertainment | 12,270 | 901,025.65 |
| Comedy | 3,258 | 603,475.66 |
| Film & Animation | 2,297 | 577,974.02 |
| People & Blogs | 3,804 | 551,234.12 |
| Gaming | 2,057 | 509,664.94 |
| Sports | 1,921 | 374,978.16 |
| Education | 1,645 | 362,716.27 |
| Science & Technology | 1,562 | 356,350.41 |
| Howto & Style | 1,825 | 299,684.77 |
| News & Politics | 2,422 | 283,794.75 |
| Autos & Vehicles | 1,007 | 279,692.67 |

#### Query 6 – INNER JOIN

```sql
SELECT
    v.video_id,
    v.title,
    c.category_name,
    tr.country,
    tr.views
FROM trending_records tr
INNER JOIN videos v
    ON tr.video_id = v.video_id
INNER JOIN categories c
    ON v.category_id = c.category_id
ORDER BY tr.views DESC
LIMIT 10;
```

**Result:** Returned 10 highest-view trending records with video titles and category names.

#### Query 7 – LEFT JOIN

```sql
SELECT
    c.category_name,
    COUNT(v.video_id) AS total_videos
FROM categories c
LEFT JOIN videos v
    ON c.category_id = v.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_videos DESC;
```

**Result:**

| Category | Videos |
|---|---:|
| Entertainment | 3,387 |
| Music | 1,883 |
| News & Politics | 1,381 |
| People & Blogs | 1,331 |
| Comedy | 1,129 |
| Film & Animation | 829 |
| Sports | 797 |
| Gaming | 767 |
| Howto & Style | 743 |
| Science & Technology | 660 |
| Education | 654 |
| Autos & Vehicles | 415 |
| Pets & Animals | 395 |
| Travel & Events | 328 |

#### Query 8 – RIGHT JOIN

```sql
SELECT
    c.category_name,
    COUNT(v.video_id) AS total_videos
FROM videos v
RIGHT JOIN categories c
    ON v.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_videos DESC;
```

**Result:** Returned all 14 categories and their video counts. The results matched Query 7.

### 6. Excel Analysis

The Excel workbook `TrendPulse_Analysis (1).xlsx` contains the following worksheets:

| Worksheet | Purpose |
|---|---|
| Categories | Category IDs and names |
| Videos | Unique video information |
| Trending_Records | Trending observations |
| Summary | Key metrics and formulas |
| Category_Pivot | Average views by category and country |
| Pivot_Source | Source data for the native Excel PivotTable |
| PivotTable sheet | Native PivotTable analysis |

#### Spreadsheet functions and features

The workbook demonstrates:

- `COUNTIF` to count records based on conditions.
- `SUM` to calculate total views.
- `AVERAGE` to calculate average views.
- `VLOOKUP` to retrieve category names from category IDs.
- A named range (`TotalViews`) used in a formula.
- Filters and sorting.
- Conditional formatting to highlight the top 10% of view counts.
- A PivotTable showing average views by category and country.

Example formulas:

```excel
=COUNTIF(Trending_Records!C:C,"US")
=SUM(Trending_Records!D:D)
=AVERAGE(Trending_Records!D:D)
=VLOOKUP(D3,Categories!A:B,2,FALSE)
=SUM(TotalViews)
```

The native PivotTable uses:

- Rows: `category_name`
- Columns: `country`
- Values: Average of `views`

### 7. SQL and Excel Cross-Validation

The average views by country were compared between SQL Query 4 and the Excel PivotTable.

| Country | SQL average views | Excel average views |
|---|---:|---:|
| GB | 1,584,041.32 | 1,584,041.317 |
| IN | 952,100.76 | 952,100.7641 |
| US | 1,013,904.38 | 1,013,904.378 |

The results match, allowing for rounding differences.

### 8. Key Observations

1. Music had the highest average views across all three countries.
2. Great Britain had the highest overall average views among the three countries.
3. Entertainment had the largest number of unique videos in the database.
4. India had the largest number of Entertainment trending records.
5. The SQL and Excel country-level average views matched.

These are observations from the supplied synthetic educational dataset, not claims about real-world YouTube performance.

### 9. How to Reproduce

1. Open `part4.ipynb` in Google Colab or Jupyter Notebook.
2. Ensure the three prepared CSV files are available in the expected data folder.
3. Execute the notebook cells from top to bottom.
4. Create the MySQL database and tables using `part4.sql`.
5. Import the CSV files in the order described above.
6. Execute the SQL queries in MySQL Workbench or MySQL Shell.
7. Open the Excel workbook to inspect the formulas, PivotTable, and analysis.

### 10. Conclusion

Part 4 demonstrates relational database design, CSV data import, SQL querying, joins, aggregation, and spreadsheet analysis. The SQL and Excel results were cross-validated to ensure consistency across both tools.

This completes the SQL and Spreadsheet Analysis component of TrendPulse.