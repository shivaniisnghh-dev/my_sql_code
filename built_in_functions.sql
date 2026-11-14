DROP DATABASE IF EXISTS training_functions;

CREATE DATABASE training_functions;

USE training_functions;

CREATE TABLE CourseEnrollments (
StudentID INT PRIMARY KEY,
FirstName VARCHAR(40),
LastName VARCHAR(40),
CourseName VARCHAR(40),
Fee DECIMAL(10,2),
EnrollmentDate DATE,
CompletionDate DATE
);

INSERT INTO CourseEnrollments
(StudentID, FirstName, LastName, CourseName, Fee, EnrollmentDate, CompletionDate)
VALUES
(101, 'aman', 'Sharma', 'Python', 12500.75, '2026-01-05', '2026-03-20'),
(102, 'priya', 'Verma', 'MySQL', 9800.40, '2026-01-12', '2026-02-28'),
(103, 'rahul', 'Singh', 'Python', 15750.90, '2026-02-01', '2026-04-15'),
(104, 'neha', 'Gupta', 'Power BI', 11200.25, '2026-02-10', '2026-05-05'),
(105, 'ishita', 'Kapoor', 'MySQL', 8900.60, '2026-03-03', '2026-04-22'),
(106, 'arjun', 'Mehta', 'Python', 13650.15, '2026-03-15', '2026-06-10'),
(107, 'simran', 'Joshi', 'Power BI', 10400.95, '2026-04-01', '2026-06-30'),
(108, 'vikas', 'Rao', 'MySQL', 7600.50, '2026-04-18', '2026-05-29'),
(109, 'kiran', 'Malik', 'Python', 14999.99, '2026-05-02', '2026-07-25'),
(110, 'rohan', 'Sethi', 'Power BI', 11950.35, '2026-05-20', '2026-08-14');

SELECT * FROM CourseEnrollments;


/*1. Display each student’s full name in uppercase with a single space between the first and last
names using CONCAT() and UPPER().*/
select firstname , lastname , upper(concat(firstname,' ', lastname)) as fullname
from CourseEnrollments;

/*2. Display each student’s full name with the first letter of FirstName in uppercase and the
remaining letters unchanged, using CONCAT(), UPPER() and SUBSTRING().*/
select firstname ,
 lastname ,
concat(upper(substring(firstname, 1,1)) , lower(substring('lastname',2)),' ', lower(lastname)) as fullname
from CourseEnrollments;

/*3. Create a student code consisting of the first three letters of CourseName in uppercase, a
hyphen, and StudentID using LEFT(), UPPER() and CONCAT().*/
select coursename , studentid ,
       concat(upper(left(coursename,3)),'_',studentid)
       from CourseEnrollments;

/*4. Display FirstName reversed and also display its original character count using REVERSE() and
CHAR_LENGTH().*/
select firstname , 
       char_length(firstname),
       reverse(firstname) as reversename
 from CourseEnrollments; 
 
 /*5. Display the position of the letter a in FirstName using LOCATE(), along with FirstName.*/
 select firstname , 
        locate('a',firstname) as a_position
 from CourseEnrollments; 
 
 
 /*6. Replace every letter a in FirstName with o, then convert the result to uppercase using
REPLACE() and UPPER().*/
select firstname,
      upper(replace(firstname,'a','o'))
 from courseenrollments;
 
 
/* 7. Display FirstName padded on the left with zeroes to a total length of 12 characters using
LPAD().
 select*/
 select firstname,
		lpad(firstname ,12,0) as paddedname
        from courseenrollments;
        
/*8. Display a course label made of the last two letters of CourseName, a hyphen, and the first two
letters of FirstName using RIGHT(), LEFT() and CONCAT().*/
select coursename,
       firstname,
       concat(right(coursename ,2),'_',right(firstname,2)) as courselevel
       from courseenrollments;
       
/*9. Display the first three letters of FirstName in uppercase followed by the last two letters of
LastName in lowercase using SUBSTRING(), RIGHT(), UPPER(), LOWER() and CONCAT(). */
select firstname,
       lastname,
	   concat(upper(substring(firstname, 1 , 3)),lower(right(lastname,2)))
       from courseenrollments;

 /*10. Display Fee rounded to one decimal place and also Fee rounded to the nearest whole
number using ROUND().*/
select round(fee ,1) as 1_decinal_place,
       round(fee) as nereastnum
from CourseEnrollments; 
 
/*11. Display Fee rounded upward and downward to whole numbers in separate columns using
CEIL() and FLOOR().*/ 
select fee ,
       ceil(fee) as upward,
       floor(fee) as  downword
       from courseenrollments;
       
-- 12. Display the remainder when Fee is divided by 500 using MOD(), alongside the original Fee.              
 select fee,
        mod(fee , 500) as fee_remainder
        from courseenrollments;
        
 -- 13. Display the absolute difference between Fee and 10000 using ABS().      
 select fee,
		abs(fee - 10000) as ABSOLITE_DIFF
        from courseenrollments;
        
-- 14. Display Fee multiplied by 1.18 and rounded to two decimal places using ROUND().
select fee,
       round(fee*1.18 ,2) mul_fee
       from courseenrollments;
       
       
/*15. Display Fee formatted with a thousands separator and exactly two decimal places using
FORMAT().*/
select fee,
       format(fee , 2) as formatted_fee
       from courseenrollments;
       
/*16. Display the enrollment year, enrollment month name and enrollment day name in separate
columns using YEAR(), MONTHNAME() and DAYNAME().*/
select enrollmentdate,
       day(enrollmentdate) as day_of_enrollment,
       month(enrollmentdate) as month_of_enrollment, 
       year(enrollmentdate) as year_of_enrollment
from courseenrollments;

/*17. Display EnrollmentDate in DD/MM/YYYY format and CompletionDate in Month DD, YYYY
format using DATE_FORMAT().*/
select enrollmentdate,
        CompletionDate,
       date_format(enrollmentdate, '%d/%m/%y') as formatted_enroll_date,
       date_format(CompletionDate, '%m/%d/%y') as formatted_completion_date
 from courseenrollments;   
 
 
 /* 18. Calculate the number of days between EnrollmentDate and CompletionDate using
TIMESTAMPDIFF().*/
select enrollmentdate,
       completiondate,
       timestampdiff(day,enrollmentdate,completiondate) as calculated_date
from courseenrollments;

/*19. Display the date 1 month and 10 days after EnrollmentDate using nested DATE_ADD() calls.*/
select enrollmentdate,
       date_add(date_add(enrollmentdate , interval 1 month) , interval 10 day) as edited_date
       from courseenrollments;
       
/*20. Display the date exactly 7 days before CompletionDate using DATE_ADD() with a negative
interval.*/
select completiondate,
       date_add(completiondate , interval -7 day) as before_date
from courseenrollments;  

/*21. Display the number of complete months between EnrollmentDate and CompletionDate using
TIMESTAMPDIFF().*/   
select enrollmentdate,
       completiondate,
	   timestampdiff(month,enrollmentdate , completiondate ) as time_diff
 from courseenrollments;  
 
 /*22. Display the enrollment date shifted forward by 1 year, 2 months and 5 days using nested
DATE_ADD() calls.*/
select enrollmentdate,
       date_add(date_add(date_add(enrollmentdate, interval 1 year) , interval 2 month) , interval 5 day) as shifted_date
 from courseenrollments;      
 
 
 /*23. Display EnrollmentDate and CompletionDate with their weekday names using DAYNAME().*/
 select enrollmentdate,
        completiondate,
        dayname(enrollmentdate) as enroll_weekday,
        dayname(completiondate) as complet_weekday
 from courseenrollments;
 
 /*24. Display the number of days from EnrollmentDate until the current date using
TIMESTAMPDIFF() and CURDATE().*/
select enrollmentdate,
        current_date(),
        timestampdiff(day , enrollmentdate , curdate()) as no_of_days
 from courseenrollments;       
 
 /*25. Display the original CompletionDate and its date after adding 15 days, formatted as
DD/MM/YYYY using DATE_ADD() and DATE_FORMAT().*/
select completiondate,
       date_format(date_add(completiondate , interval 15 day ),'%d/%m/%y') as edited_date
from courseenrollments; 
      