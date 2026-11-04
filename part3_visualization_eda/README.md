# Part 3 – Data Visualization, Exploratory Data Analysis (EDA), and Business Insights

## 1. Project Overview

This part of TrendPulse focuses on exploring and understanding video-trending data using Python, Pandas, NumPy, Matplotlib, Seaborn, and Plotly.

The objective is to identify patterns in video views, engagement, categories, countries, and trending duration through statistical analysis and visualizations.

## 2. Dataset

- **Dataset:** TrendPulse cleaned video-trending dataset
- **Total Records:** 46,000
- **Total Columns:** 20
- **Countries:** US, GB, IN
- **Categories:** 14

The dataset is synthetic and was provided for this project. Results are used for analytical learning and should not be interpreted as actual YouTube platform statistics.

## 3. Data Cleaning and Preparation

- Loaded the cleaned dataset from Part 2 using Pandas.
- Handled missing descriptions by replacing null values with empty strings.
- Removed extra spaces from category names.
- Converted trending dates and publishing timestamps into datetime formats.
- Checked and removed duplicate records.
- Verified missing values and dataset dimensions.

**Final dataset:** 46,000 rows × 20 columns, with zero missing values and zero duplicate rows.

## 4. Data Visualization

Created five Matplotlib/Seaborn visualizations:

1. Bar chart – Video records by category.
2. Histogram – Distribution of video views using a logarithmic scale.
3. Scatter plot – Relationship between views and likes.
4. Line chart – Daily trending record counts.
5. Boxplot – Distribution of video views across countries.

Created two interactive Plotly visualizations:

1. Average views by category.
2. Relationship between views and likes, colored by country.

## 5. Statistical Analysis

Calculated mean, median, mode, and skewness for video views.

| Metric | Result |
|---|---:|
| Mean | 1,179,665.24 |
| Median | 318,389 |
| Mode | 16,000 |
| Skewness | 27.96 |

The mean is much higher than the median because a small number of records have extremely high view counts. The distribution is strongly positively skewed.

## 6. Outlier Detection

Used the Interquartile Range (IQR) method to identify unusually high or low view counts.

| Metric | Result |
|---|---:|
| Q1 | 129,453.75 |
| Q3 | 824,049.50 |
| IQR | 694,595.75 |
| Lower Bound | -912,439.88 |
| Upper Bound | 1,865,943.12 |
| Outlier Records | 5,079 |
| Outlier Percentage | 11.04% |

Outliers were identified but not automatically removed because high-view records may represent meaningful trending videos.

## 7. Correlation Analysis

Calculated correlations between views, likes, dislikes, and comments.

The two strongest positive relationships were:

- Views and Likes: 0.921
- Views and Comments: 0.916

These values indicate strong positive associations. Correlation does not necessarily imply causation.

## 8. Performance Funnel

Created a simple performance funnel based on view and like thresholds.

| Stage | Records | Percentage |
|---|---:|---:|
| All records | 46,000 | 100% |
| Views ≥ 100K | 37,193 | 80.85% |
| Views ≥ 1M | 9,686 | 21.06% |
| Views ≥ 1M and Likes ≥ 50K | 6,718 | 14.60% |

## 9. Trending Duration Analysis

Measured the number of distinct observed trending days for each video-country combination.

| Trending Days | Combinations | Percentage |
|---|---:|---:|
| At least 2 days | 9,477 | 62.93% |
| At least 3 days | 6,276 | 41.68% |
| At least 5 days | 2,896 | 19.23% |
| At least 7 days | 1,462 | 9.71% |

This measures observed trending duration, not viewer retention or consecutive trending days.

## 10. Cohort Analysis

Grouped video-country combinations by their first observed trending week and month.

Monthly cohort results:

| Month | First Trending Combinations |
|---|---:|
| November 2017 | 3,675 |
| December 2017 | 5,905 |
| January 2018 | 5,413 |
| February 2018 | 66 |

December 2017 had the highest number of first-observed trending combinations. February represents only a partial month in this dataset.

Cohorts are based on the first observed trending date, not the original video publishing date.

## 11. Business Insights and Content Strategy

- Entertainment and Music have the highest record counts, with 12,270 and 10,310 records respectively.
- Average views are much higher than median views, showing that a small number of high-view records influence the average.
- Views have strong positive correlations with likes and comments.
- Only 9.71% of video-country combinations appeared for at least seven distinct trending days.
- The US contributes 16,000 records, while GB and IN contribute 15,000 each.
- Category performance, engagement, and publishing-time patterns can be explored to identify potential content opportunities.
- Since this is a synthetic dataset, these findings are analytical examples and should not be treated as real-world YouTube trends.

## 12. Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Plotly
- Google Colab
- Git and GitHub

## 13. How to Run

1. Open `part3.ipynb` in Google Colab or Jupyter Notebook.
2. Ensure the dataset is available in the expected `data` folder.
3. Update the dataset path in the loading cell if necessary.
4. Run all notebook cells from top to bottom.

## 14. Project Files

- `part3.ipynb` – Data cleaning, statistical analysis, visualizations, and business insights.
- `data/cleaned_trendpulse.csv` – Cleaned dataset used for Part 3 analysis.
- Other CSV files – Source datasets retained for reference.
