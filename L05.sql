
CREATE OR REPLACE PROCEDURE findEven(number IN NUMBER) AS
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

CREATE OR REPLACE PROCEDURE find_employee(employee_num IN NUMBER) AS
first VARCHAR2(255 BYTE);
last VARCHAR2(255 BYTE);
email VARCHAR2(255 BYTE);
phone VARCHAR2(255 BYTE);
hire DATE;
job VARCHAR2(255 BYTE);
BEGIN 
SELECT first_name, last_name, email, phone_number, hire_date,job_id INTO first, last, email, phone, hire, job
FROM EMPLOYEES
WHERE employee_id = employee_num;
      DBMS_OUTPUT.PUT_LINE ('First name: ' || first);
      DBMS_OUTPUT.PUT_LINE ('Last name: ' || last );
      DBMS_OUTPUT.PUT_LINE ('Email: ' || email );
      DBMS_OUTPUT.PUT_LINE ('Phone: ' || phone );
      DBMS_OUTPUT.PUT_LINE ('Hire Date: ' || hire );
      DBMS_OUTPUT.PUT_LINE ('Job title: ' || job );
      
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

CREATE OR REPLACE PROCEDURE update_price_tents(ProdType IN VARCHAR2,amount NUMBER) AS
rows_updated INTEGER;
BEGIN
UPDATE products 
SET prod_sell = (prod_sell + amount)
WHERE prodType = PROD_TYPE AND prod_sell > 0;
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

CREATE OR REPLACE PROCEDURE update_low_prices_123456 AS
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

CREATE OR REPLACE PROCEDURE price_report_1234567 AS  
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
SELECT avg(prod_sell) INTO avg_price
FROM products;
SELECT min(prod_sell) INTO min_price
FROM products;
SELECT max(prod_sell) INTO max_price
FROM products;
SELECT count(prod_sell) INTO low_count
FROM products
where prod_sell < (avg_price - min_price) / 2;
SELECT COUNT(prod_sell) INTO high_count
FROM products
WHERE prod_sell > (max_price - avg_price) / 2;
SELECT COUNT(prod_sell) INTO fair_count
FROM PRODUCTS
WHERE prod_sell BETWEEN (avg_price - min_price) / 2  AND (max_price - avg_price) / 2;
DBMS_OUTPUT.PUT_LINE('Low: ' || low_count  ||  ' Fair: ' || fair_count  || ' High: ' || high_count);
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

