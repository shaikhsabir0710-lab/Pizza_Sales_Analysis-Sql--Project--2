# 🍕 Pizza Sales Analysis Project (sql)-2

## 📌 Project Overview

This project focuses on analyzing pizza sales data using **PostgreSQL**. The objective is to answer real-world business questions related to orders, revenue, customer demand patterns, and product performance by writing efficient SQL queries.

## This project demonstrates:

* Strong understanding of **SQL joins**
* Use of **aggregate functions**
* Application of **CTEs (WITH clause)**
* Use of **window functions (RANK, OVER)**
* Business-oriented data analysis mindset

---

## 🗂️ Database Schema

The database consists of **4 related tables**:

### 1️⃣ ORDERS

Stores order-level information.

* `order_id` (Primary Key)
* `order_date`
* `ord_time`

### 2️⃣ PIZZA_TYPES

Stores pizza type details.

* `pizza_type_id` (Primary Key)
* `name`
* `category`
* `ingredients`

### 3️⃣ PIZZAS

Stores pizza size and pricing information.

* `pizza_id` (Primary Key)
* `pizza_type_id` (Foreign Key)
* `size`
* `price`

### 4️⃣ ORDER_DETAILS

Stores order-item level data.

* `order_details_id` (Primary Key)
* `order_id` (Foreign Key)
* `pizza_id` (Foreign Key)
* `quantity`

---

## 🎯 Business Problems Solved

### 🔹 Basic Analysis

1. Total number of orders placed
2. Total revenue generated from pizza sales
3. Highest-priced pizza
4. Most common pizza size ordered
5. Top 5 most ordered pizza types

### 🔹 Intermediate Analysis

6. Total quantity ordered per pizza category
7. Distribution of orders by hour of the day
8. Category-wise distribution of pizzas
9. Average number of pizzas ordered per day
10. Top 3 pizza types based on revenue

### 🔹 Advanced Analysis

11. Percentage contribution of each pizza type to total revenue
12. Cumulative revenue generated over time
13. Top 3 pizza types by revenue for each category

---

## 🧠 Key SQL Concepts Used

* **JOINs**: INNER JOIN across multiple tables
* **Aggregate Functions**: `SUM()`, `COUNT()`, `AVG()`
* **Date & Time Functions**: `EXTRACT(HOUR FROM time)`
* **CTEs (WITH clause)** for better readability
* **Window Functions**:

  * `RANK() OVER (PARTITION BY ...)`
  * `SUM() OVER (ORDER BY ...)` for cumulative totals

---

## 📊 Highlighted Advanced Query Logic

### ✅ Cumulative Revenue Over Time

* First calculate daily revenue
* Then apply a window function to compute running totals

### ✅ Top 3 Pizza Types per Category

* Revenue calculated using `price × quantity`
* `RANK()` used with `PARTITION BY category`
* Filters top 3 pizza types within each category

---

## 📈 Business Insights Derived

* Identified high-revenue pizza categories
* Found peak ordering hours
* Determined best-performing pizza types
* Analyzed revenue growth trend over time

---

## 🛠️ Tools & Technologies

* **Database**: PostgreSQL
* **Language**: SQL
* **Concepts**: Data Analysis, Business Intelligence

## 🧾 Conclusion

In this Pizza Sales Analysis project, SQL was used to extract meaningful business insights from raw transactional data.
The analysis covered order trends, revenue performance, customer demand patterns, and category-wise product contribution.

By applying joins, aggregate functions, CTEs, and window functions, the project successfully identified top-performing pizza types, peak ordering hours, cumulative revenue growth, and revenue contribution across categories.

This project demonstrates strong SQL fundamentals and a practical data analysis approach that can support real-world business decision-making such as menu optimization, pricing strategy, and demand forecasting.

## 👤 Author

**Sabir Shaikh**
Aspiring Data Analyst | SQL | PostgreSQL | Data Analysis
linkdin Profile - [https://www.linkedin.com/in/sabir-shaikh-64163036a]

---

📌 *Feel free to fork this project, suggest improvements, or build dashboards on top of this analysis.*
