# SQL Data Hygiene: Hearing Wellness Survey

## Overview
This project demonstrates **data cleaning and preprocessing** of a hearing wellness survey dataset using **PostgreSQL**.  
Clean, standardized data ensures reliable analysis, visualization, and insights.  

**Dataset:** [Hearing Wellness Survey on Kaggle](https://www.kaggle.com/datasets/adharshinikumar/2025-hearing-wellness-survey)

---

## Steps

1. **Setup**
   - Created database `hearing_wellness_db` and table `hearing_survey`.
   - Imported survey CSV into PostgreSQL.

2. **Data Inspection**
   - Checked structure, types, and missing values.
   - Previewed first 10 rows.

3. **Text Standardization**
   - Replaced special characters (curly quotes, dashes, ellipsis).
   - Removed non-ASCII characters.

4. **Duplicates & Primary Key**
   - Verified no duplicate rows.
   - Added `id SERIAL PRIMARY KEY`.

5. **Column Cleaning & Normalization**
   - `daily_headphone_use`: grouped time intervals.
   - `interest_in_hearing_app`: standardized Yes/No/Maybe.
   - `missed_important_sounds`: corrected typos.
   - `hearing_test_barrier`: split multi-responses and categorized.
   - `desired_app_features`: normalized multi-select features.
   - Created mapping/normalized tables for structured analysis.

---

## Outcome
- Dataset is **clean, consistent, and free of duplicates**.  
- Textual and categorical data standardized for meaningful analysis.  
- Normalized tables allow aggregation and visualization of survey responses.  

---

## Usage
1. Clone the repository.  
2. Run `hearing_survey_data_cleaning.sql` in PostgreSQL.  
3. Query normalized tables for analysis and visualization.
