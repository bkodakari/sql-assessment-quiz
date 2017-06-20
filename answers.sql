1

-----

Select all fields for all brands in the brands table.

The result set for this query should be every record in the brands table.

-----


SELECT * FROM brands;


==========
2

-----

Select all fields for all car models made by Pontiac in the
models table.

The result set should be:
 model_id | year | brand_id |    name
----------+------+----------+------------
       24 | 1961 | pon      | Tempest
       26 | 1962 | pon      | Grand Prix
       35 | 1963 | pon      | Grand Prix
       41 | 1964 | pon      | LeMans
       42 | 1964 | pon      | Bonneville
       43 | 1964 | pon      | Grand Prix
(6 rows)


-----


SELECT *
FROM models
WHERE brand_id='pon';


==========
3

-----

Select the brand id and model name for all models made in
1964 from the models table.

The result set should be:
 brand_id |    name
----------+-------------
 che      | Corvette
 for      | Mustang
 for      | Galaxie
 pon      | LeMans
 pon      | Bonneville
 pon      | Grand Prix
 ply      | Fury
 stu      | Avanti
 aus      | Mini Cooper
(9 rows)
 

-----


SELECT brand_id, name
FROM models
WHERE year = 1964;


==========
4

-----

Select the model name, brand name, and headquarters for
the Ford Mustang from the models and brands tables. Though it's unlikely,
remember to account for the possibility that there could be another brand
which also offers a Mustang; that is, specifically select the *Ford* Mustang.

The result set should be:
 model_name | brand_name | headquarters
------------+------------+--------------
 Mustang    | Ford       | Dearborn, MI
 (1 rows)


-----


SELECT m.name, b.name, headquarters
FROM models
AS m
JOIN brands AS b
ON m.brand_id=b.brand_id
WHERE m.name = 'Mustang' AND b.name = 'Ford';


==========
5

-----

Select all rows for the three oldest brands from the brands
table.

The result set should be:
 brand_id |    name    | founded |    headquarters     | discontinued
----------+------------+---------+---------------------+--------------
 stu      | Studebaker |    1852 | South Bend, Indiana |         1967
 ram      | Rambler    |    1901 | Kenosha, Washington |         1969
 cad      | Cadillac   |    1902 | New York City, NY   |
(3 rows)


-----


SELECT *
FROM brands
ORDER BY founded
LIMIT 3;


==========
6

-----

Count the Ford models in the database. The output should be a
number.

The result set should be:
 count
-------
     6
(1 row)


-----


SELECT count(name)
FROM models
WHERE brand_id = 'for';


==========
7

-----

Select the brand name of any and all car brands that are not
discontinued.

The result set should be:
   name
-----------
 Ford
 Chrysler
 Citroen
 Chevrolet
 Cadillac
 BMW
 Buick
 Tesla
 Subaru
(9 rows)


-----


SELECT name
FROM brands
WHERE discontinued IS null;


==========
8

-----

Select everything from rows 15-24 of the models table in order by
year. The result set should have 10 records.

The result set should be:
 model_id | year | brand_id |    name
----------+------+----------+-------------
       15 | 1958 | for      | Thunderbird
       16 | 1959 | aus      | Mini
       17 | 1959 | che      | Corvette
       18 | 1959 | bmw      | 600
       19 | 1960 | che      | Corvair
       20 | 1960 | che      | Corvette
       21 | 1960 | fai      | Rockette
       22 | 1961 | aus      | Mini Cooper
       23 | 1961 | stu      | Avanti
       24 | 1961 | pon      | Tempest
(10 rows)


-----


SELECT *
FROM models
ORDER BY year
OFFSET 14
LIMIT 10;


==========
9

-----

Select the model year, name, and id, and the award name for all of the models from 1964 and beyond. Include row(s)
for model(s) even if they have not won awards.

Note that in the result set, the award name should be NULL if
the model is not in the awards table.

So, the result set should be:
 year |    name     | model_id |       name
------+-------------+----------+-------------------
 2015 | Malibu      |       47 | IIHS Safety Award
 2015 | Outback     |       48 | IIHS Safety Award
 1964 | Mustang     |       39 |
 1964 | Mini Cooper |       46 |
 1964 | Galaxie     |       40 |
 1964 | Corvette    |       38 |
 1964 | Bonneville  |       42 |
 1964 | LeMans      |       41 |
 1964 | Fury        |       44 |
 1964 | Avanti      |       45 |
 1964 | Grand Prix  |       43 |
(11 rows)


-----


SELECT m.year, m.name, m.model_id, a.name
FROM models AS m
LEFT JOIN awards AS a
ON m.model_id = a.winner_id
WHERE m.year >= 1964;


==========
10

-----

Modify the query so it only selects brands who have models.

-----


SELECT b.name, m.year, m.name
FROM brands AS b
LEFT JOIN models AS m
ON b.brand_id = m.brand_id
WHERE m.name IS NOT NULL
ORDER BY b.name;


==========
12

-----

Write a query that selects the name and year founded for brands that do NOT have any
models in the models table.

The correct result set is:

 name  | founded
-------+---------
 Tesla |    2003
(1 rows)

-----


SELECT b.name, b.founded
FROM brands AS b
LEFT JOIN models AS m
ON b.brand_id = m.brand_id
WHERE m.model_id IS NULL;


==========
13

-----

Select the brand id of any brand with more than 5 models in the
database using a HAVING clause.

The correct result set is:

 brand_id
----------
 che
 pon
 for
(3 rows)


-----


SELECT brand_id
FROM models
GROUP BY brand_id
HAVING COUNT(model_id) > 5;


==========
14

-----

Using a subquery, select the name and year of any model whose
year is the same year that ANY brand was founded.

The result set should be:

   name    | year
-----------+------
 Imperial  | 1926
 Corvette  | 1953
 Corvette  | 1954
 Fleetwood | 1954
(4 rows)

-----


SELECT m.name, m.year
FROM models AS m
WHERE m.year IN (SELECT b.founded FROM brands AS b);