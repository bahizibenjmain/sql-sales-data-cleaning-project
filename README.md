# SQL Data Cleaning Project

## Project Overview
This project demonstrates how to clean and standardize messy sales data using SQL.  
The dataset contained duplicates, inconsistent date formats, missing values, and inconsistent text formatting.

The goal was to prepare the dataset for reliable analysis.

---

## Dataset
The dataset contains:

- OrderID
- CustomerID
- CustomerName
- Email
- ProductName
- Category
- Quantity
- UnitPrice
- TotalPrice
- OrderDate

---

## Data Cleaning Tasks

### 1. Create Working Table
A copy of the raw dataset was created to avoid modifying the original data.

### 2. Remove Duplicate Records
Used `ROW_NUMBER()` window function to identify duplicate records.

### 3. Handle Missing Values
Removed rows where critical fields (CustomerName) were empty or NULL.

### 4. Standardize Text Data
Trimmed whitespace and standardized category names.

### 5. Clean Date Formats
Used `REGEXP` and `STR_TO_DATE()` to convert inconsistent date formats into a standard SQL DATE format.

### 6. Create Transaction Type
Created a new column to classify:

- Sales
- Returns
- No Sales

### 7. Standardize Email Domains
Replaced gmail.com.com domains with gmail.com for consistency.

---

## SQL Techniques Used

- CTE (Common Table Expressions)
- Window Functions
- CASE Statements
- REGEXP
- STR_TO_DATE()
- TRIM()
- REPLACE()
- ROUND()

---

## Tools Used
- MySQL
- SQL

---

## Author
Bahizi Sebujisho Benjamin
