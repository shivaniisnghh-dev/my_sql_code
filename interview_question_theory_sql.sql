-- 1. Safely recreate the database for clean practice runs
DROP DATABASE IF EXISTS interview_commands_practice;
CREATE DATABASE interview_commands_practice;
USE interview_commands_practice;

SET autocommit = 1;

-- 2. Create table with proper constraints
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(60) NOT NULL,
    department VARCHAR(30) NOT NULL,
    city VARCHAR(40),
    salary DECIMAL(10, 2) CHECK (salary > 0),
    employment_status ENUM('Active', 'Inactive') DEFAULT 'Active',
    phone VARCHAR(15) UNIQUE
) ENGINE = InnoDB;

-- 3. Insert sample records
INSERT INTO employees
    (employee_id, employee_name, department, city, salary, employment_status, phone)
VALUES
    (1, 'Rahul Sharma', 'IT', 'Delhi', 45000.00, 'Active', '9000000001'),
    (2, 'Priya Verma', 'HR', 'Mumbai', 42000.00, 'Active', '9000000002'),
    (3, 'Amit Patel', 'Sales', 'Ahmedabad', 38000.00, 'Inactive', '9000000003'),
    (4, 'Anjali Singh', 'IT', 'Kolkata', 50000.00, 'Active', '9000000004'),
    (5, 'Vijay Kumar', 'Finance', 'Bangalore', 55000.00, 'Active', '9000000005'),
    (6, 'Sanjay Reddy', 'Sales', 'Hyderabad', 36000.00, 'Active', '9000000006'),
    (7, 'Megha Iyer', 'IT', 'Chennai', 48000.00, 'Active', '9000000007'),
    (8, 'Neha Gupta', 'HR', 'Delhi', 32000.00, 'Inactive', '9000000008'),
    (9, 'Arjun Mehta', 'Finance', 'Pune', 52000.00, 'Active', '9000000009'),
    (10, 'Pooja Shah', 'Sales', 'Mumbai', 40000.00, 'Active', '9000000010');
    
    -- Questions 1 to 5
/* Work through all 15 questions in order, using the same connection. Keep the changes from earlier questions.
Write and run the SQL yourself. Use employee_id in filters where a specific employee is named.
Record values below follow this order: employee_id, employee_name, department, city, salary,
employment_status, phone. All salaries are monthly amounts in rupees.*/


/* 01. Insert one employee
A new employee has joined. Write an INSERT statement with an explicit column list to add the following record to
employees. Supply all seven values.
11, Karan Malhotra, IT, Noida, 41000.00, Active, 9000000011*/
select * from employees;

insert into employees (employee_id , employee_name , department , city , salary , employment_status , phone)
value(11, 'Karan Malhotra', 'IT', 'Noida', 41000.00, 'Active', 9000000011);

select * from employees
where employee_id = 1;

/*02. Insert several employees in one statement
Add both employees below using a single INSERT statement. Do not write a separate INSERT for each employee.
12, Simran Kaur, HR, Delhi, 35000.00, Active, 9000000012
13, Rohan Das, Sales, Pune, 33000.00, Inactive, 9000000013 */

insert into employees (employee_id , employee_name , department , city , salary , employment_status , phone)
values
       (12, 'Simran Kaur',' HR', 'Delhi', 35000.00, 'Active', 9000000012),
       (13, 'Rohan Das',' Sales', 'Pune', 33000.00, 'Inactive', 9000000013);

 /*03. Update two values in one row
Karan Malhotra, employee_id 11, has moved to Gurgaon and received a salary revision. Change his city to
Gurgaon and his salary to 46000.00 in one UPDATE statement. Leave every other employee unchanged. */

update employees
           set   city = 'gurgoan',
                 salary = 46000.00
                 where employee_id = 11;
select * from employees
where employee_id = 11;

/*04. Apply a salary increase
Give employees 1, 4 and 7 a 10% increase on their current salary using one UPDATE statement. Calculate the
increase from the stored salary; do not enter three replacement salary amounts. Run the statement only once.*/

update employees
       set salary = (salary * 1.10)
       where employee_id in (1 , 4 , 7);

 /*05. Delete selected employee records
Employees 3, 8 and 13 have left the company. Delete only these three records using one DELETE statement. Keep
the employees table and all other records.
For each task, check the affected row count and inspect the table data in MySQL Workbench. No joins, grouping
or subqueries are required.*/
DELETE FROM employees
	WHERE employee_id IN (3, 8, 13);
    
select * from employees;
SELECT ROW_COUNT() AS rows_deleted;
    
-- MySQL practical interview worksheet | 3
-- Questions 6 to 10
/*Continue with the same employees table. These tasks change its structure and name. Keep all existing employee
records unless the question says otherwise. */
/* 06. Add a new column
Use ALTER TABLE to add an email column with data type VARCHAR(100). Allow it to contain NULL. Existing
employees do not have email addresses yet, so do not fill the column with invented values.*/
alter table employees
   add column email varchar(100) not null;

/*07. Change the size of a column
The phone column currently allows 15 characters. Use ALTER TABLE to increase it to VARCHAR(20), while keeping
the existing phone values. The column should still allow NULL.*/
alter table employees
 modify column phone varchar(20) null;

/* 08. Rename a column
Use ALTER TABLE to rename city to work_city. Keep its VARCHAR(40) data type and all existing city values. Use the
new column name in later questions.*/
alter table employees
   rename column city to work_town;

/* 09. Remove an unused column
The company decides not to store email addresses in this table. Use ALTER TABLE to remove only the email
column added in Question 6. Keep every other column and every employee record.*/
alter table employees
 drop column email;

/* 10. Rename the table
Use RENAME TABLE to change the table name from employees to staff. Keep the data and structure.*/
rename table employees to staff;

/* 15. Remove the table and database with DROP
Finish the exercise by using DROP TABLE to remove staff completely. Then use DROP DATABASE to remove
interview_commands_practice. Execute these commands only after completing Questions 1 to 14.*/
drop table staff;
drop database interview_commands_practice;

/* Use staff for Questions 11 to 15.
Before the transaction tasks
The setup enables autocommit. For Questions 11 to 13, begin each question with START TRANSACTION and
complete that question before starting the next one. Run all steps in the same connection.
Keep ALTER, RENAME, TRUNCATE and DROP outside Questions 11 to 13. In MySQL, these commands cause an
implicit commit and are not undone by an ordinary ROLLBACK.


MySQL practical interview worksheet | 4

Questions 11 to 15
11. Save a group of changes with COMMIT
Start a transaction. Insert the employee below into staff, then change the salary of employee 2 to 45000.00. Use
COMMIT to save both changes.
14, Nisha Rao, IT, Noida, 44000.00, Active, 9000000014
The record order is unchanged, but city is now named work_city. After COMMIT, run ROLLBACK and check
whether either saved change is undone.
12. Undo changes with ROLLBACK
Start a new transaction. Change employee 5&#39;s salary to 60000.00 and delete employee 6. Before saving, the
manager cancels both changes. Use ROLLBACK to undo them together.
Check that employee 5 has the previous salary and employee 6 still exists. Do not undo the committed changes
from Question 11.
13. Undo part of a transaction with savepoints
Complete these steps in one new transaction:
a) Change employee 14&#39;s salary to 47000.00. Create a SAVEPOINT named salary_saved.
b) Change employee 14&#39;s work_city to Jaipur. Create another SAVEPOINT named city_saved.
c) Delete employee 14. Roll back to city_saved to undo only the deletion.
d) Roll back to salary_saved to undo the city change as well. Use COMMIT to save the remaining salary change.
Check the final salary and work_city of employee 14. Explain which changes were kept and which were undone.
14. Remove all rows with TRUNCATE
The practice data is no longer needed. Start a new transaction, use TRUNCATE TABLE to remove every row from
staff, and then run ROLLBACK.
Inspect the table and record what happened. Did the rows return? Does the table structure still exist? Explain the
observed result in one sentence.
15. Remove the table and database with DROP
Finish the exercise by using DROP TABLE to remove staff completely. Then use DROP DATABASE to remove
interview_commands_practice. Execute these commands only after completing Questions 1 to 14./