Drop database if exists join_database;
CREATE DATABASE join_database;
USE join_database;

-- create two tables table1 and table2

CREATE TABLE table1 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    phone_number VARCHAR(15)
);

CREATE TABLE table2 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10, 2),
    address VARCHAR(100)
);

-- Insert Data into the Tables

-- Insert data into table1
INSERT INTO table1 (id, first_name, last_name, city, phone_number) VALUES
(1, 'Rahul', 'Sharma', 'Delhi', '9876543210'),
(2, 'Priya', 'Verma', 'Mumbai', '8765432109'),
(3, 'Amit', 'Patel', 'Ahmedabad', '7654321098'),
(4, 'Anjali', 'Singh', 'Kolkata', '6543210987'),
(5, 'Vijay', 'Kumar', 'Bangalore', '5432109876');

-- Insert data into table2
INSERT INTO table2 (id, first_name, last_name, city, salary, address) VALUES
(3, 'Amit', 'Patel', 'Ahmedabad', 75000.00, 'Street 21, Ahmedabad, Gujarat'),
(4, 'Anjali', 'Singh', 'Kolkata', 82000.00, 'Park Street, Kolkata, West Bengal'),
(5, 'Vijay', 'Kumar', 'Bangalore', 92000.00, 'MG Road, Bangalore, Karnataka'),
(6, 'Sanjay', 'Reddy', 'Hyderabad', 70000.00, 'Banjara Hills, Hyderabad, Telangana'),
(7, 'Megha', 'Iyer', 'Chennai', 88000.00, 'Anna Nagar, Chennai, Tamil Nadu');


CREATE TABLE employees_selfjoin (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT
);

INSERT INTO employees_selfjoin (employee_id, name, manager_id) VALUES
(1, 'Alice', NULL),
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'David', 2),
(5, 'Eve', 2);

select database();
show tables;
select * from employees_selfjoin;
select * from table1;
select * from table2;

/*1. INNER JOIN with a salary filter
 Find people whose IDs appear in both table1 and table2.
 Use WHERE to keep only people whose salary is greater than 75000.
 Display ID, first name, city, phone number and salary. Use ORDER BY to show the highest salary first.*/
select 
       t1.id,
       t1.first_name,
       t1.city,
       t1.phone_number,
       t2.salary
       from table1 as t1
       inner join table2 as t2
       on t1.id=t2.id
       where salary>75000
       order by t2.salary desc;
 
 /*2. LEFT JOIN with a city filter
 Use a LEFT JOIN to show people from table1 whose city is Delhi, Kolkata or Bangalore.
 Display ID, first name and city from table1, along with salary and address from table2.
 Keep people even when they have no match in table2. Filter using WHERE and sort by the table1 ID in ascending
order.*/
select 
        t1.id,
        t1.first_name,
        t1.city,
        t2.salary,
        t2.address
        from table1 as t1
        left join table2 as t2
        on t1.id=t2.id
        where t1.city in('kolkata','delhi' ,'bengalore')
        order by t1.id asc;

/*3. RIGHT JOIN with sorting and a row limit
 Use a RIGHT JOIN to show people from table2 whose salary is at least 80000. Include them even if they have no
match in table1.
 Display ID and first name from table2, salary and the phone number from table1.
 Use WHERE to filter, ORDER BY to sort salary from highest to lowest, and LIMIT to show only the first 2 rows.*/        
select t2.salary,
        t1.phone_number,
        t2.ID,
        t2.first_name
        from table1 as t1
        right join table2 as t2
        on t1.id =t2.id
        where t2.salary>80000
        order by t2.salary desc
        limit 2;
        
 /*4. FULL OUTER JOIN result
 Write a MySQL-compatible query that returns all people from both tables, including people found in only one
table.
 Show matching IDs once. Display one combined ID, first name, phone number and salary.
 Combine outer-join results to produce the full result. Sort the final combined result by ID in ascending order.*/   
(    
select t1.id,
       t1.first_name,
       t1.phone_number,
       t2.salary
       from table1 as t1
       left join table2 as t2
       on t1.id=t2.id)
       union
(       
select 
       t2.id,
       t2.first_name,
       t1.phone_number,
       t2.salary
       from table1 as t1
       right join table2 as t2
       on t1.id=t2.id)
       order by id asc;
   
  /*5. CROSS JOIN with a row limit
 Create every possible pair between a person from table1 and a person from table2 using CROSS JOIN.
 Display both IDs and both first names. Use aliases so that the output columns are easy to identify.
 Sort first by the table1 ID and then by the table2 ID, both ascending. Use LIMIT to display the first 10 pairs. How
many pairs exist before LIMIT is applied?*/ 
select 
       t1.id as table1_id,
       t1.first_name as table1_firstname,
       t2.id as table2_id,
       t2.firstname as table2_firstname
       from table1 as t1
       cross join table2 as t2
       on t1.id=t2.id
       order by t1.id asc,t2.id asc
       limit 10;
 
 /*6. LEFT JOIN to find people missing from table2
 Find people who exist in table1 but have no matching ID in table2.
 Use LEFT JOIN and WHERE with IS NULL. Display only the columns from table1.
 Sort the result by first_name in alphabetical order.*/
select 
       t1.* 
	   from table1 as t1
       left join table2 as t2
       on t1.id = t2.id
       where t2.id is null
       order by t1.first_name asc;
	
/*7. RIGHT JOIN to find people missing from table1
 Find people who exist in table2 but have no matching ID in table1.
 Use RIGHT JOIN. In WHERE, check for the missing match and keep only people whose salary is greater than
75000.
 Display only the columns from table2 and sort by salary from highest to lowest.*/
select t2.*
		from table1 as t1
       right join table2 as t2
       on t1.id= t2.id
       where t1.id is null and salary >75000
       order by t2.salary asc;
       
/*8. Unmatched people from both tables
 Find people whose IDs appear in only one of the two tables. Exclude IDs that appear in both tables.
 Use outer joins and WHERE to select unmatched rows, then combine the two results.
 Display ID, first name and a source_table column containing &#39;table1&#39; or &#39;table2&#39;. Sort the final combined result by
first name, then ID, both ascending, and use LIMIT to show the first 3 rows.*/       
select t1.id as t1_id,
       t1.first_name as t1_firstname,
       t2.id as t2_id,
       t2.first_name as t2_firstname
       from table1 as t1
       left join table2 as t2
       on t1.id=t2.id
       where t2.id is null
       order by t1.first_name asc, t1.id asc
       limit 3;
/*9. INNER JOIN to find the two highest salaries
 Find people whose IDs appear in both tables and whose salary is greater than 70000.
 Display first name, last name, city, phone number and salary.
 Use WHERE for the salary filter. Sort by salary descending and then ID ascending. Use LIMIT to return the 2
highest-paid people from the matching records.*/
select t1.id,
       t1.first_name,
       t1.last_name,
       t1.city,
       t1.phone_number,
       t2.salary
       from table1 as t1
       inner join table2 as t2
       on t1.id = t2.id
       where t2.salary>70000
       order by t2.salary desc, t1.id asc
       limit 2;
       
       
/*10. SELF JOIN to find employees managed by Bob
 Use employees_selfjoin twice, with the aliases e for employees and m for managers. Match each employee to
their manager.
 Use WHERE to keep only employees whose manager's name is Bob. Display employee ID, employee name and
manager name with clear column aliases.
 Sort by employee ID from highest to lowest and use LIMIT to return only the first employee.*/
select e.employee_id,                              
	   e.name as employee_name,
       m.name as manager_name
       from employees_selfjoin as e
        inner join employees_selfjoin as m
       on e.manager_id=m.employee_id
       where m.name= 'bob'
       order by e.employee_id desc
       limit 1;
       