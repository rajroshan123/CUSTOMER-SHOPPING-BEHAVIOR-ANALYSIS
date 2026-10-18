# CUSTOMER-SHOPPING-BEHAVIOR-ANALYSIS
DATA ANALYTICS PROJECT OF SHOWCASING CUSTOMER SHOPPING BEHAVIOR USING PYTHON MYSQL AND POWERBI
# Customer Shopping Behavior Analysis

End-to-end data analytics project: **Python (EDA + cleaning) → MySQL (SQL analysis) → Power BI (dashboard) → Report and PPT (Gamma)**.

---

## 1. Overview

This project analyzes 3,900 customer purchases to understand who buys, what they buy, how much they spend, and how subscriptions, discounts, and shipping affect spending. Raw data is cleaned in Python, stored in MySQL, queried with SQL, and presented in an interactive Power BI dashboard.

**Business questions answered**
- Which genders and age groups generate the most revenue?
- Do subscribers spend more than non-subscribers?
- Which products have the highest ratings and the highest discount rates?
- Does express shipping lead to higher spend than standard shipping?
- How do new, returning, and loyal customers split?
- Which products sell best in each category?

---

## 2. Dataset

- **Source file:** `customer_shopping_behavior.csv`
- **Size:** 3,900 rows, 18 columns (after cleaning: 19 columns)

| Column | Description |
|---|---|
| customer_id | Unique customer ID |
| age, gender | Customer demographics |
| item_purchased, category | Product and its category (4 categories, 25 items) |
| purchase_amount | Purchase value in USD |
| location, size, color, season | Order details |
| review_rating | Customer rating |
| subscription_status | Subscriber (Yes/No) |
| shipping_type, payment_method | Delivery and payment type |
| discount_applied | Whether a discount was used |
| previous_purchases | Number of earlier purchases |
| frequency_of_purchases | How often the customer buys |
| age_group *(new)* | Age quartile: young_adult, adult, middle_age, senior |
| purchase_frequency_days *(new)* | Purchase frequency converted to days |

---

## 3. Tools

| Purpose | Tool |
|---|---|
| EDA and cleaning | Python, pandas |
| Notebook | Jupyter in VS Code |
| Python to MySQL | SQLAlchemy, PyMySQL |
| Database and queries | MySQL 8, MySQL Workbench |
| Dashboard | Power BI Desktop |
| Presentation | Gamma |

---

## 4. Steps

### Step 1: Load and explore (Python)
- Loaded the CSV with pandas.
- Checked structure with `head()`, `info()`, `describe(include="all")`, and `isnull().sum()`.

### Step 2: Clean and engineer features (Python)
- **Missing values:** 37 missing `review_rating` values were filled with the **median of each category**, not the overall median.
- **Column names:** converted to lowercase with underscores; renamed `purchase_amount_(usd)` to `purchase_amount`.
- **Age groups:** created `age_group` using `pd.qcut` (4 equal-sized quartiles).
- **Purchase frequency:** mapped text frequencies (Weekly, Monthly, Quarterly, and so on) to `purchase_frequency_days`.
- **Redundant column:** dropped `promo_code_used` after confirming it is identical to `discount_applied`.

### Step 3: Load into MySQL
- Created the `customer_behavior` database.
- Exported the cleaned DataFrame to the `customer` table with `df.to_sql()`.

### Step 4: SQL analysis
Ten business questions answered in `CUSTOMER_BEHAVIOR_QUESTIONS.sql`:

| # | Question | SQL techniques |
|---|---|---|
| 1 | Revenue by gender | GROUP BY, SUM |
| 2 | Customers who spend above average even with a discount | Subquery |
| 3 | Top 5 products by average review rating | AVG, ORDER BY, LIMIT |
| 4 | Average spend: standard vs express shipping | WHERE IN, AVG |
| 5 | Do subscribers spend more? | COUNT, AVG, SUM |
| 6 | Top 5 products by discount rate | CASE WHEN |
| 7 | Segment customers into new, returning, loyal | CTE, CASE WHEN |
| 8 | Top products within each category | CTE, ROW_NUMBER, PARTITION BY |
| 9 | Are repeat buyers (more than 5 purchases) subscribers? | Filtering, GROUP BY |
| 10 | Revenue contribution by age group | GROUP BY, SUM |

### Step 5: Power BI dashboard
- Connected Power BI to MySQL (`customer_behavior.customer`).
- Created DAX measures: Number of Customers, Average Purchase Amount, Average Review Rating.
- Built KPI cards, charts, and slicers (see below).

### Step 6: Report and presentation
- Summarized findings in a report.
- Built a presentation with Gamma.

---

## 5. Dashboard

**File:** `CUSTOMER_BEHAVIOR_DASHBOARD.pbix`

![Customer Behavior Dashboard](images/dashboard.png)

- **KPI cards:** Number of Customers (3.9K), Average Review Rating (3.75), Average Purchase Amount ($59.76)
- **Donut chart:** % of customers by subscription status (Yes 27%, No 73%)
- **Revenue and sales by category:** column charts
- **Revenue and sales by age group:** bar charts
- **Filters:** subscription status, gender, category, and shipping type

---

## 6. Results

- **Total revenue is about $233K** across 3,900 customers, with an average purchase of $59.76 and an average rating of 3.75.
- **Clothing leads revenue** (roughly $105K), followed by Accessories (about $75K), Footwear (about $37K), and Outerwear (about $18K).
- **Subscribers are a minority:** only 27% of customers subscribe, so there is room to grow subscriptions.
- **Young adults generate the most revenue** (about $62K), but the gap to other age groups is small (senior is about $55K), so spending is fairly even across ages.
- **Still to add from your SQL outputs:** subscriber vs non-subscriber spend (Question 5), express vs standard shipping (Question 4), and the new/returning/loyal split (Question 7).
- **Recommendation:** *(for example, promote subscriptions and focus Clothing and Accessories campaigns on young adults)*

---

## 7. How to Run

1. **Install packages**
   ```bash
   pip install pandas sqlalchemy pymysql cryptography
   ```
2. **Start MySQL** and note your username and password.
3. **Open** `EDA_OF_CUSTOMER_SHOPPING_BEHAVIOR.ipynb` in VS Code. Update the CSV path, and enter your MySQL password using `getpass` or an environment variable (never hard-code it).
4. **Run all cells** to clean the data and load the `customer` table into `customer_behavior`.
5. **Run the queries** in `CUSTOMER_BEHAVIOR_QUESTIONS.sql` using MySQL Workbench.
6. **Open** `CUSTOMER_BEHAVIOR_DASHBOARD.pbix` in Power BI Desktop. If asked, install **MySQL Connector/NET**, then refresh the data.

---

## 8. Project Structure

```
customer-shopping-analysis/
├── data/customer_shopping_behavior.csv
├── EDA_OF_CUSTOMER_SHOPPING_BEHAVIOR.ipynb
├── CUSTOMER_BEHAVIOR_QUESTIONS.sql
├── CUSTOMER_BEHAVIOR_DASHBOARD.pbix
├── images/dashboard.png
├── reports/ (report and Gamma PPT)
└── README.md
```

---

## 9. Author

**Raj Roshan** | LinkedIn: *(add link)* | GitHub: *(add link)*

