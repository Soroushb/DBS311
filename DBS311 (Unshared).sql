/*SELECT job_id AS "G", COUNT(*)
FROM employees
GROUP BY job_id
*/

/*SELECT MAX(salary),
MIN(salary),
ROUND(AVG(salary), 2),
ROUND(MAX(salary)-MIN(salary), 2) AS "Difference"
FROM employees*/


/*SELECT prod_type, SUM(sales_2016 + sales_2015)
FROM products
GROUP BY prod_type
ORDER BY prod_type*/


/*
SELECT c.cname, SUM(l.price * l.qty)
FROM customers c JOIN orders o ON c.cust_no = o.cust_no 
JOIN orderlines l ON o.order_no=l.order_no 
HAVING SUM(l.price * l.qty) > 50000
GROUP BY c.cname
ORDER BY c.cname
*/

/*
SELECT cust_no, order_no
FROM orders
WHERE CUST_NO = 1041
*/

/*SELECT SUM(price * qty)
FROM orderlines
where order_no = 129*/



/*
SELECT c.cname, COUNT(*)
FROM customers c FULL JOIN orders o ON c.cust_no = o.cust_no 
WHERE c.cname LIKE 'A%' OR c.cname LIKE 'G%'
GROUP BY c.cname
ORDER BY c.cname
*/

/*
SELECT cust_no
FROM customers 
WHERE cname LIKE 'GO Outlet Frankfurt'
*/
/*
SELECT order_no 
FROM orders
WHERE cust_no = 1119*/

/*SELECT count(*)
FROM customers 
WHERE cname LIKE 'A%' OR cname LIKE 'G%'*/

/*
SELECT c.cust_no, c.cname, SUM(price * qty), COUNT(*)
 FROM customers c FULL JOIN orders o ON c.cust_no = o.cust_no 
 FULL JOIN orderlines l ON o.order_no=l.order_no 
WHERE c.cname LIKE 'A%'
GROUP BY c.cname, c.cust_no
ORDER BY 4
*/

/*
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history
ORDER BY job_id
*/

/*
SELECT city
FROM locations
MINUS
SELECT city
FROM customers
ORDER BY city;
*/
/*
select distinct city

from customers

order by 1*/

/*
SELECT employee_id, job_id 
FROM employees
UNION 
SELECT employee_id, job_id
FROM job_history
/*
SELECT distinct  c.cust_no, c.cname, o.order_no
FROM customers c
INNER JOIN orders o
ON c.cust_no = o.cust_no 
INNER JOIN orderlines l
ON o.order_no = l.order_no
INNER JOIN products p
ON l.prod_no = p.prod_no
WHERE p.prod_no = 40301 OR p.prod_no = 40303 OR p.prod_no = 40300 OR p.prod_no = 40310 OR p.prod_no = 40306
ORDER BY o.order_no
*/

/*
SELECT c.cust_no, c.cname, x.country_name, o.order_no, p.prod_name, (l.price * l.qty) as "Lines Sales"
FROM customers c
INNER JOIN countries x
ON c.country_cd = x.country_id AND x.country_name LIKE 'United Kingdom'
INNER JOIN orders o
ON c.cust_no = o.cust_no
INNER JOIN orderlines l
ON o.order_no = l.order_no
INNER JOIN products p
ON l.prod_no = p.prod_no
WHERE c.cust_no < 1000
*/
/*
SELECT c.cust_no, c.cname, x.country_name
FROM customers c
INNER JOIN countries x
ON c.country_cd = x.country_id AND (x.country_name LIKE 'United Kingdom' or x.country_name LIKE 'Germany')
INNER JOIN orders o
ON c.cust_no = o.cust_no
INNER JOIN orderlines l
ON o.order_no = l.order_no
INNER JOIN products p
ON l.prod_no = p.prod_no
WHERE EXTRACT(YEAR FROM o.order_dt) = 2014
*/

/*
SELECT distinct c.cname, o.order_no, (qty * price)
FROM customers c
INNER JOIN orders o
ON c.cust_no = o.cust_no 
INNER JOIN orderlines l
ON o.order_no = l.order_no
WHERE c.city LIKE 'London'
GROUP BY c.cname, o.order_no, (qty * price)
*/

/*
SELECT order_dt, COUNT(order_no)
FROM orders
group by order_dt, order_no
*/
/*
SELECT e.department_id, e.job_id, MIN(e.salary), d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id AND d.department_name NOT LIKE 'IT' AND d.department_name NOT LIKE 'Sales'
WHERE e.salary BETWEEN 6000 AND 18000
GROUP BY e.department_id, e.job_id, e.salary, d.department_name
ORDER BY department_id, job_id
*/

/*
SELECT DISTINCT CUST_NO
FROM customers 
MINUS
SELECT DISTINCT cust_no
FROM orders
*/

/*
SELECT cust_no, cname, country_name
FROM customers c
INNER JOIN countries t
ON c.country_cd = t.country_id
WHERE c.cname LIKE 'A%' OR c.cname LIKE 'E%' 
*/

/*
SELECT last_name, salary, job_id
FROM employees
WHERE salary > ALL (
                    SELECT MIN(salary)
                    FROM employees e
                    INNER JOIN departments d
                    ON e.department_id = d.department_id
                    INNER JOIN locations l
                    ON d.location_id = l.location_id
                    INNER JOIN countries c
                    ON l.country_id = c.country_id
                    WHERE c.country_id = 'US'
                    )
ORDER BY salary
*/

/*
SELECT prod_type, count(prod_type)
FROM products
WHERE prod_type = 'Sleeping Bags'
group by prod_type
UNION ALL
SELECT prod_type, count(prod_type)
FROM products
WHERE prod_type = 'Tents'
group by prod_type
UNION ALL
SELECT prod_type, count(prod_type)
FROM products
WHERE prod_type = 'Sunblock'
group by prod_type
*/
/*
SELECT country_id, country_name
FROM countries
WHERE '&country_name' LIKE concat(lower(country_name), '%') 
*/

/*SELECT order_dt, count(order_no)
FROM orders
WHERE (order_dt LIKE '%15' OR order_dt LIKE '%16') 
HAVING count(order_no) > 1
GROUP BY order_dt*/

/*
SELECT DISTINCT count(CUST_NO)
FROM customers
WHERE cust_no <> ALL(
SELECT DISTINCT (cust_no)
FROM orders
)
*/
/*
SELECT distinct o.cust_no, c.cname, s.country_name, o.order_dt
FROM orders o
INNER JOIN customers c
ON o.cust_no = c.cust_no
INNER JOIN countries s
ON c.country_cd = s.country_id
WHERE order_dt LIKE '%14'
*/
/*
SELECT  COUNT(DISTINCT JOB_ID)
FROM employees;
*/
/*
SELECT JOB_ID, COUNT(*)
FROM employees 
GROUP BY JOB_ID
*/
/*
SELECT COUNT(distinct manager_id)
FROM departments
*/
/*
SELECT MAX(SALARY), MIN(SALARY),MAX(SALARY)- MIN(SALARY) as "DIFFERENCE"
FROM employees
*/
/*
SELECT first_name || ' ' || last_name, JOB_ID
FROM employees
WHERE job_id = (SELECT JOB_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 141)
*/
/*
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
                FROM employees
                )
*/
/*
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
HAVING AVG(SALARY) = (SELECT MIN(AVG(SALARY))
FROM EMPLOYEES
GROUP BY JOB_ID
)
GROUP BY JOB_ID
*/
/*
SELECT last_name, hire_date 
FROM employees
WHERE hire_date < (SELECT hire_date 
                   FROM employees 
                   WHERE employee_id = 144)
ORDER BY hire_date 
*/
/*
SELECT last_name, salary
FROM employees 
WHERE salary = (SELECT MIN(salary) 
                FROM employees
                )
*/

SELECT prod_name, prod_sell, PROD_TYPE
FROM products
WHERE PROD_TYPE IN (SELECT PROD_TYPE 
                   FROM PRODUCTS
                    WHERE PROD_SELL < ANY (SELECT MIN(PROD_SELL) FROM PRODUCTS GROUP BY PROD_TYPE));



SELECT  prod_name, prod_type, prod_sell
FROM products
WHERE prod_type IN (SELECT prod_type FROM products WHERE prod_sell IN (SELECT MIN(prod_sell)
FROM products)) AND prod_sell > 10;

/*
SELECT TO_CHAR(SYSDATE+1, 'MONTH fmDD"th of year "YEAR') FROM DUAL*/
/*
SELECT city, country_id, NVL(state_province, 'State Missing') 
FROM locations 
WHERE city LIKE 's_____%'
*/



/*
SELECT cust_no, cname, country_cd
FROM customers
WHERE lower(country_cd) = lower('&CountryCode');
*/
/*
SELECT c.cust_no, c.cname, o.order_no, o.order_dt, sum(l.qty), sum(l.qty * l.price)
FROM customers c JOIN orders o ON c.cust_no = o.cust_no 
JOIN orderlines l ON o.order_no=l.order_no 
WHERE c.cust_no BETWEEN 1010 AND 1050
HAVING SUM(l.qty) > 600
GROUP BY c.cust_no, c.cname, o.order_no, o.order_dt
ORDER BY 6
*/

SELECT round((to_date(sysdate) - to_date(hire_date))/365), hire_date, EMPLOYEE_ID, FIRST_NAME, LAST_NAME
from employees
order by hire_date