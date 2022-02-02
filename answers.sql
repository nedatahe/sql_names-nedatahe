
SELECT *
FROM names
--1  How many rows are in the names table?
SELECT COUNT(*)
FROM names
--2 How many total registered people appear in the dataset?
SELECT SUM(num_registered)
from names
--3 Which name had the most appearances in a single year in the dataset?
SELECT name, num_registered, year
from names
ORDER BY num_registered DESC

--another approach
SELECT name
FROM names
WHERE num_registered = (SELECT MAX(num_registered) FROM names)

LIMIT 1
--4 What range of years are included?
SELECT MAX(year) , MIN(year)
from names
-- or minus gives you one number
--5 What year has the largest number of registrations?
SELECT year, SUM(num_registered) as registeration_sum
FROM names
GROUP BY year
ORDER BY registeration_sum DESC

--6 How many different (distinct) names are contained in the dataset?
SELECT COUNT(DISTINCT name)
FROM names
--7 Are there more males or more females registered?
SELECT gender, SUM(num_registered) as sum
from names
GROUP BY gender
ORDER BY sum DESC

--anotr approach:
SELECT gender, SUM(num_registered) AS registered
FROM names
GROUP BY 1
ORDER BY 2 DESC
--8 What are the most popular male and female names overall (i.e., the most total registrations)?
SELECT name, gender, SUM(num_registered) as registeration
from names
GROUP BY name, gender
ORDER BY registeration DESC
--HAVING SUM(num_registered) IS MAX(SUM (num_registered))
ORDER by registeration DESC
 

--9 What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
SELECT name, gender, SUM(num_registered) as registeration
from names
WHERE year BETWEEN 2000 AND 2009
GROUP BY name, gender
ORDER by registeration DESC

--10 Which year had the most variety in names (i.e. had the most distinct names)?
SELECT COUNT(DISTINCT name) as most_variety, year
FROM names
GROUP BY year
ORDER BY most_variety DESC

--11 What is the most popular name for a girl that starts with the letter X?
SELECT name, SUM(num_registered)
from names
where name LIKE 'X%' AND gender = 'F'
GROUP BY name
ORDER BY SUM(num_registered) DESC

-- ILIKE is case insentitive 

--12 How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?
SELECT COUNT( DISTINCT name), name
from names
where name LIKE 'Q%' AND name NOT LIKE  '_u%'
GROUP BY name
ORDER BY COUNT(DISTINCT name) DESC


--another approach:
SELECT CoUNT(DISTINCT(name))
FROM names
WHERE name LIKE 'Q%'
AND name NOT LIKE 'Qu%'
--does not need name and group by if you only want the count

--13 Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
SELECT name, SUM(num_registered)
FROM names
WHERE name IN ('Stephen', 'Steven')
GROUP BY name
ORDER BY name DESC
 --14  What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?
SELECT COUNT(unisex_counts)*100.00/COUNT(*)
FROM (SELECT CASE WHEN (COUNT( DISTINCT gender)>1) THEN 1
	  END AS unisex_counts
	FROM names
	GROUP BY name) AS unisex

	
--count does not give row count, it gives the count of non null values

--15 How many names have made an appearance in every single year since 1880?
SELECT name, count(DISTINCT year)
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 139


--16 How many names have only appeared in one year?
SELECT name, COUNT(DISTINCT year)
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 1
-- Count * counts all rows but count (col name ) counts non null values


--17 How many names only appeared in the 1950s?

SELECT COUNT(*) --very usueful method in counting the numbe of items in a table
FROM(SELECT name
ROM names
GROUP BY name
HAVING MIN(year) >= 1950 AND MAX(year) <= 1959 AS fiftes_name)

--18 How many names made their first appearance in the 2010s?
SELECT name, MIN(year)
FROM names
GROUP BY name
HAVING MIN(year) >= 2010;
--or:
SELECT COUNT(DISTINCT name) AS name_cnt
	FROM names
	WHERE name IN
	(
		SELECT name
		FROM names
		GROUP BY name
		HAVING min(year) > 2009
	);
--19 Find the names that have not be used in the longest.
SELECT name, 2018 - MAX(year) AS years_since_named
FROM names
GROUP BY name
ORDER BY years_since_named DESC;

--20 Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.




