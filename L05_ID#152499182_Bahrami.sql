-- ***********************
-- Name: Soroush Bahrami
-- Student ID: 152499182
-- Date: 2020-11-11
-- Purpose: Lab 5 DBS311
-- ***********************


SET SERVEROUTPUT ON; 
/*
1.	Write a stored procedure that get an integer number and prints
The number is even.
If a number is divisible by 2.
Otherwise, it prints 
The number is odd.
*/
CREATE OR REPLACE PROCEDURE isEven(number IN NUMBER) AS
BEGIN 
IF number MOD 2 = 0 THEN 
      DBMS_OUTPUT.PUT_LINE ('The number is even.');
      ELSE     
      DBMS_OUTPUT.PUT_LINE ('The number is odd.');
      END IF;
      EXCEPTION
      WHEN TOO_MANY_ROWS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
      WHEN NO_DATA_FOUND
  THEN 
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');

END;
/
/*
2.
Create a stored procedure named find_employee.
This procedure gets an employee number and prints the employee information
*/

CREATE OR REPLACE PROCEDURE find_employee(employee_num IN NUMBER) AS
firstName VARCHAR2(255 BYTE);
lastName VARCHAR2(255 BYTE);
email VARCHAR2(255 BYTE);
phone VARCHAR2(255 BYTE);
hireDate DATE;
jobTitle VARCHAR2(255 BYTE);
BEGIN 
SELECT first_name, last_name, email, phone_number, hire_date,job_id INTO firstName, lastName, email, phone, hireDate, jobTitle
FROM EMPLOYEES
WHERE employee_id = employee_num;
      DBMS_OUTPUT.PUT_LINE ('First name: ' || firstName);
      DBMS_OUTPUT.PUT_LINE ('Last name: ' || lastName );
      DBMS_OUTPUT.PUT_LINE ('Email: ' || email || '@example.com' );
      DBMS_OUTPUT.PUT_LINE ('Phone: ' || phone );
      DBMS_OUTPUT.PUT_LINE ('Hire Date: ' || hireDate );
      DBMS_OUTPUT.PUT_LINE ('Job title: ' || jobTitle );
      
      EXCEPTION
      WHEN TOO_MANY_ROWS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
      WHEN NO_DATA_FOUND
  THEN 
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');

END;
/
/*
3.
Write a procedure named update_price_tents to update the price of all products in a given type and the
given amount to be added to the current selling price if the price is greater than 0. 
*/
CREATE OR REPLACE PROCEDURE update_price_tents(Prod_type# IN VARCHAR2,amount products.prod_sell%type) AS
rows_updated INTEGER;
BEGIN
UPDATE products 
SET prod_sell = (prod_sell + amount)
WHERE prod_type# = PROD_TYPE AND prod_sell > 0;
rows_updated := sql%rowcount;
   DBMS_OUTPUT.PUT_LINE('The number of affected rows is: ' || rows_updated);
   EXCEPTION
      WHEN TOO_MANY_ROWS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
      WHEN NO_DATA_FOUND
  THEN 
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');

END;
/
/*
4.
increases the price of products by 1 or 2% (Example of 2% -- prod_sell * 1.02)
based on if the selling price (prod_sell) is less than the average price of all products. 
*/
CREATE OR REPLACE PROCEDURE update_low_prices_152499182 AS
average products.prod_sell%type;
rows_updated INTEGER;
BEGIN
SELECT AVG(prod_sell) INTO average
FROM products;
IF average <= 1000 THEN
UPDATE products 
SET prod_sell = (prod_sell * 1.02)
WHERE prod_sell < average;
ELSIF 
average > 1000 THEN
UPDATE products 
SET prod_sell = (prod_sell * 1.01)
WHERE prod_sell < average;
END IF;
rows_updated := sql%rowcount;
   DBMS_OUTPUT.PUT_LINE('*** OUTPUT update_low_prices_123456789  STARTED ***' || CHR(13) || CHR(10) || 
   'The number of affected rows is: ' || rows_updated  || CHR(13) || CHR(10) || '----ENDED----');
   EXCEPTION
      WHEN TOO_MANY_ROWS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
      WHEN NO_DATA_FOUND
  THEN 
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END;
/
/*
5. Write a procedure named price_report_123456789 
to show the number of products in each price category
*/
CREATE OR REPLACE PROCEDURE price_report_152499182 AS  
avg_price products.prod_sell%type;
min_price products.prod_sell%type;
max_price products.prod_sell%type;
low_count INTEGER;
fair_count INTEGER;
high_count INTEGER;
BEGIN
low_count := 0;
fair_count := 0;
high_count := 0;
SELECT AVG(prod_sell) INTO avg_price
FROM products;
SELECT MIN(prod_sell) INTO min_price
FROM products;
SELECT MAX(prod_sell) INTO max_price
FROM products;
SELECT COUNT(prod_sell) INTO low_count
FROM products
where prod_sell < (avg_price - min_price) / 2;
SELECT COUNT(prod_sell) INTO high_count
FROM products
WHERE prod_sell > (max_price - avg_price) / 2;
SELECT COUNT(prod_sell) INTO fair_count
FROM PRODUCTS
WHERE prod_sell BETWEEN (avg_price - min_price) / 2  AND (max_price - avg_price) / 2;
DBMS_OUTPUT.PUT_LINE('*** OUTPUT price_report_152499182 STARTED ***' || CHR(13) || CHR(10) || 
   'Low: ' || low_count  || CHR(13) || CHR(10) || 
   'Fair: ' || fair_count  || CHR(13) || CHR(10) ||
   'High: ' || high_count  || CHR(13) || CHR(10) ||'----ENDED----');
   EXCEPTION
      WHEN TOO_MANY_ROWS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
      WHEN NO_DATA_FOUND
  THEN 
      DBMS_OUTPUT.PUT_LINE ('No Data Found!');
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END;
/

CREATE OR REPLACE PROCEDURE find_customer(customer_id IN NUMBER, found OUT NUMBER) AS
isFound NUMBER := 1;
BEGIN
SELECT isFound INTO found FROM customers WHERE customer_id = cust_no;
EXCEPTION
WHEN no_data_found THEN
found:= 0;
END;
/

  CREATE OR REPLACE PROCEDURE find_product(product_id IN NUMBER, price OUT products.prod_sell%TYPE) AS
    BEGIN
    SELECT prod_sell INTO price FROM products WHERE product_id = prod_no;
    EXCEPTION
    WHEN no_data_found THEN
    price := 0;
    END;
/

CREATE OR REPLACE PROCEDURE add_order(customer_id IN NUMBER, new_order_id OUT NUMBER) AS
maxId NUMBER;
BEGIN
SELECT MAX(order_no) INTO maxId FROM orders;
new_order_id := maxId + 1;
INSERT INTO orders(order_no, cust_no, status, rep_no, order_dt) VALUES(new_order_id, customer_id, 'C', 36, SYSDATE);
END;

Declare
amount NUMBER;
Begin
add_order(1000, amount);
end;
/
ROLLBACK;

CREATE OR REPLACE PROCEDURE add_orderline(orderId IN orderlines.order_no%type,
                                          itemId IN orderlines.line_no%type,
                                          productId IN orderlines.prod_no%type,
                                          quantity IN orderlines.qty%type,
                                          price IN orderlines.price%type) AS
BEGIN
INSERT INTO orderlines(order_no, line_no, prod_no, qty, price) VALUES(orderId, itemId, productId, quantity, price);
END;

BEGIN
add_orderline(1,1,1,1,1);
END;
                                          
ROLLBACK;

CREATE OR REPLACE PROCEDURE increase(price IN OUT NUMBER) AS
BEGIN
price := price * (1.10);
END;

declare 
price NUMBER := 10;
BEGIN 
increase(price);
DBMS_OUTPUT.PUT_LINE ('price');
end;


