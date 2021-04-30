-- *********************** 
-- Name: Soroush Bahrami
-- ID: 152499182
-- Date: 2020-11-19 
-- Purpose: Lab 6 DBS311 
-- ***********************

SET SERVEROUTPUT ON; 

/*Do NOT change any salaries in the table.
Assume that the starting salary or sometimes called base salary was $10,000.
Every year of employment after that, the salary increases by 5%. */


CREATE OR REPLACE PROCEDURE calculate_salary(emp_id IN NUMBER) AS
cnt_years NUMBER := 1;
hired_years NUMBER;
firstName VARCHAR2(25 BYTE);
lastName VARCHAR2(25 BYTE);
hireDate DATE;
cal_salary NUMBER := 10000;
BEGIN
SELECT first_name, last_name, hire_date, round((to_date(sysdate) - to_date(hire_date))/365) 
INTO firstName, lastName, hireDate, hired_years
FROM EMPLOYEES
WHERE employee_id = emp_id;
   WHILE cnt_years < hired_years LOOP
   cal_salary := round((cal_salary * 1.05),2);
   cnt_years := cnt_years + 1;
   END LOOP;
      DBMS_OUTPUT.PUT_LINE ('First name: ' || firstName);
      DBMS_OUTPUT.PUT_LINE ('Last name: ' || lastName );
      DBMS_OUTPUT.PUT_LINE ('Salary: $' || cal_salary);
   EXCEPTION
      WHEN TOO_MANY_ROWS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
      WHEN NO_DATA_FOUND
  THEN 
      DBMS_OUTPUT.PUT_LINE ('There is no employee with this ID!');
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');

END;
/

/*Write a stored procedure named employee_works_here to 
print the employee_id, employee Last name and department name*/


CREATE OR REPLACE PROCEDURE employee_works_here AS
lastName VARCHAR2(25 BYTE);
emp_id NUMBER(6,0) := 3;
ids NUMBER(6,0);
department VARCHAR2(25 BYTE);
BEGIN
DBMS_OUTPUT.PUT_LINE('Employee#     ' || 'Last Name     ' || 'Department Name' );
FOR i IN emp_id .. 105 LOOP
SELECT nvl(last_name, ''), nvl(employee_id,0), d.department_name INTO lastName, emp_id, department
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id
WHERE employee_id = i;
IF department IS NOT NULL THEN
DBMS_OUTPUT.PUT_LINE(emp_id || '              ' || lastName || '          ' || department);
ELSE 
DBMS_OUTPUT.PUT_LINE(emp_id || '              ' || lastName || '          ' || 'No Department');
END IF;
END LOOP;
EXCEPTION
      WHEN TOO_MANY_ROWS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Too Many Rows Returned!');
      WHEN NO_DATA_FOUND
  THEN 
      DBMS_OUTPUT.PUT_LINE ('There is no employee with this ID!');
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END;
/
CREATE OR REPLACE PROCEDURE soup(numberInput IN OUT NUMBER) AS
BEGIN
numberInput := numberInput + 9.5;
EXCEPTION
      WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');
END;

declare 
numInput NUMBER := 57;
BEGIN 
soup(numInput);
DBMS_OUTPUT.PUT_LINE('the new mark is : ' || numInput);
END;
/

DECLARE      -- Global variables

                Num1     number := 95;

BEGIN

                 dbms_output.put_line('num: ' || num1);

                DECLARE     -- Local variables

                               Num1     number := 195;

               BEGIN

                                dbms_output.put_line('num: ' || num1);

               END;

END;


