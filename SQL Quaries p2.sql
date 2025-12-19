---- Pizza Sales Analysis Project -2 

-- Tables  Creation --

CREATE TABLE ORDERS (
	ORDER_ID INT PRIMARY KEY,
	ORDER_DATE DATE,
	ORD_TIME TIME
)


CREATE TABLE PIZZA_TYPES (
	PIZZA_TYPE_ID VARCHAR(50) PRIMARY KEY,
	NAME VARCHAR(100),
	CATEGORY VARCHAR(30),
	INGREDIENTS VARCHAR(250)
)

CREATE TABLE PIZZAS (
	PIZZA_ID VARCHAR(50) PRIMARY KEY,
	PIZZA_TYPE_ID VARCHAR(50),
	SIZE VARCHAR(5),
	PRICE DECIMAL,
	FOREIGN KEY (PIZZA_TYPE_ID) REFERENCES PIZZA_TYPES (PIZZA_TYPE_ID)
)

CREATE TABLE ORDER_DETAILS (
	ORDER_DETAILS_ID INT PRIMARY KEY,
	ORDER_ID INT,
	PIZZA_ID VARCHAR(50),
	QUANTITY INT,
	FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
	FOREIGN KEY (PIZZA_ID) REFERENCES PIZZAS (PIZZA_ID)
)

--- Tables views -- 
select * from order_details
select * from orders
select * from pizzas
select * from pizza_types

---- Problems -----

--- Basic ---

--1.Retrieve the total number of orders placed.
--2.Calculate the total revenue generated from pizza sales.
--3.Identify the highest-priced pizza.
--4.Identify the most common pizza size ordered.
--5.List the top 5 most ordered pizza types along with their quantities.


--- Intermediate ---

--6.Join the necessary tables to find the total quantity of each pizza category ordered.
--7.Determine the distribution of orders by hour of the day.
--8.Join relevant tables to find the category-wise distribution of pizzas.
--9.Group the orders by date and calculate the average number of pizzas ordered per day.
--10.Determine the top 3 most ordered pizza types based on revenue.

--- Advanced ---

--11.Calculate the percentage contribution of each pizza type to total revenue.
--12.Analyze the cumulative revenue generated over time.
--13.Determine the top 3 most ordered pizza types based on revenue for each pizza category.

--- Problems Solving --

--1.Retrieve the total number of orders placed.
SELECT
	COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM
	ORDERS;-- unique order total--

--2.Calculate the total revenue generated from pizza sales.
select * from pizzas
select * from order_details

SELECT
	ROUND(SUM(P.PRICE * O.QUANTITY), 1) AS TOTAL_REVENUE
FROM
	PIZZAS AS P
	INNER JOIN ORDER_DETAILS AS O ON P.PIZZA_ID = O.PIZZA_ID;

--3.Identify the highest-priced pizza.
select * from pizzas
select * from pizza_types

SELECT
	PT.NAME,
	MAX(P.PRICE) AS HIGHEST_PRICE
FROM
	PIZZAS AS P
	INNER JOIN PIZZA_TYPES AS PT ON PT.PIZZA_TYPE_ID = P.PIZZA_TYPE_ID
GROUP BY
	PT.NAME
ORDER BY
	HIGHEST_PRICE DESC
LIMIT
	1

--4.Identify the most common pizza size ordered.
select * from order_details
select * from pizzas

SELECT
	P.SIZE,
	SUM(O.QUANTITY) AS TOTAL_ORDERS
FROM
	PIZZAS AS P
	INNER JOIN ORDER_DETAILS AS O ON P.PIZZA_ID = O.PIZZA_ID
GROUP BY
	P.SIZE
ORDER BY
	TOTAL_ORDERS DESC
LIMIT
	1
	 

--5.List the top 5 most ordered pizza types along with their quantities.
select * from order_details
select * from pizzas

SELECT
	P.PIZZA_TYPE_ID,
	SUM(O.QUANTITY) AS TOTAL_ORDERS
FROM
	PIZZAS AS P
	INNER JOIN ORDER_DETAILS AS O ON P.PIZZA_ID = O.PIZZA_ID
GROUP BY
	P.PIZZA_TYPE_ID
ORDER BY
	TOTAL_ORDERS DESC
LIMIT
	5

--6.Join the necessary tables to find the total quantity of each pizza category ordered.
select * from pizza_types
select * from order_details  
select * from pizzas

SELECT
	PT.CATEGORY,
	SUM(O.QUANTITY) AS TOTAL_QUANTITY
FROM
	PIZZA_TYPES AS PT
	INNER JOIN PIZZAS AS P ON PT.PIZZA_TYPE_ID = P.PIZZA_TYPE_ID
	JOIN ORDER_DETAILS AS O ON P.PIZZA_ID = O.PIZZA_ID
GROUP BY
	PT.CATEGORY

--7.Determine the distribution of orders by hour of the day.
select * from orders

SELECT
	EXTRACT(
		HOUR
		FROM
			ORD_TIME
	) AS ORD_HOUR,
	COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM
	ORDERS
GROUP BY
	ORD_HOUR
ORDER BY
	ORD_HOUR ASC

--8.Join relevant tables to find the category-wise distribution of pizzas.
select * from pizza_types
select * from pizzas

SELECT
	PT.CATEGORY,
	COUNT(P.PIZZA_TYPE_ID) AS TOTAL_PIZZAS
FROM
	PIZZA_TYPES AS PT
	JOIN PIZZAS AS P ON P.PIZZA_TYPE_ID = PT.PIZZA_TYPE_ID
GROUP BY
	PT.CATEGORY
ORDER BY
	TOTAL_PIZZAS DESC

--9.Group the orders by date and calculate the average number of pizzas ordered per day.
-- using CTE. 
WITH
	MYTAB AS (
		SELECT
			O.ORDER_DATE,
			SUM(ORD.QUANTITY) AS TOTAL_ORDERS_QUANTITY
		FROM
			ORDERS AS O
			JOIN ORDER_DETAILS AS ORD ON O.ORDER_ID = ORD.ORDER_ID
		GROUP BY
			O.ORDER_DATE
	)
SELECT
	AVG(TOTAL_ORDERS_QUANTITY) AS AVG_Q
FROM
	MYTAB

--or
--- using subquery
SELECT
	AVG(TOTAL_ORDERS_QUANTITY) AS AVG_QUANTITY
FROM
	(
		SELECT
			O.ORDER_DATE,
			SUM(ORD.QUANTITY) AS TOTAL_ORDERS_QUANTITY
		FROM
			ORDERS AS O
			JOIN ORDER_DETAILS AS ORD ON O.ORDER_ID = ORD.ORDER_ID
		GROUP BY
			O.ORDER_DATE
	) AS T


--10.Determine the top 3 most ordered pizza types based on revenue.
select * from order_details
select * from pizzas

SELECT
	P.PIZZA_TYPE_ID,
	SUM(ORD.QUANTITY * P.PRICE) AS REVENUE
FROM
	PIZZAS AS P
	JOIN ORDER_DETAILS AS ORD ON P.PIZZA_ID = ORD.PIZZA_ID
GROUP BY
	P.PIZZA_TYPE_ID
ORDER BY
	REVENUE DESC
LIMIT
	3

--11.Calculate the percentage contribution of each pizza type to total revenue.
select * from order_details
select * fromm pizzas
select * from pizza_types


WITH category_sales AS (
    SELECT 
        pt.name,
        SUM(p.price * od.quantity) AS revenue
    FROM pizzas p
    JOIN order_details od 
        ON p.pizza_id = od.pizza_id
    JOIN pizza_types pt 
        ON pt.pizza_type_id = p.pizza_type_id
    GROUP BY pt.name
),
total_sales AS (
    SELECT SUM(revenue) AS total_revenue
    FROM category_sales
)
SELECT 
    cs.name,
    ROUND(cs.revenue / ts.total_revenue * 100, 2) AS percentage_contribution
FROM category_sales cs
CROSS JOIN total_sales ts
ORDER BY percentage_contribution DESC;

--12.Analyze the cumulative revenue generated over time.
select * from pizzas
select * from order_details
select * from orders

WITH
	MY AS (
		SELECT
			O.ORDER_DATE,
			SUM(P.PRICE * ORD.QUANTITY) AS REVENUE
		FROM
			PIZZAS AS P
			JOIN ORDER_DETAILS AS ORD ON P.PIZZA_ID = ORD.PIZZA_ID
			JOIN ORDERS AS O ON O.ORDER_ID = ORD.ORDER_ID
		GROUP BY
			O.ORDER_DATE
	)
SELECT
	ORDER_DATE,
	REVENUE,
	SUM(REVENUE) OVER (
		ORDER BY
			ORDER_DATE
	) AS CUMMULATIVE_REVENUE
FROM
	MY

--13.Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select * from pizza_types
select * from order_details
select * from pizzas


WITH
	MY AS (
		SELECT
			PT.NAME,
			PT.CATEGORY,
			SUM(P.PRICE * ORD.QUANTITY) AS REVENUE,
			RANK() OVER (
				PARTITION BY
					PT.CATEGORY
				ORDER BY
					SUM(P.PRICE * ORD.QUANTITY)
			) AS RNK
		FROM
			ORDER_DETAILS AS ORD
			JOIN PIZZAS AS P ON ORD.PIZZA_ID = P.PIZZA_ID
			JOIN PIZZA_TYPES AS PT ON PT.PIZZA_TYPE_ID = P.PIZZA_TYPE_ID
		GROUP BY
			PT.NAME,
			PT.CATEGORY
	)
SELECT
	*
FROM
	MY
WHERE
	RNK <= 3
ORDER BY
	CATEGORY,
	RNK



	  