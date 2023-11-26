SELECT * FROM TechTFQ.login;
SELECT * FROM TechTFQ.Doctor;
SELECT * FROM TechTFQ.EMPLOYEE;
SELECT * FROM TechTFQ.patient;
SELECT * FROM TechTFQ.Student;

-- count of doctors in each hospital
SELECT hospital, count(name)
FROM TechTFQ.Doctor
group by hospital
order by count(name) desc;

-- count of doctors in each specialty
SELECT specialty, count(name)
FROM TechTFQ.Doctor
group by specialty
order by count(name) desc;

-- average consultation fee for doctors
select avg(consultation_fee)
from TechTFQ.Doctor;

-- city count
select city, count(city)
from TechTFQ.Doctor
group by city;

-- city count for each specialty
SELECT specialty, count(city)
FROM TechTFQ.Doctor
group by specialty
order by count(city) desc;

-- hospital with multiple doctors
SELECT name, specialty, hospital,
row_number() OVER (PARTITION BY hospital order by ID) AS hospital_name
FROM TechTFQ.Doctor
order by hospital;

SELECT Hospital
FROM (SELECT name, specialty, hospital, consultation_fee,
	row_number() OVER (PARTITION BY hospital order by ID) AS hospital_name
	FROM TechTFQ.Doctor) AS x
WHERE x.hospital_name > 1;

-- total sum of consultation fee for each hospital
Select hospital, hospital_pay
From(SELECT hospital, 
	sum(consultation_fee) over(partition by hospital) as hospital_pay,
	row_number() over (partition by hospital) as r
	FROM TechTFQ.Doctor
	group by hospital, consultation_fee) as x
where x.r = 1
order by hospital_pay desc;

-- consultation_fee between 1000-2000
SELECT * 
FROM TechTFQ.Doctor
where consultation_fee between 1000 and 2000
order by consultation_fee desc;

-- manipal city doctors
SELECT * 
FROM TechTFQ.Doctor
where city in ('Manipal');

SELECT * 
FROM TechTFQ.Doctor
where city = 'Manipal'
order by consultation_fee desc;

-- max and min fee per specialty greater than 1000
SELECT specialty, max(consultation_fee) as Max_fee, min(consultation_fee) as Min_fee
FROM TechTFQ.Doctor
group by specialty
having Max_fee >= 2000 and Min_fee >= 1000;

-- hospital ranking by consultation fee and subquery to get the highest consultation fee
select hospital
from(SELECT hospital, consultation_fee,
	rank() over(partition by hospital order by consultation_fee desc) as rn
	FROM TechTFQ.Doctor) as x
where x.rn = 1;

SELECT * FROM TechTFQ.Doctor;
SELECT * FROM TechTFQ.Doctor;
SELECT * FROM TechTFQ.Doctor;