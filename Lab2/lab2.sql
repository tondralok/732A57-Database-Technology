
/*

Lab 2 report (Rabnawaz Jansher,Saman Zahid)  and (rabsh696,samza595)

*/

/* Have the source scripts in the file so it is easy to recreate!*/
SOURCE company_schema.sql;
SOURCE company_data.sql;


/*3)
question 3: Implement your extensions in the database by first creating tables, if any, 
then populating them with existing manager data, then adding/modifying foreign key constraints. 
Do you have to initialize the bonus attribute to a value? Why?

*/

create table jbmanager (
	id int(10) not null,
	bonus int(10) default 0,
	primary key(id),
	foreign key(id) references jbemployee(id)
	);


/*
Query OK, 0 rows affected (0.03 sec)
*/

insert jbmanager(id) (select manager from jbemployee where jbemployee.manager is not NULL) 
	union 
	(select manager from jbdept where jbdept.manager is not null);


/*
Query OK, 12 rows affected (0.07 sec)
Records: 12  Duplicates: 0  Warnings: 0
*/



alter table jbemployee drop foreign key fk_emp_mgr;

/*
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

 alter table jbemployee add constraint fk_emp_mgr foreign key(manager) 
 references jbmanager(id);

/*
Query OK, 25 rows affected (0.14 sec)
Records: 25  Duplicates: 0  Warnings: 0
*/

 alter table jbdept drop  foreign key fk_dept_mgr;

 /*
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0
 */

 alter table jbdept add constraint fk_dept_mgr foreign key(manager) references jbmanager(id);

/*
Query OK, 19 rows affected (0.10 sec)
Records: 19  Duplicates: 0  Warnings: 0
*/


/*

Explanation why?

Since we have to add bonus to the manager's salary, we have to initialize 
the bonus attribute to a value because if it will be NULL, (salary + NULL) 
would be null for the employees for whom there is no bonus.
*/

/*
question 4) All departments showed good sales figures last year! Give all current department managers $10,000 in bonus.
 This bonus is an addition to other possible bonuses they have. Hint: Not all managers are department managers. 
 Update all managers that are referred in the jbdept relation

*/

update jbmanager set bonus = bonus + 10000 where id in (select manager from  jbdept);


/*
Query OK, 11 rows affected (0.05 sec)
Rows matched: 11  Changed: 11  Warnings: 0
*/


/*
question 5b) Implement your extensions in your database. Add primary key constraints, foreign key constraints and integrity 
constraints to your table definitions. Do not forget to correctly set up the new and existing foreign keys

*/
 #customer table

create table jbcustomer (  
	id int not null,  
	name varchar(100),  
	street_address varchar(200),  
	city int,  primary key(id),  
	foreign key(city) references jbcity(id)  );

/*

Query OK, 0 rows affected (0.11 sec)
*/


create table jbaccounts(
	account_number varchar(200) not null,
	customer int(10) ,
	balance int default 0,
	primary key(account_number),
	foreign key(customer) references jbcustomer(id) 
	);


/*
Query OK, 0 rows affected (0.02 sec)
*/

create table jbtransaction (
	id int not null ,
	employee int not null,
	sdate timestamp  DEFAULT CURRENT_TIMESTAMP,
	account varchar(200) not null,
	primary key(id),
	foreign key(employee) references jbemployee(id),
	foreign key(account) references jbaccounts(account_number)
);


/*
Query OK, 0 rows affected (0.06 sec)

*/
insert into jbcustomer (id,name,street_address,city) values (1,"saman","ryd",100);

/*
Query OK, 1 row affected (0.08 sec)
*/	


insert into jbaccounts(account_number,customer)  (select distinct jbdebit.account,jbcustomer.id from jbdebit,jbcustomer);


/*
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0
*/


insert into jbtransaction (id,employee,sdate,account) (select id,employee,sdate,account from jbdebit);


/*
Query OK, 6 rows affected (0.02 sec)
Records: 6  Duplicates: 0  Warnings: 0
*/

alter table jbsale drop foreign key fk_sale_debit;

/*
Query OK, 0 rows affected (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

alter table jbdebit drop primary key;

/*
Query OK, 6 rows affected (0.06 sec)
Records: 6  Duplicates: 0  Warnings: 0
*/


alter table jbdebit drop foreign key fk_debit_employee;

/*
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/



drop table jbdebit;

/*
Query OK, 0 rows affected (0.01 sec)
*/


create table jbdebit (
	id int(10) not null AUTO_INCREMENT,
	transaction int(10),
	primary key(id),
	foreign key(transaction) references jbtransaction(id)

);


/*
Query OK, 0 rows affected (0.03 sec)
*/
insert into jbdebit(transaction) (select id from jbtransaction)

/*
Query OK, 6 rows affected (0.10 sec)
Records: 6  Duplicates: 0  Warnings: 0
*/

create table jbwithdraw (
	id int(10) not null AUTO_INCREMENT,
	transaction int(10),
	primary key(id),
	foreign key(transaction) references jbtransaction(id)

);

/*
Query OK, 0 rows affected (0.06 sec)
*/
create table jbdeposit (
	id int(10) not null AUTO_INCREMENT,
	transaction int(10),
	primary key(id),
	foreign key(transaction) references jbtransaction(id)

);

/*
Query OK, 0 rows affected (0.05 sec)
*/

