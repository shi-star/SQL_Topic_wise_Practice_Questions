Create database Views
Use Views
create table Salesman(
salesman_id int primary key,
name varchar(20),
city varchar(20),
commission decimal(5,2));

Create table orders(
order_no int primary key,
purchase_amt decimal(6,2),
ord_date date,
cus_id int,
salesman_id int);


create table customer(
customer_id numeric(5) primary key,
cust_name varchar(15),
city varchar(15),
grade numeric(5),
salesman_id int,
foreign key (salesman_id) references salesman(salesman_id));

insert into orders values
(70001,150.5, '2012-10-05',3005,5002),
(70009,270.65,'2012-09-10',3001,5005),
(70002 ,      65.26  ,     '2012-10-05' , 3002 ,        5001),
(70004  ,     110.5   ,    '2012-08-17'  ,3009  ,       5003),
(70007   ,    948.5    ,   '2012-09-10',  3005   ,      5002),
(70005    ,   2400.6    ,  '2012-07-27' , 3007    ,     5001),
(70008  ,     5760       , '2012-09-10'  ,3002     ,    5001),
(70010   ,    1983.43     ,'2012-10-10'  ,3004      ,   5006),
(70003    ,   2480.4      ,'2012-10-10'  ,3009       ,  5003),
(70012     ,  250.45 ,     '2012-06-27'  ,3008  ,       5002),
(70011      , 75.29   ,    '2012-08-17'  ,3003   ,      5007),
(70013       ,3045.6   ,   '2012-04-25'  ,3002    ,     5001);


insert into salesman values
 (5001 , 'James Hoog' , 'New York',      0.15),
  (      5002 , 'Nail Knite' , 'Paris'    ,     0.13),
   (     5005 , 'Pit Alex'   , 'London'   ,    0.11),
    (    5006 , 'Mc Lyon'    , 'Paris'    ,     0.14),
     (   5007 ,'Paul Adam'  , 'Rome'     ,      0.13),
      (  5003 , 'Lauson Hen' , 'San Jose' ,     0.12);
      
insert into customer values
        (3002 , 'Nick Rimando'   , 'New York'    ,  100,       5001),
     (   3007  ,'Brad Davis'     , 'New York'   ,  200 ,       5001),
      (  3005  ,'Graham Zusi'    , 'California' ,   200  ,       5002),
       ( 3008  ,'Julian Green'   , 'London',  300    ,     5002),
        (3004  ,'Fabian Johnson' , 'Paris'      ,   300    ,     5006),
      (  3009  ,'Geoff Cameron'  , 'Berlin',   100     ,  5003),
       ( 3003  ,'Jozy Altidor'   , 'Moscow',   200      , 5007),
        (3001 , 'Brad Guzan'     , 'London',      null       ,  5005);


-- 1.Write a query to create a view for those salesmen belongs to the city New York. 
create view salesman_in_NY as 
select salesman_id, name, city 
from salesman 
where city = 'New York'

-- 2. Write a query to create a view for all salesmen with columns salesman_id, name, and city. 
create view staff_in as 
select salesman_id, name, city
from salesman

-- 3.Write a query to find the salesmen of the city New York who achieved the commission more than 13%.
select * from staff
where commission > 0.13;

-- 4.Write a query to create a view to getting a count of how many customers we have at each level of a grade.
Create or replace view count_cus as
select count(customer_id) , grade
from customer
group by grade

Select * from count_cus

-- 5.Write a query to create a view to keeping track the number of customers ordering, number of salesmen attached, average amount of orders and the total amount of orders in a day. 
Create or replace view info as 
select ord_date, count(distinct cus_id) , count(salesman_id), avg(purchase_amt), sum(purchase_amt)
from orders
group by ord_date

Select * from info

-- 6.Write a query to create a view that shows for each order the salesman and customer by name. 
Create or replace view salesman_cus as
select c.order_no, c.purchase_amt, a.name, b.cust_name
from salesman a, customer b, orders c
where a.salesman_id = c.salesman_id
And b.customer_id = c.cus_id

Select * from salesman_cus

-- 7.Write a query to create a view that finds the salesman who has the customer with the highest order of a day. 
Create or replace view salesman_top as
select s.name,  count(distinct o.order_no)
from salesman s, orders o
where s.salesman_id = o.salesman_id
group by s.name
order by count(distinct o.order_no)

select * from salesman_top

-- 8.Write a query to create a view that shows all of the customers who have the highest grade.
Create or replace view top_salesman as
Select * from customer
where grade = (select max(grade) from customer)

-- 9.Write a query to create a view that shows the number of the salesman in each city.
Create or replace view no_ofsalesman as
select count(salesman_id) , city 
from salesman
group by city

-- 10.Write a query to create a view that shows the average and total orders for each salesman after his or her name. (Assume all names are unique)
CREATE VIEW norders
AS SELECT name, AVG(purchase_amt), SUM(purchase_amt)
FROM salesman, orders
WHERE salesman.salesman_id = orders.salesman_id
GROUP BY name;

-- 11. Write a query to create a view that shows each salesman with more than one customers.
CREATE VIEW mcustomer
AS SELECT *
FROM salesman a
WHERE 1 <
   (SELECT COUNT(*)
     FROM customer b
     WHERE a.salesman_id = b.salesman_id);

-- 12.Write a query to create a view that shows all matches of customers with salesman such that at least one customer in the city of customer served by a salesman in the city of the salesman.
CREATE VIEW city_match(custcity, salesmancity, salesman, customer)
AS SELECT DISTINCT a.city, b.city, b.name, a.cust_name
FROM customer a, salesman b
WHERE a.salesman_id = b.salesman_id;

-- 13.Write a query to create a view that shows the number of orders in each day.
Create view total_ord as 
select ord_date, count(distinct order_no) 
from orders
group by ord_date

-- 14.Write a query to create a view that finds the salesmen who issued orders on October 10th, 2012.
Create view orders_on_10th_oct as 
select o.ord_date, o.salesman_id, s.name
from orders o, salesman s
where o.salesman_id = s.salesman_id and ord_date = '2012-10-10'

-- 15.Write a query to create a view that finds the salesmen who issued orders on either August 17th, 2012 or October 10th, 2012.
Create view orders_on as 
select o.ord_date, o.salesman_id, s.name
from orders o, salesman s
where o.salesman_id = s.salesman_id and ord_date in ('2012-10-10' , '2012-08-17')









      

