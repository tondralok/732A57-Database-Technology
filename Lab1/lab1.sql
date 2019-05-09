/*

Lab 1 report (Rabnawaz Jansher,Saman Zahid)  and (rabsh696,samza595)

*/

/* Have the source scripts in the file so it is easy to recreate!*/
SOURCE company_schema.sql;
SOURCE company_data.sql;


/*
Drop All views and tables created for this lab
*/
/*
drop view cost_charge2;
drop table newitem;
drop view jbsale_supply;
drop view item_view;

*/


/*
Question 1: List all employees, i.e. all tuples in the jbemployee relation.
*/


SELECT * FROM jbemployee;
/* Show the output for every question.
+------+--------------------+--------+---------+-----------+-----------+
| id   | name               | salary | manager | birthyear | startyear |
+------+--------------------+--------+---------+-----------+-----------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |
+------+--------------------+--------+---------+-----------+-----------+
25 rows in set (0.00 sec)
*/


/*
Question 2: List the name of all departments in alphabetical order. Note: by “name” we mean the name attribute for all tuples in the jbdept relation.
*/

/* */
SELECT * FROM jbdept ORDER BY name ASC;
/* 
+----+------------------+-------+-------+---------+
| id | name             | store | floor | manager |
+----+------------------+-------+-------+---------+
|  1 | Bargain          |     5 |     0 |      37 |
| 35 | Book             |     5 |     1 |      55 |
| 10 | Candy            |     5 |     1 |      13 |
| 43 | Children's       |     8 |     2 |      32 |
| 73 | Children's       |     5 |     1 |      10 |
| 19 | Furniture        |     7 |     4 |      26 |
| 99 | Giftwrap         |     5 |     1 |      98 |
| 14 | Jewelry          |     8 |     1 |      33 |
| 47 | Junior Miss      |     7 |     2 |     129 |
| 65 | Junior's         |     7 |     3 |      37 |
| 26 | Linens           |     7 |     3 |     157 |
| 20 | Major Appliances |     7 |     4 |      26 |
| 58 | Men's            |     7 |     2 |     129 |
| 60 | Sportswear       |     5 |     1 |      10 |
| 34 | Stationary       |     5 |     1 |      33 |
| 49 | Toys             |     8 |     2 |      35 |
| 28 | Women's          |     8 |     2 |      32 |
| 63 | Women's          |     7 |     3 |      32 |
| 70 | Women's          |     5 |     1 |      10 |
+----+------------------+-------+-------+---------+
19 rows in set (0.00 sec)
*/


/*
Question 3: What parts are not in store, i.e. qoh = 0? (qoh = Quantity On Hand).
*/
SELECT * FROM jbparts where qoh = 0;
/*
+----+-------------------+-------+--------+------+
| id | name              | color | weight | qoh  |
+----+-------------------+-------+--------+------+
| 11 | card reader       | gray  |    327 |    0 |
| 12 | card punch        | gray  |    427 |    0 |
| 13 | paper tape reader | black |    107 |    0 |
| 14 | paper tape punch  | black |    147 |    0 |
+----+-------------------+-------+--------+------+
4 rows in set (0.00 sec)
 */


/*
Question 4: Which employees have a salary between 9000 (included) and 10000 (included)?.
*/
SELECT * FROM jbemployee where salary >= 9000 and salary <= 10000;
/* 
+-----+----------------+--------+---------+-----------+-----------+
| id  | name           | salary | manager | birthyear | startyear |
+-----+----------------+--------+---------+-----------+-----------+
|  13 | Edwards, Peter |   9000 |     199 |      1928 |      1958 |
|  32 | Smythe, Carol  |   9050 |     199 |      1929 |      1967 |
|  98 | Williams, Judy |   9000 |     199 |      1935 |      1969 |
| 129 | Thomas, Tom    |  10000 |     199 |      1941 |      1962 |
+-----+----------------+--------+---------+-----------+-----------+
4 rows in set (0.00 sec)

*/



/*
Question 5: What was the age of each employee when they started working (startyear)?.
*/
SELECT name,(startyear - birthyear) as age FROM jbemployee;
/* 
+--------------------+------+
| name               | age  |
+--------------------+------+
| Ross, Stanley      |   18 |
| Ross, Stuart       |    1 |
| Edwards, Peter     |   30 |
| Thompson, Bob      |   40 |
| Smythe, Carol      |   38 |
| Hayes, Evelyn      |   32 |
| Evans, Michael     |   22 |
| Raveen, Lemont     |   24 |
| James, Mary        |   49 |
| Williams, Judy     |   34 |
| Thomas, Tom        |   21 |
| Jones, Tim         |   20 |
| Bullock, J.D.      |    0 |
| Collins, Joanne    |   21 |
| Brunet, Paul C.    |   21 |
| Schmidt, Herman    |   20 |
| Iwano, Masahiro    |   26 |
| Smith, Paul        |   21 |
| Onstad, Richard    |   19 |
| Zugnoni, Arthur A. |   21 |
| Choy, Wanda        |   23 |
| Wallace, Maggie J. |   19 |
| Bailey, Chas M.    |   19 |
| Bono, Sonny        |   24 |
| Schwarz, Jason B.  |   15 |
+--------------------+------+
25 rows in set (0.00 sec)
*/




/*
Question 6: Which employees have a last name ending with “son”?.
*/
SELECT * FROM jbemployee where name like "%son,%";	

/* 
+----+---------------+--------+---------+-----------+-----------+
| id | name          | salary | manager | birthyear | startyear |
+----+---------------+--------+---------+-----------+-----------+
| 26 | Thompson, Bob |  13000 |     199 |      1930 |      1970 |
+----+---------------+--------+---------+-----------+-----------+
1 row in set (0.00 sec)
*/


/*
Question 7:Which items (note items, not parts) have been delivered by a supplier called Fisher-Price? Formulate this 
query using a subquery in the where-clause.
*/
SELECT * FROM jbitem where supplier = (SELECT id FROM jbsupplier where name = "Fisher-Price");
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
+-----+-----------------+------+-------+------+----------+
3 rows in set (0.00 sec)

 */


/*
Question 8: Formulate the same query as above, but without a subquery.
*/

SELECT * FROM jbitem i INNER JOIN jbsupplier s ON i.supplier = s.id and s.name = "Fisher-Price";
/* 
+-----+-----------------+------+-------+------+----------+----+--------------+------+
| id  | name            | dept | price | qoh  | supplier | id | name         | city |
+-----+-----------------+------+-------+------+----------+----+--------------+------+
|  43 | Maze            |   49 |   325 |  200 |       89 | 89 | Fisher-Price |   21 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 | 89 | Fisher-Price |   21 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 | 89 | Fisher-Price |   21 |
+-----+-----------------+------+-------+------+----------+----+--------------+------+
3 rows in set (0.00 sec)
*/


/*
Question 9: Show all cities that have suppliers located in them. Formulate this query using a subquery in the where-clause.
*/

SELECT name as city_name FROM jbcity where id IN (SELECT city FROM jbsupplier);

/* 
+----------------+
| city_name      |
+----------------+
| Amherst        |
| Boston         |
| New York       |
| White Plains   |
| Hickville      |
| Atlanta        |
| Madison        |
| Paxton         |
| Dallas         |
| Denver         |
| Salt Lake City |
| Los Angeles    |
| San Diego      |
| San Francisco  |
| Seattle        |
+----------------+
15 rows in set (0.00 sec)
*/


/*
Question 10: What is the name and color of the parts that are heavier than a card reader? Formulate this query using a 
subquery in the where-clause. (The SQL query must not contain the weight as a constant.)
*/

SELECT name,color FROM jbparts where weight > (SELECT weight FROM jbparts where name = "card reader");

/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)
 */




/*
Question 11: Formulate the same query as above, but without a subquery. (The query must not contain the weight as a constant.)
*/

SELECT p2.name,p2.color FROM jbparts as p1, jbparts as p2 where p1.id <> p2.id and p1.name = "card reader" and p2.weight > p1.weight;

/* 
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)
*/



/*
Question 12: What is the average weight of black parts?
*/

select AVG(weight) as average_black_parts_weights FROM jbparts where color = "black";
/* 
+-----------------------------+
| average_black_parts_weights |
+-----------------------------+
|                    347.2500 |
+-----------------------------+
1 row in set (0.00 sec)
*/




/*
Question 13: What is the total weight of all parts that each supplier in Massachusetts (“Mass”) has delivered? 
Retrieve the name and the total weight for each of these suppliers. Do not forget to take the quantity of delivered parts into account. 
Note that one row should be returned for each supplier.

*/

SELECT T.name,sum(weight*T.quan) as total_weight FROM jbparts INNER JOIN (SELECT supplier,part,name,quan FROM jbsupply INNER JOIN (SELECT * FROM jbsupplier where city In (SELECT id FROM jbcity where state = "Mass")) as R on R.id = supplier) as T on  id = T.part GROUP BY T.name;


/*
+--------------+--------------+
| name         | total_weight |
+--------------+--------------+
| DEC          |         3120 |
| Fisher-Price |      1135000 |
+--------------+--------------+
2 rows in set (0.00 sec)
 */




/*
Question 14: Create a new relation (a table), with the same attributes as the table items using the 
CREATE TABLE syntax where you define every attribute explicitly (i.e. not as a copy of another table). 
Then fill the table with all items that cost less than the average price for items. Remember to define primary and foreign keys in your table!.

*/

CREATE table newitem(id INT(11), name VARCHAR(20),dept INT(11) NOT NULL,price INT(11), qoh INT(10) UNSIGNED, supplier INT(11) NOT NULL, PRIMARY KEY(id),FOREIGN KEY (dept) REFERENCES jbdept(id), FOREIGN KEY (supplier) REFERENCES jbsupplier(id) );

/* Query OK, 0 rows affected (0.03 sec)
*/

insert into newitem(id,name,dept,price,qoh,supplier) SELECT id,name,dept,price,qoh,supplier FROM jbitem where price < (SELECT AVG(price) FROM jbitem);

/*
Query OK, 14 rows affected (0.08 sec)
Records: 14  Duplicates: 0  Warnings: 0

*/

SELECT * FROM newitem;

/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
14 rows in set (0.00 sec)
*/


/*
Question 15: Create a view that contains the items that cost less than the average price for items.
*/

CREATE VIEW item_view AS (SELECT id,name,dept,price,qoh,supplier FROM jbitem where price < (SELECT AVG(price) FROM jbitem));

/*
Query OK, 0 rows affected (0.05 sec)
 */




/*
Question 16: What is the difference between a table and a view? One is static and the other is dynamic.
 Which is which and what do we mean by static respectively dynamic?
*/

/*
View is kind a virtual table based on result of some query or muliple queries , which contains the same columns and rows as the 
number of rows and columns in resultant query/table . View is dynamic ,because when we update a value in original table it also 
update and modify the value in view table which is act as dynamic virtual table/relation.

On other, table is static , based on result of some query. if we update in a original table in doesnot 
update in new table(which is clone of original table). so table is static.

 */




/*
Question 17: Create a view, using only the implicit join notation, i.e. only use where statements but no inner join, 
right join or left join statements, that calculates the total cost of each debit, by considering price and quantity of each bought item. 
(To be used for charging customer accounts). The view should contain the sale identifier (debit) and total cost.
*/

SELECT r.debit,SUM(r.total_cost) as total_cost FROM (SELECT S.debit,(S.quantity*R.price) As total_cost FROM jbsale S , (SELECT id,price FROM jbitem) As R where R.id=S.item) AS r GROUP BY r.debit;

/*
+--------+------------+
| debit  | total_cost |
+--------+------------+
| 100581 |       2050 |
| 100582 |       1000 |
| 100586 |      13446 |
| 100592 |        650 |
| 100593 |        430 |
| 100594 |       3295 |
+--------+------------+
6 rows in set (0.00 sec)
*/



/*
Question 18: Do the same as in (17), using only the explicit join notation, i.e. using only left, right or inner joins but no 
where statement. Motivate why you use the join you do (left, right or inner), and why this is the correct one (unlike the others).
*/


CREATE view cost_charge2 AS SELECT debit, SUM(total_cost) AS total_cost FROM (SELECT debit,I.price*S.quantity AS total_cost  FROM jbsale S INNER JOIN jbitem I on s.item = I.id) AS R GROUP BY R.debit;

/*
Query OK, 0 rows affected (0.10 sec)

+--------+------------+
| debit  | total_cost |
+--------+------------+
| 100581 |       2050 |
| 100582 |       1000 |
| 100586 |      13446 |
| 100592 |        650 |
| 100593 |        430 |
| 100594 |       3295 |
+--------+------------+
6 rows in set (0.00 sec)

 */




/*
Question 19: 
Oh no! An earthquake!
a) Remove all suppliers in Los Angeles from the table jbsupplier. This will not work right away (you will receive error code 23000) 
which you will have to solve by deleting some other related tuples. However, do not delete more tuples from other tables than necessary 
and do not change the structure of the tables, i.e. do not remove foreign keys. Also, remember that you are only allowed to use “Los Angeles” as 
a constant in your queries, not “199” or “900”.
*/


delete FROM jbsale where jbsale.item In (SELECT id FROM jbitem where supplier = (SELECT jbsupplier.id as id FROM jbsupplier INNER JOIN jbcity on jbsupplier.city = jbcity.id where jbcity.name = "Los Angeles"));


/* 
Query OK, 1 row affected (0.10 sec)
*/



delete FROM jbitem where supplier = (SELECT jbsupplier.id as id FROM jbsupplier INNER JOIN jbcity on jbsupplier.city = jbcity.id where jbcity.name = "Los Angeles");

/* 
Query OK, 2 rows affected (0.05 sec)
*/


delete FROM newitem where supplier = (SELECT jbsupplier.id as id FROM jbsupplier INNER JOIN jbcity on jbsupplier.city = jbcity.id where jbcity.name = "Los Angeles");

/* 
Query OK, 1 row affected (0.08 sec)
*/

delete FROM jbsupplier where city = (SELECT id FROM jbcity where name = "Los Angeles");

/* 
Query OK, 1 row affected (0.05 sec)
*/



/*
Question 19: b)Explain what you did and why.
*/


/*
We have used "INNER JOIN" because INNER JOINS treats the filter condition on equal basis regardless of the position of table while 
if we would have used LEFT or RIGHT OUTER joins, we had to take care of the position of tables given in join condition. 

Though with respect to performance there is not much difference between join and where condition except for the fact that for complex 
queries joins are better to use moreover joins are also better to use in case there are NULL values in the filtered columns.
*/


/*
Question 20: An employee has tried to find out which suppliers that have delivered items that have been sold. He has created a 
view and a query that shows the number of items sold from a supplier.The employee would also like include the suppliers which has 
delivered some items, although for whom no items have been sold so far. In other words he wants to list all suppliers, which has 
supplied any item, as well as the number of these items that have been sold. Help him! Drop and redefine jbsale_supply to consider 
suppliers that have delivered items that have never been sold as well.
*/

CREATE view jbsale_supply(supplier,item,quantity) AS (SELECT r.supplier,r.item_name as item,jbsale.quantity  FROM (SELECT jbsupplier.name as supplier,jbsupplier.name,jbitem.id,jbitem.name as item_name FROM jbsupplier right outer join jbitem on jbsupplier.id = jbitem.supplier) as r left join jbsale on jbsale.item = r.id) ORDER BY supplier;

/*

Query OK, 0 rows affected (0.06 sec)

 */



SELECT supplier, sum(quantity) AS sum FROM jbsale_supply GROUP BY supplier;

/*

+--------------+------+
| supplier     | sum  |
+--------------+------+
| White Stag   |    4 |
| Levi-Strauss |    1 |
| Whitman's    |    2 |
| Fisher-Price | NULL |
| Playskool    |    2 |
| Cannon       |    6 |
+--------------+------+
6 rows in set (0.00 sec)

 */
