# Part 2 – NumPy and Pandas Analysis

## 1. Project Overview

This part of TrendPulse focuses on using NumPy and Pandas to process, clean, transform and analyze trending video data from three countries: the United States (US), Great Britain (GB) and India (IN).

The objective is to understand video performance, engagement metrics, category distribution, publishing patterns and trending duration through numerical and tabular data analysis.

## 2. Dataset

The project uses four CSV files:

- USvideos.csv
- GBvideos.csv
- INvideos.csv
- categories.csv

The three country datasets were combined into one DataFrame.

- Initial combined records: 46,230
- Final cleaned records: 46,000
- Countries covered: US, GB and IN

**Dataset limitation:** The supplied dataset is synthetic and should not be treated as actual YouTube platform statistics.

## 3. Tools and Libraries

- Python
- NumPy
- Pandas
- Google Colab
- Matplotlib (for later visualization work)

## 4. NumPy Implementation

The following NumPy concepts were implemented:

- Array creation, shape, dtype, indexing and slicing.
- Vectorized arithmetic operations.
- Safe division for like ratios and comment rates.
- Min-max normalization.
- Log transformation using `np.log1p()`.
- Percentile calculation and top 10% selection.
- Array reshaping and flattening.
- Broadcasting for country-wise comparisons.
- NumPy calculations using the actual dataset.

## 5. Pandas Implementation

The following Pandas operations were implemented:

- Loading and combining country datasets using `read_csv()` and `concat()`.
- Dataset inspection using `head()`, `info()`, `describe()` and `shape`.
- Data type conversion and date-time handling.
- Missing value identification and treatment.
- Duplicate record identification and removal.
- Filtering using conditions, `loc()` and `iloc()`.
- Sorting using `sort_values()`.
- Category name mapping using `merge()`.
- Grouping and aggregation using `groupby()` and `agg()`.
- Category counts and percentage calculations.
- Publishing day and hour analysis.
- Days-to-trend calculation.
- Trending lifespan calculation.
- Per-video and per-channel summaries.
- Merging summary DataFrames.

## 6. Data Cleaning Decisions

- Converted `trending_date` into datetime format.
- Converted `publish_time` into UTC datetime format.
- Filled missing `likes` and `comment_count` using country-wise median values.
- Replaced missing descriptions with empty strings.
- Removed duplicate video-date-country records where duplicates existed.
- Merged category names using a left join to preserve video records.

Final validation:
- Missing values: 0
- Remaining duplicate records: 0
- Final dataset shape: 46,000 rows × 18 columns.

## 7. Key Findings

- Music had the highest average views among categories.
- Entertainment had the highest number of trending records (12,270).
- Entertainment represented 26.67% of all trending records.
- Music represented 22.41% of all trending records.
- Tuesday was the most common publishing day.
- 10:00 UTC was the most common publishing hour.
- Average days to trend: approximately 2.80 days.
- Average trending lifespan: approximately 3.05 days.
- The 90th percentile view threshold was approximately 2,025,505 views.

These findings describe the supplied synthetic dataset and should not be generalized to real YouTube trends.

## 8. Output Files

The following output CSV files are generated:

- `cleaned_trendpulse.csv` – cleaned combined dataset.
- `video_summary.csv` – per-video-country performance summary.
- `channel_summary.csv` – per-channel-country performance summary.

## 9. How to Run

1. Open `part2.ipynb` in Google Colab.
2. Mount Google Drive.
3. Ensure the dataset files are available in `part2_numpy_pandas/data/`.
4. Update `DATA_FOLDER` if your folder location differs.
5. Run all notebook cells from top to bottom.
6. The output CSV files will be saved in the data folder.

## 10. Conclusion

This part demonstrates how NumPy and Pandas can be used to clean, transform, summarize and analyze structured datasets. The resulting summaries provide a foundation for the visualization, exploratory data analysis and business interpretation in Part 3.

## 11. Data Summary and Output Usage

The cleaned dataset (`cleaned_trendpulse.csv`) contains the combined and cleaned video records from the US, GB and IN datasets.

The `video_summary.csv` file contains video-level metrics such as peak views, average views, likes, comments, trending days and days to trend.

The `channel_summary.csv` file contains channel-level metrics such as total trending records, unique videos, average views and maximum views.

These output files can be reused in the visualization, exploratory data analysis and SQL sections of the TrendPulse project.