# Part 1 – Python Foundations & Data Structures

## Project: TrendPulse

### 1. Objective
This part explores YouTube trending video statistics from the US, GB, and India using Python fundamentals, Pandas, and Python data structures.

### 2. Dataset
The dataset contains:
- USvideos.csv
- GBvideos.csv
- INvideos.csv
- categories.csv

Total original records: 46,230.

### 3. Tools and Libraries
- Python
- Google Colab
- Pandas
- NumPy
- pathlib
- string

### 4. Implementation

The notebook covers:

1. Loading country datasets using a reusable `load_country()` function.
2. Combining datasets and adding country information.
3. Mapping category IDs to category names.
4. Inspecting missing values and duplicate records.
5. Cleaning missing values and converting data types.
6. Converting trending and publishing dates.
7. Creating lists of dictionaries and tuples.
8. Using sets to find unique and common video IDs.
9. Creating nested dictionaries for country-wise category counts.
10. Extracting title features using `title_features()`.
11. Practising for loops, while loops, break, and continue.
12. Classifying videos using `classify_video()`.

### 5. Data Cleaning Decisions

- Missing likes and comment counts were filled using the median within each country.
- Missing descriptions were replaced with empty strings.
- Numeric columns were converted to appropriate numeric types.
- Status columns were converted to Boolean values.
- `trending_date` was converted using the `yy.dd.mm` format.
- `publish_time` was converted to UTC datetime.
- Duplicate records were inspected rather than automatically deleted.

### 6. Outputs

- `cleaned_trendpulse.csv` – cleaned combined dataset.
- `part1.ipynb` – notebook containing the Python implementation.

### 7. How to Run

1. Open `part1.ipynb` in Google Colab.
2. Upload or mount Google Drive.
3. Keep the CSV files inside the `data` folder.
4. Update the data folder path if required.
5. Run all notebook cells from top to bottom.

### 8. Conclusion

Part 1 demonstrates Python fundamentals and data structures through a practical dataset-cleaning and video-classification workflow. It prepares the dataset for further analysis in the next project parts.