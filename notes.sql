/*SQL - Structured Query Language
Use to manage and query the data
4 Types of statement
1. DDL - Data Definition Langugage
(CREATE, DROP, ALTER, TRUNCATE)
2. DML = Data Manipulaton Language
(INSERT, UPDATE, DELETE, MERGE)
3. DQL - Data Query Language
(Select)
4. DCL - Data Control Language
(Grant, Revoke, Commit, Rollback)
*/

--select * from sales.customers
--select first_name,last_name , email from sales.customers
--select first_name + ' ' + last_name "Fullname" from sales.customers
--select s.email from sales.customers s

/* Sorting of Data
- Order by Clause
- Order it in ascending
- Order it in descending
*/
/*
select first_name,last_name,city,zip_code 
from sales.customers
order by first_name desc,last_name desc
*/

/* Where Clause filters
Relational Operators like (==,!= , > , < , <=, >=)
In, not in
Is Null, is Not Null
like (%,_)
Logical operators like (And ,Or, Not)
Between
*/

--Filtering : Where Clause
--select * from sales.customers where zip_code = '12010'
/*select * from sales.customers 
where zip_code != '12010' 
order by zip_code
*/

--select * from production.stocks where quantity >= 20 order by quantity;
/*select * from production.stocks where
quantity < 20 
and 
quantity > 0 
and 
store_id = 1
order by quantity
*/

/*select state , first_name,city from sales.customers 
where city = 'Apple Valley' or (state != 'CA' and state != 'NY') 
*/

/*

select state , first_name,city from sales.customers 
where state  in ('CA','NY')

select state , first_name,city from sales.customers 
where state not in ('CA','NY')

select * from sales.customers where phone is null

select * from sales.customers where phone is not null

--select distinct state, city from sales.customers
*/
/*
select * from sales.customers where first_name like 'An%'

select * from sales.customers where first_name like '%in'

select * from sales.customers where first_name like '%St%'

select * from sales.customers where first_name like '____St%'

select * from sales.customers where first_name like 'Er__St'

select * from production.products
where model_year not between 2016 and 2018
*/
/* Aggregation and filtering: Group By and Having Clause*/

/* Group Functions */

select count(*) from production.products

select count(model_year),count(distinct model_year) from production.products

select count(*) "total produts", max(list_price) "Maximum Price", min(list_price) ,
avg(list_price)
from production.products where model_year = 2019

select model_year, count(*) "total produts", max(list_price) "Maximum Price", 
min(list_price) , avg(list_price)
from production.products group by model_year

select * from production.products

select count(phone) ,count(*) from sales.customers

select count(*) from sales.customers where phone is not null

select model_year, count(model_year) "noofproducts",
sum(list_price) "total price", avg(list_price) as "Average Price"
from production.products 
group by model_year
having count(model_year)  > 50

select product_name,model_year , list_price,
avg(list_price) over (partition by model_year) as "avgprice",
list_price - avg(list_price) over (partition by model_year) as "difference"
from production.products 
having avg(list_price) > 750


select TOP(10) * from  production.products  ORDER BY MODEL_YEAR DESC

SELECT  TOP 20 PERCENT * FROM PRODUCTION.PRODUCTS


SELECT SUBTABLE.* FROM (SELECT PRODUCT_NAME, MODEL_YEAR, CATEGORY_ID, LIST_PRICE 
FROM PRODUCTION.PRODUCTS WHERE MODEL_YEAR = 2016) AS "SUBTABLE"
WHERE SUBTABLE.CATEGORY_ID = 3


select format(8999639478, '###-###-####')
Select list_price,
format(list_price, N'C', N'en-In') from PRODUCTION.PRODUCTS
select format(GETDATE(),'yyyy-MMM-dd')

select * from production.products

select * from production.categories

select trim(category_name), upper(category_name), left(category_name,5), len(category_name) ,right(category_name,5)
from production.categories

select category_name ,patindex('%BI_y%',category_name) 
from production.categories

select category_name, replace(category_name, 'Bikes' , 'MotorBikes')
, reverse(category_name)
from production.categories

select 


update production.categories
set category_name =  trim(category_name)

Select list_price, len(list_price) , str(list_price)
 from PRODUCTION.PRODUCTS

select substring(product_name,5,10) from production.products

select current_timestamp, GETDATE()

select YEAR(getdate()),Month(getdate()), day(getdate())

select dateadd(year,2,getdate()) "2 years after current date",
dateadd(year,-2,getdate()) "2 years before current date"

select dateadd(MONTH,2,getdate()) "2 months after current date",
dateadd(month,-2,getdate()) "2 months before current date"

-- DAY, WEEK, HOUR, MINUTE, SECOND, MILLISECOND

SELECT * FROM dbo.emp

select hiredate ,
datediff(Year,hiredate,format(getdate(),'yyyy-mm-dd')) ,
datediff(Month,hiredate,format(getdate(),'yyyy-mm-dd')) ,
Datename(Month,hiredate) ,
Datename(Weekday,hiredate) 
from emp

select isdate('2021-12-23'), SYSDATETIME(), getdate()



select * from emp



select sal , comm , round(sal,0) from emp

select list_price, round(list_price,1), 
ceiling(list_price) ,
floor(list_price),
abs(-10)
from production.products
select rand()*10 + 1



select * from emp

SELECT  sal, isnull(comm,0.00),
IIF (comm > 0.00, sal+comm , sal) AS total_salary
from emp

select isnull(phone,'phone not avaiable') from sales.customers

select USER_NAME()
select SYSTEM_USER



SELECT IIF (10 < 20, 'TRUE' ,  'FALSE') AS Result



SELECT ISNUMERIC ('Hello') AS Result;



Select ename,
 CASE
WHEN Sal >=8000 AND Sal <=10000 THEN 'Director'
WHEN Sal >=5000 AND Sal <8000 THEN 'Senior Consultant'
Else 'Director'
END AS Designation
from Emp


select * from production.products order by list_price desc

/*
Dense Rak is a window function that assign rank to each row within a partition
of a result set
*/

select product_id, product_name, list_price,
rank() over (order by list_price desc) price_rank,
dense_rank() over (order by list_price desc) price_dense_rank
from production.products


select product_id, item_id,sum(list_price) sales 
from sales.order_items group by cube (product_id,item_id)

select sum(list_price) from sales.order_items  --5726406.57

select product_id, item_id,sum(list_price) sales 
from sales.order_items group by product_id,rollup(item_id)

/* Joins - It is extracting a data from two or more tables based on the common key */
/* 3 Types of joins - Inner, Outer, Cross  */

-- Inner Join
select product_name,list_price, c.category_name from production.products p
inner join production.categories c on p.category_id = c.category_id
where list_price > 5000
order by product_name


select product_name,list_price, c.category_name,b.brand_name from production.products p
inner join production.categories c on c.category_id = p.category_id
inner join production.brands b on b.brand_id = p.brand_id
where list_price > 5000
order by product_name



-- Left Outer Join

select * from production.products
select * from sales.order_items


select product_name,order_id from production.products p
left join sales.order_items o on o.product_id = p.product_id
where o.order_id is null
order by order_id

select product_name,o.order_id from production.products p
left join sales.order_items o on o.product_id = p.product_id 
and o.order_id = 100
--left join sales.orders ord on ord.order_id = o.order_id and ord.order_id = 100
--where ord.order_id = 100
order by o.order_id desc


--Right join
select ename,dname from emp e 
right join dept d on e.deptno = d.deptno


--full join
select e.*,d.* from dept d full join emp e on 
e.deptno = d.deptno

--cross join
select e.*, d.*  from dept d cross join emp e
order by ename

--self join
select c1.city , 
c1.first_name + ' ' + c1.last_name as customer1,
c2.first_name + ' ' + c2.last_name as customer2
from sales.customers c1 inner join sales.customers c2 
on c1.customer_id > c2.customer_id and c1.city = c2.city
order by c1.city,
c1.first_name

select e.ename 'employee', m.ename 'manager' from emp e
inner join emp m on m.empno = e.mgr
order by m.ename

select * from sales.orders 
where customer_id in (
	select customer_id from sales.customers where city = 'New York')
	
select * from sales.customers
select * from salgrade

select  dname from dept 
where deptno in 
(
	select deptno from emp
	where sal > (
				select max(losal) from salgrade)
				)

CREATE TABLE dbo.Employee
(  
    EmployeeID int IDENTITY(1,1) PRIMARY KEY,
    FirstName nvarchar(50) NOT NULL,  
    LastName nvarchar(50) NOT NULL, 
    EMail nvarchar(50),
    Phone varchar(15),
    HireDate date,
    Salary Money
);

DROP TABLE IF EXISTS dbo.Employee;


INSERT INTO Employee(FirstName, LastName, EMail, Phone, HireDate, Salary)
VALUES('John','King','john.king@abc.com','123.123.0000','01-01-2015', 33000);






