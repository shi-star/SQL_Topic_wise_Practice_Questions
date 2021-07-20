Use hr
-- 1. Write a query to display the last day of the month (in datetime format) three months before the current month.
select last_day(subdate(current_date(), interval 3 month))

-- 2. Write a query to get the distinct Mondays from hire_date in employees tables.
select distinct(hire_date) from employees
where dayofweek(hire_date)= 2

-- 3.Write a query to get the first day of the current year.
SELECT MAKEDATE(EXTRACT(YEAR FROM CURDATE()),1);

-- 4.Write a query to get the last day of the current year.
Select makedate(extract(year from curdate()),31)

-- 5.Write a query to calculate the age in year
select ('2021-07-20' - '1992-06-20')

-- 6.Write a query to get the current date in the following format. Go to the editor
-- Sample date : 2014-09-04
-- Output : September 4, 2014
select date_format(curdate(), '%M %d, %Y' )

-- 7.Write a query to get the current date in Thursday September 2014 format. Go to the editor
-- Thursday September 2014
select date_format(curdate(), '%W %M  %Y' )

-- 8.Write a query to extract the year from the current date.
select year(curdate())

-- 9.Write a query to get the DATE value from a given day (number in N). Go to the editor
-- Sample days: 730677
-- Output : 2000-07-11
SELECT FROM_DAYS(730677);

-- 10. Write a query to get the first name and hire date from employees table where hire date between '1987-06-01' and '1987-07-30' 
select first_name, hire_date from employees 
where hire_date between '1987-06-01' and '1987-07-30'

-- 11.Write a query to display the current date in the following format.
-- Sample output: Thursday 4th September 2014 00:00:00
select date_format(curdate(), "%W %D %M %Y %H:%i:%s")

-- 12.Write a query to display the current date in the following format.
-- Sample output: 05/09/2014
select date_format(curdate(), '%d/%m/%Y')

-- 13. Write a query to display the current date in the following format.
-- Sample output: 12:00 AM Sep 5, 2014
select date_format(curdate(), '%l:%i %p %b %d, %Y')

-- 14.Write a query to get the firstname, lastname who joined in the month of June.
select first_name, last_name from employees
where monthname(hire_date) = 'June'

-- 15.Write a query to get the years in which more than 10 employees joined.
select year(hire_date) from employees
group by year(hire_date)
having count(employee_id > 10)

-- 16.Write a query to get first name of employees who joined in 1987.
select first_name from employees
where year(hire_date) = 1987

-- 17.Write a query to get department name, manager name, and salary of the manager for all managers whose experience is more than 5 years.
select departments.department_name, e.first_name, e.salary from employees e
inner join departments on departments.manager_id = e.manager_id
where (sysdate()-e.hire_date)/365 >5

-- 18.Write a query to get employee ID, last name, and date of first salary of the employees.
Select employee_id, last_name, last_day(hire_date) from employees 

-- 19.Write a query to get first name, hire date and experience of the employees.
select first_name, hire_date, datediff(sysdate(),hire_date)/365 as experience from employees

-- 20.Write a query to get the department ID, year, and number of employees joined.
select department_id, year(start_date), count(employee_id) from job_history
group by department_id, year(start_date)
order by department_id






