# HR Analytics Project — IBM Attrition Dataset
### Author: Harshit Panchal | Tools: SQL (PostgreSQL) + Excel

---

## Project Overview
This project analyzes employee attrition data from IBM's HR dataset (1,470 employees).
The goal is to identify key factors that drive employees to leave the company and provide
actionable insights to reduce attrition.

---

## Files in This Project

| File | Description |
|------|-------------|
| `HR_Analytics_Dataset.xlsx` | Main Excel file with raw data, summary dashboard & data dictionary |
| `01_create_table.sql` | Creates the PostgreSQL table and explains how to import data |
| `02_basic_analysis.sql` | 8 basic queries — attrition by dept, role, gender, overtime, etc. |
| `03_advanced_analysis.sql` | 12 advanced queries — CASE, HAVING, Subquery, COALESCE, UNION |
| `README.md` | This guide |

---

## How to Run This Project

### Step 1 — Set up PostgreSQL
1. Open **pgAdmin4**
2. Right-click **Databases** → **Create** → **Database**
3. Name it: `hr_analytics`

### Step 2 — Create the table
1. Open `01_create_table.sql` in pgAdmin4 Query Tool
2. Run the full script (F5)
3. This creates the `hr_employees` table

### Step 3 — Import the data
1. Open `HR_Analytics_Dataset.xlsx`
2. Go to the **HR_Dataset** sheet
3. Save it as **CSV**: File → Save As → CSV (comma delimited)
4. In pgAdmin4: right-click `hr_employees` → **Import/Export Data**
5. Select your CSV file → Header = **Yes** → Delimiter = **,** → Click OK
6. Run: `SELECT COUNT(*) FROM hr_employees;` — should return **1470**

### Step 4 — Run basic queries
1. Open `02_basic_analysis.sql` in pgAdmin4
2. Run each query one by one (select the query → F5)
3. Study the results — note which departments/roles have highest attrition

### Step 5 — Run advanced queries
1. Open `03_advanced_analysis.sql`
2. Run each query — these use CASE, HAVING, Subqueries, COALESCE, UNION ALL
3. Query 17 is the most important — it identifies high-risk employees

---

## Key Concepts Used in SQL Scripts

| Concept | Query # | What it does |
|---------|---------|--------------|
| COUNT + GROUP BY | 2, 3, 5, 6, 7 | Count employees per group |
| CASE WHEN | 4, 8, 9, 10 | Create categories from numbers |
| HAVING | 15, 18 | Filter after GROUP BY |
| COALESCE | 12 | Replace NULL values safely |
| Subquery + JOIN | 14 | Compare each employee to dept average |
| UNION ALL | 20 | Combine multiple query results |
| ORDER BY + LIMIT | 13 | Top N results |
| WHERE (multi-condition) | 17 | Filter on multiple columns |

---

## Key Findings (from the data)

1. **Overall attrition rate is ~16%** — 237 out of 1,470 employees left
2. **Sales has the highest attrition** (~20%) vs R&D (~14%)
3. **Employees who work overtime are 2x more likely to leave**
4. **Frequent business travellers have higher attrition** than non-travellers
5. **Lower income = higher attrition** — most leavers earn below $5K/month
6. **Younger employees (25-30) leave more** than senior employees

---
