create database bank1;
use bank1;

create table customer(
cust_id int primary key,
name varchar(50) not null,
email varchar(25) unique,
age int check(age>=18),
phone_no varchar(11),
city varchar(15)
);
desc customer;
-- drop table customer;

create table account(
acc_no int primary key,
cust_id int not null,
balance decimal(15,2) default '0',
acc_type enum("Savings","Current"),
branch_id int not null,
constraint foreign key(cust_id) references customer(cust_id) ,
constraint foreign key(branch_id) references branch(branch_id)
);
desc account;
-- drop table account;

create table loan(
loan_id int primary key,
cust_id int not null,
loan_amount decimal(12,2),
interest_rate int not null default 0,
start_date date not null,
end_date date not null,
loan_type varchar(20) default "NA",
loan_status enum("pending","completed","defaulted"),
constraint foreign key(cust_id) references customer(cust_id) 
);
desc loan;
-- drop table loan;

create table branch(
branch_id int primary key,
name varchar(25),
location varchar(20)
);
desc branch;
-- drop table branch;

insert into customer(cust_id,name,email,age,phone_no,city) values
(101,"Amit Sharma","amitsharma@gmail.com",50,9638527410,"Thane"),
(102,"Priya Patel","priyap@gmail.com",18,9147258369,"Pune"),
(103,"Rajesh Kumar","rajeshk@gmail.com",25,8741259635,"Chennai"),
(104,"Vikram Singh","vikrams@gmail.com",40,7723568901,"Pune"),
(105,"Anjali Desai","anjalid@gmail.com",32,8974563210,"Surat"),
(106,"Manoj Nair","manojn@gmail.com",64,7832165789,"Thane"),
(107,"Sneha Reddy","snehar@gmail.com",22,9321545442,"Chennai")
;
select* from customer;

insert into account(acc_no,cust_id,balance,acc_type,branch_id) values
(0011,102,25000.00,"Savings",1),
(0022,101,100000.70,"Current",3),
(0033,104,64540.82,"Savings",1),
(0044,106,40000.50,"Savings",2),
(0055,105,8400.50,"Current",1),
(0066,102,24000.00,"Current",2),
(0077,107,9564.82,"Savings",2),
(0088,101,274000.00,"Savings",3),
(0099,103,81000.41,"Current",1)
;
select* from account;

insert into branch(branch_id,name,location) values
(1,"City Center Branch","Maharashtra"),
(2,"GreenWood Plaza Branch","Gujarat"),
(3,"WestField Branch","Tamil Nadu")
;
select* from branch;

insert into loan (loan_id,cust_id,loan_amount,interest_rate,start_date,end_date,loan_type,loan_status) values 
(200011,102,150000,7,"2022-08-21","2028-01-21","personal_loan","pending"),
(200022,102,350000,7,"2019-11-08","2023-05-16","car_loan","completed"),
(200033,104,150000,7,"2020-04-02","2030-02-28","home_loan","pending"),
(200044,105,200000,7,"2018-09-10","2025-11-08","personal_loan","defaulted")
;
select* from loan;


select* from customer;
select* from account;
select* from branch;
select* from loan;

desc customer;
desc account;
desc branch;
desc loan;


-- ----------------------------------------------------------------------------------------------------------------------------
-- 1 add constraint unique phone number
alter table customer add constraint unique_phone unique(phone_no); 
desc customer;

-- 2 set interest rate=10 where loan type is personal_loan
update loan set interest_rate=10 where loan_type="personal_loan";
select* from loan;

-- 3 update balance of acc_no. 11
update account set balance=35000 where acc_no=11;
select* from account;

-- 4 acc_no having balance<=40000
select acc_no from account where balance<=40000;

-- 5 display unique city in customer
select distinct(city) from customer;-- ----

-- 6 days remaiming for loan completion
select loan_id,if(datediff(end_date, curdate()) < 0, 0, datediff(end_date, curdate())) as days_difference from loan;-- ----

-- 7 loan details whose loans are not completed
select * from loan where loan_status != "completed";

-- 8 customers whose is either greater than 35 or lives in thane
select * from customer where age>35 or city="Thane";

-- 9 account details where branch_id is 1 and balance is greater than or equal to 50000
select * from account where branch_id=1 and balance>=50000;

-- 10 account details in descending order of balance
select acc_no,cust_id,balance from account
order by balance desc;

-- 11 display the highest balance
select acc_no, balance from account 
order by balance desc
limit 1;

-- 12 display the branches present in given location -Maharashtra,Gujarat,UttarPradesh
select * from branch where location in ("Maharashtra","Gujarat","UttarPradesh");

-- 13 gain loan_id  whose loan has been completed
select * from customer where cust_id=(select cust_id from loan where end_date<curdate());

-- 14 get account details where account holders have balance greater than average balance 
select * from account where balance>(select avg(balance) from account);

-- 15 find name of customers whose loan status is pending
select name,loan_id,loan_status
from customer
right join loan
on customer.cust_id=loan.cust_id
where loan_status="pending";

-- 16 customer who had or are holding an loan
select name,loan_id
from customer 
inner join loan
on customer.cust_id=loan.cust_id;

-- 17 customers having account in City Center Branch 
select customer.cust_id,customer.name,account.branch_id
from customer 
left join account
on customer.cust_id=account.cust_id
where account.branch_id=(select branch.branch_id from branch where name="City Center Branch");


-- 18 get the average balance in each branch 
select branch_id,avg(balance) from account group by branch_id;
    
-- 19 Get the highest balance in a 'Savings' account for customers in 'Tamil Nadu'.
select max(balance) from account where acc_type="Savings"and branch_id=(select branch_id from branch where location="Tamil Nadu");

-- 20 loan details where interest is greater than or equal to 7 and has a loan period of 5 years
select * from loan where interest_rate<=7 and datediff(end_date,start_date)>365*5;

-- 21 get customer id who have more than one account
select cust_id,count(acc_no) from account group by cust_id having count(acc_no)>1;

-- 22 loan id who has 2nd highest loan_amount
select * from loan order by loan_amount desc limit 1 offset 1;

-- 23 customers having more than 1 loan
select cust_id,name from customer where cust_id =(select cust_id from loan group by cust_id having count(loan_id)>1);

-- 24 customers who have taken loan
select customer.cust_id,name, loan_id
from customer
left join loan 
on customer.cust_id=loan.cust_id;

-- 25 
select cust_id,sum(balance),count(acc_no) from account group by cust_id;

select ,loan_id,loan_amount
from account 
join loan
on account.cust_id=loan.cust_id
;



-- 26 create a view of customer details who have accounts in Maharshtra
create view Maharashtra_customers as
select * from customer where 
cust_id in (select cust_id from account where branch_id=(select branch_id from branch where location="Maharashtra"));

select * from Maharashtra_customers;
update Maharashtra_customers set city="Thane" where cust_id=105;
select * from Maharashtra_customers;

-- 27 display customer details along with number of accounts he/she holds and total amount in his accounts
select customer.cust_id,customer.name ,count(account.acc_no),sum(account.balance)
from customer
join account
on customer.cust_id=account.cust_id
group by customer.cust_id;



-- ---------------------------------------------------------------------------------------------------------------

-- ----------------------------------------------------------		1. Write a query  to add unique constraint to phone_no column   ----------------------------------------------------------		
alter table customer add constraint unique_phone unique(phone_no); 
desc customer;

-- ----------------------------------------------------------  		2. Write a query to update interest rate to 10 for all loans of type personal loan in loan table   ----------------------------------------------------------		
update loan set interest_rate=10 where loan_type="personal_loan";
select* from loan;

-- ----------------------------------------------------------		3. Write a query to update balance to 35000 for account number 11   ----------------------------------------------------------		
update account set balance=35000 where acc_no=11;
select* from account;

-- ----------------------------------------------------------		4. Write a query to get account numbers where balance is greater or equal to 40000   ----------------------------------------------------------		
 select acc_no from account where balance<=40000;

-- ----------------------------------------------------------		5. Write a query to get list of distinct cities from customer table   ----------------------------------------------------------		
select distinct(city) from customer;-- ----

-- ----------------------------------------------------------		6. Write a query to get loan details of whose loans are not completed   ----------------------------------------------------------		
select * from loan where loan_status != "completed";

-- ----------------------------------------------------------		7. Write a query to get details of customers whose age is greater than 35 or the city is "Thane."   ----------------------------------------------------------		
select * from customer where age>35 or city="Thane";

-- ----------------------------------------------------------		8.  Write a query to get account details whose branch id is 1and has balance greater than or equal to 50000   ----------------------------------------------------------		
select * from account where branch_id=1 and balance>=50000;

-- ----------------------------------------------------------		9. Write a query to get account details in descending order of balance   ----------------------------------------------------------		
select acc_no,cust_id,balance from account
order by balance desc;

-- ----------------------------------------------------------		10. Write a query to get account with highest balance   ----------------------------------------------------------		
select acc_no, balance from account 
order by balance desc
limit 1;

-- ----------------------------------------------------------		11. Write a query to get number of days remaining for the loan to be completed from the current date   ----------------------------------------------------------		
select loan_id,if(datediff(end_date, curdate()) < 0, 0, datediff(end_date, curdate())) as days_difference from loan;

-- ----------------------------------------------------------		12. Write a query to get branch details where location is either “Maharashtra”,” Gujarat” or “UttarPradesh”   ----------------------------------------------------------		
select * from branch where location in ("Maharashtra","Gujarat","UttarPradesh");

-- ----------------------------------------------------------		13. Write a query to get customer details whose loans have been completed   ----------------------------------------------------------		
select * from customer where cust_id=(select cust_id from loan where end_date<curdate());

-- ----------------------------------------------------------		14. Write a query to get account details where account holders have balance greater than average balance   ----------------------------------------------------------		
select * from account where balance>(select avg(balance) from account);

-- ----------------------------------------------------------		15. Write a query to get customer who had or are holding an loan   ----------------------------------------------------------		
select name,loan_id
from customer 
inner join loan
on customer.cust_id=loan.cust_id;

-- ----------------------------------------------------------		16. Write a query to get customers havin an account in City Center Branch   ----------------------------------------------------------		
select customer.cust_id,customer.name,account.branch_id
from customer 
left join account
on customer.cust_id=account.cust_id
where account.branch_id=(select branch.branch_id from branch where name="City Center Branch");

-- ----------------------------------------------------------		17. Write a query to get the average balance in each branch   ----------------------------------------------------------		
select branch_id,avg(balance) from account group by branch_id;
    
-- ----------------------------------------------------------		18. Write a query to get highest balance in a 'Savings' account for customers in 'Tamil Nadu'.   ----------------------------------------------------------		
select max(balance) from account where acc_type="Savings"and branch_id=(select branch_id from branch where location="Tamil Nadu");

-- ----------------------------------------------------------		19. Write a query to get loan details where interest is greater than or equal to 7 and has a loan period of 5 years   ----------------------------------------------------------		
select * from loan where interest_rate<=7 and datediff(end_date,start_date)>365*5;

-- ----------------------------------------------------------		20. Write a query to get customers’s id who have more than 1 account   ----------------------------------------------------------		
select cust_id,count(acc_no) from account group by cust_id having count(acc_no)>1;

-- ----------------------------------------------------------		21. Write a query to get loan id with 2nd highest loan amount   ----------------------------------------------------------		
select * from loan order by loan_amount desc limit 1 offset 1;

-- ----------------------------------------------------------		22. Write a query to get customer id and name who have more than 1 loan   ----------------------------------------------------------		
select cust_id,name from customer where cust_id =(select cust_id from loan group by cust_id having count(loan_id)>1);

-- ----------------------------------------------------------		23. Write a query to get customers details who have taken or not taken a loan   ----------------------------------------------------------		
select customer.cust_id,name, loan_id
from customer
left join loan 
on customer.cust_id=loan.cust_id;

-- ----------------------------------------------------------		24. Write a query to create a view called Maharashtra_customers that includes all customers who have an account at a branch located in "Maharashtra.   ----------------------------------------------------------		
create view Maharashtra_customers as
select * from customer where 
cust_id in (select cust_id from account where branch_id=(select branch_id from branch where location="Maharashtra"));

-- ----------------------------------------------------------	     Update the city of the customer with cust_id = 105 to "Thane" in the Maharashtra_customers view   ----------------------------------------------------------		
select * from Maharashtra_customers;
update Maharashtra_customers set city="Thane" where cust_id=105;
select * from Maharashtra_customers;

-- ----------------------------------------------------------		25. Write a query to get customer details along with number of accounts he/she holds and total amount in his accounts   ----------------------------------------------------------		

select customer.cust_id,customer.name ,count(account.acc_no),sum(account.balance)
from customer
join account
on customer.cust_id=account.cust_id
group by customer.cust_id;










