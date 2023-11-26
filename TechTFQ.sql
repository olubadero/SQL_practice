SELECT * FROM TechTFQ.login;
SELECT * FROM TechTFQ.Doctor;
SELECT * FROM TechTFQ.EMPLOYEE;
SELECT * FROM TechTFQ.patient;
SELECT * FROM TechTFQ.Student;


-- list out the name of all employees in each department (use the Group_concat function)
SELECT Department, GROUP_CONCAT(NAME)
FROM TechTFQ.EMPLOYEE
GROUP BY Department;

-- Analysing Specialty pay
-- total consultation_fee


-- total pay per specialty
SELECT specialty, sum(consultation_fee)
FROM TechTFQ.Doctor
GROUP BY specialty
ORDER BY 2 DESC;

-- highest pay by specialty
SELECT specialty, MAX(consultation_fee)
FROM TechTFQ.Doctor
GROUP BY specialty
ORDER BY 2 DESC;

-- Average pay
SELECT specialty, ROUND(avg(consultation_fee)),
ROW_NUMBER() OVER (Partition by specialty) as specialty
FROM TechTFQ.Doctor
group by specialty, hospital
ORDER BY 2 DESC;

-- highest paid doctor
SELECT name, specialty, hospital, consultation_fee
FROM TechTFQ.Doctor
ORDER BY 4 DESC
LIMIT 1;

SELECT name, specialty, MAX(consultation_fee)
FROM TechTFQ.Doctor
GROUP BY name, specialty
ORDER BY 3 DESC
LIMIT 1;

-- Hospitals with physicians
SELECT Distinct(Hospital)
FROM TechTFQ.Doctor
WHERE specialty = 'physician';

-- Hospital with multiple practitioners
SELECT Hospital
FROM (SELECT name, specialty, hospital,
row_number() OVER (PARTITION BY hospital order by ID) AS hospital_name
FROM TechTFQ.Doctor) AS x
WHERE x.hospital_name > 1;


-- 4th highest paid doctor

SELECT Name, specialty, hospital, consultation_fee
FROM (SELECT *,
ROW_NUMBER() OVER (ORDER BY CONSULTATION_FEE DESC) AS PAY
FROM TechTFQ.Doctor) AS X
WHERE X.PAY = 4;

-- Maximum and Minimum salary per department
SELECT distinct department,
MAX(SALARY) OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) as Max_salary,
MIN(SALARY) OVER (PARTITION BY DEPARTMENT ORDER BY SALARY) as Min_salary
FROM TechTFQ.EMPLOYEE;


-- employee earning both highest or lowest salary per department
SELECT name, department, salary
FROM(SELECT name, department, Salary,
	MAX(SALARY) OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) as Max_salary,
	MIN(SALARY) OVER (PARTITION BY DEPARTMENT ORDER BY SALARY) as Min_salary
	FROM TechTFQ.EMPLOYEE) AS X
WHERE X.salary = x.min_salary or x.salary = x.max_salary;




SELECT X.*
FROM TechTFQ.EMPLOYEE AS Y
JOIN (SELECT *, 
	  Max(Salary) over (partition by department order by salary desc) as max,
	  Min(salary) over (partition by department order by salary) as min
	  FROM TechTFQ.EMPLOYEE) AS X
ON X.EMPLOYEE_ID = Y.EMPLOYEE_ID and (x.salary =x.min or x.salary = x.max)
ORDER BY x.department, x.salary DESC;


SELECT * FROM TechTFQ.patient;

-- salary increase but not updating actual table
SELECT *, 
CASE
	when department = 'admin' THEN salary + (salary * 0.05)
	when department = 'finance' THEN salary + (salary * 0.10)
	when department = 'hr' THEN salary + (salary * 0.03)
    else salary + (salary * 0.04)
END AS proposed_salary_increase
FROM TechTFQ.EMPLOYEE
ORDER BY  department, proposed_salary_increase desc;


-- average salary per department (greater than 5000) 
SELECT department, round(avg(salary)) AS Average_Salary
FROM TechTFQ.EMPLOYEE
GROUP BY department
HAVING avg(salary) >= 5000;


# From the login_details table, fetch the users who logged in consecutively 3 or more times on the same day.
-- Solution:
SELECT distinct(user_name)
FROM(SELECT *, CASE WHEN lead(user_name) OVER(ORDER BY Login_date) = user_name
				AND lead(user_name, 2) OVER(ORDER BY Login_date) = user_name
                THEN 'Fits'
                ELSE Null
                END as login_repeat
FROM TechTFQ.login
ORDER BY login_date) as x
WHERE X.login_repeat = 'Fits';


# From the doctors table, fetch the details of doctors who work in the same hospital but in different specialty.

SELECT D1.NAME, D1.HOSPITAL, D1.SPECIALTY
FROM TECHTFQ.Doctor AS D1
JOIN TECHTFQ.Doctor AS D2
ON d1.ID <> d2.ID AND d1.hospital = d2.hospital AND d1.SPECIALTY <> d2.SPECIALTY;

# from the employee table, Write a SQL query to fetch the second last record from employee table.
-- Solution:
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, SALARY
FROM(SELECT *, ROW_NUMBER() OVER(ORDER BY employee_id DESC) as staff_order
FROM TechTFQ.EMPLOYEE) AS X
WHERE X.staff_order = 2;

# from the users table, Write a SQL Query to fetch all the duplicate records in a table.
SELECT user_name, email, count(*) as duplicates
FROM TechTFQ.users
GROUP BY user_name, email
HAVING duplicates > 1;


SELECT user_id, user_name, email
FROM(SELECT user_id, user_name, email, 
	ROW_NUMBER() OVER(PARTITION BY user_name ORDER BY user_id) as Duplicates
	FROM TechTFQ.USERS) as X
WHERE x.duplicates > 1;


# From the students table, write a SQL query to interchange the adjacent student names.
-- Solution:

select student_id, name,
case when student_id%2 <> 0 then lead(name,1,name) over(order by student_id)
when student_id%2 = 0 then lag(name) over(order by student_id) end as new_student_name
from TechTFQ.student;

# From the patient table Find the top 2 accounts with the maximum number of unique patients on a monthly basis.

SELECT account_id, Month, Patients
FROM(SELECT *, row_number() over(partition by month) as rn
FROM(SELECT account_id, Month, count(patient_id) as patients
	FROM (SELECT  distinct(patient_id), account_id, monthname(date) as Month
	FROM TechTFQ.patient) as details
	GROUP BY account_id, Month
	ORDER BY patients DESC, Month) as patient_count) AS top_2
WHERE top_2.rn <= 2;

