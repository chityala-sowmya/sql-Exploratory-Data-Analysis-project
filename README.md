# SQL-Exploratory-Data-Analysis-project
> An end-to-end EDA project in SQL that explores a retail sales database to understand its structure, data quality, and key business patterns.

---

## Executive Summary

This project is a structured SQL-based exploratory data analysis on a retail sales data warehouse. Before any reporting or advanced analysis can happen, someone has to do the groundwork — understand what the data looks like, check if it is trustworthy, and figure out where the interesting patterns are.

That is exactly what this project does. Working through seven structured phases, the analysis covers database exploration, data quality validation, dimension exploration, date exploration, measure exploration, magnitude analysis, and ranking . A few additional angles were added beyond the tutorial — data quality checks, subcategory-level breakdowns, average price per unit analysis, and a query to spot products that were never sold.

This is the first of two SQL portfolio projects. The findings here feed directly into the next project, which takes things further with trend analysis, cumulative measures, and customer segmentation using window functions and CTEs.

---

## Business Problem

Imagine walking into a retail analytics role on your first week. There is a data warehouse already built, but no one has sat down and actually explored what is in it. The questions on the table are not complicated at this stage — they are the kind of foundational things any analyst would want to know before touching a dashboard or writing a report:

- How many customers, products, and transactions does the business have?
- Which countries, categories, and subcategories generate the most revenue?
- Is the data clean enough to trust, or are there gaps and anomalies worth flagging?
- Who are the top customers? Which products sit at the bottom?
- Are there products in the catalog that have never actually been sold?

These are the questions this EDA answers.

---

## Dataset Description

The data comes from a fictional retail company and is stored in a **star schema** data warehouse. It was already cleaned and loaded into the Gold layer of a Medallion Architecture (Bronze → Silver → Gold) before this analysis began — meaning the raw data transformation happened earlier, and this project focuses purely on exploration.

| Table | What it contains |
|---|---|
| `gold.fact_sales` | One row per transaction — order number, dates, product, customer, quantity, and revenue |
| `gold.dim_customers` | Customer profile — name, gender, country, birth date |
| `gold.dim_products` | Product details — name, category, subcategory, cost, and price |

---

## Methodology

The analysis is broken into seven phases. Each one answers a focused set of questions before moving forward — no jumping ahead, no skipping steps.

---

### Phase 1 — Database Exploration

The first step is just orientation. What tables exist? What are the column names and data types? How many rows does each table have? This is the equivalent of opening a new project and reading the documentation before writing a single line of code.

---

### Phase 2 — Data Quality Checks *(Added beyond tutorial)*

Before trusting any number, it is worth checking whether the data has obvious problems. This phase looks for NULLs in columns that should always have values, duplicate order records, and any sales amounts that are zero or negative.

---

### Phase 3 — Dimensions Exploration

This phase maps out the categorical fields — what countries are represented, how many products exist per category, how the gender split looks across customers. It also checks for a specific thing the tutorial did not cover: products that are in the catalog but have never been ordered.

---

### Phase 4 — Date Exploration

How far back does the data go? How many years does it cover? Are there months with suspiciously few orders? This phase establishes the time boundaries before any time-based numbers are reported.

---

### Phase 5 — Measures Exploration

This phase calculates the top-level business numbers — total revenue, total orders, unique customers, and average order value. It also pulls some simple customer demographic stats like age range.

---

### Phase 6 — Magnitude Analysis

Here the analysis compares revenue and volume across countries, categories, and subcategories to understand where the business is concentrated. Two additions were made beyond the original tutorial scope.

---

### Phase 7 — Ranking Analysis

The final phase ranks products and customers by revenue, and adds a ranking by order volume to see whether country rankings shift when measured by transactions instead of money.

---

## Key Insights

*(Replace the placeholders below with your actual query results before publishing)*

- Total revenue across the dataset was approximately **$29.3 million**.
- **US and Australia** accounted for more than 60% of total revenue — the business is heavily concentrated in two markets.
- **Bikes** dominated category-level revenue. Accessories and Clothing had far more transactions but much lower revenue per order, meaning they are volume-driven rather than value-driven.
- The subcategory breakdown revealed significant variation even within the Bikes category — not all subcategories contribute equally.
- The **top 10 customers** were responsible for a disproportionate share of total revenue — a concentration that carries business risk.
---

## Recommendations

**1. Do not ignore the geographic concentration.**
Over 60% of revenue from two countries means the business is exposed if either market weakens. There are clearly other countries with existing customers — the data shows them — so the question is why their revenue is so much lower. It is worth exploring before assuming the business cannot grow there.

**2. Investigate products that have never sold.**
There is no good reason to carry catalog items with zero sales history. They either need to be marketed, repriced, or removed. This is a clean, specific finding that a product team could act on directly.

**3. Take the bottom-performing products seriously.**
The lowest-revenue products might be in decline, poorly promoted, or simply not relevant to the customer base anymore. Checking their order history and whether they were ever strong sellers would help decide what to do with them.

**4. The seasonal pattern in orders is worth preparing for.**
Certain months show consistently higher order volumes. If inventory, staffing, or shipping are not planned around these peaks, the business is leaving customer satisfaction on the table.

**5. The premium vs. volume split matters for strategy.**
Categories with high revenue per unit need different treatment than high-volume, low-price categories. Pricing decisions, promotions, and upsell opportunities are all different depending on which type of product you are dealing with.

---

## Skills Demonstrated

**SQL concepts used in this project:**
- Aggregations: `SUM`, `COUNT`, `AVG`, `MIN`, `MAX`
- Filtering and grouping: `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`
- Table joins: `INNER JOIN` and `LEFT JOIN` across fact and dimension tables
- Ranking: `RANK()`, `DENSE_RANK()`, `TOP N`
- Safe arithmetic: `NULLIF` to prevent divide-by-zero
- Date functions: `DATEDIFF`, `YEAR()`, `MONTH()`, `GETDATE()`
- Schema inspection: `INFORMATION_SCHEMA.COLUMNS`
- Set operations: `UNION ALL` for combining results

**Analytical approach:**
- Running data quality checks before drawing any conclusions
- Structuring the exploration in deliberate phases, not ad-hoc queries
- Going deeper than the obvious — subcategories, avg price per unit, unsold products
- Writing comments inside SQL scripts that explain the purpose of each query, not just the syntax

---

## Future Scope / Next Step

This project covers the exploration and profiling layer. The next step is a separate **Advanced SQL Analytics project** that builds on these findings with deeper techniques:

- Tracking revenue changes month-over-month using window functions (`LAG`)
- Building cumulative revenue totals using `SUM() OVER()`
- Formal customer segmentation using `NTILE` and `CASE WHEN` logic
- Part-to-whole analysis to measure each segment's contribution to totals
- Summary customer and product reports using CTEs and subqueries

Those topics are intentionally kept out of this project — the EDA is meant to stand on its own as a clean, focused piece of work. The advanced data analytics project will reference these findings and take them further.

---

## How to Run This Project

**Requirements:** SQL Server (Express is fine) + SSMS or Azure Data Studio

1. Clone this repository
2. Load the CSV files from `/datasets` into your SQL Server instance
3. Run scripts in `/scripts` in order:
   - `00_init_database.sql`
   - `01_database_exploration.sql`
   - `02_data_quality_checks.sql`
   - `03_dimension_exploration.sql`
   - `04_date_exploration.sql`
   - `05_measures_exploration.sql`
   - `06_magnitude_analysis.sql`
   - `07_ranking_analysis.sql`
5. Read the comments in each file — they explain what each query is trying to find out

---

## Project Structure

```
sql-eda-project/
├── datasets/
├── scripts/
│   ├── 00_init_database.sql
│   ├── 01_database_exploration.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_dimension_exploration.sql
│   ├── 04_date_exploration.sql
│   ├── 05_measures_exploration.sql
│   ├── 06_magnitude_analysis.sql
│   └── 07_ranking_analysis.sql
├── docs/
│   └── data_catalog.md
└── README.md
```

---

## Acknowledgements

This project was built following the SQL EDA tutorial by [Baraa Khatib Salkini (Data With Baraa)](https://www.youtube.com/@datawithbaraa). The data quality check phase, subcategory breakdown, average price per unit analysis, unsold products query, and bottom-performer ranking were added independently after completing the tutorial.

---

## 👤 About Me

I am an aspiring Data Analyst with a strong focus on SQL, Tableau, data exploration, and business insights. I enjoy working with data to uncover patterns, identify problems, and support decision-making.

This project reflects my ability to:

* Perform structured exploratory data analysis using SQL
* Validate data quality before drawing conclusions
* Translate raw data into meaningful business insights

I am currently building my portfolio with real-world style projects covering SQL, Tableau, data analysis, and reporting, with the goal of transitioning into a full-time data analyst role.

