--1 
SELECT 
	column_name,
	is_nullable, 
	data_type
FROM 
	information_schema.COLUMNS
WHERE 
	table_name = 'naep'


--2 
SELECT 
	*
FROM 
	naep
limit 50


--3
SELECT 
	"state",
	COUNT("avg_math_4_score") AS "count_math_4_score",
	min("avg_math_4_score") AS "min_math_4_score",
	max("avg_math_4_score") AS "max_math_4_score",
	avg("avg_math_4_score") AS "avg_math_4_score"
FROM 
	naep
GROUP BY "state"
ORDER BY "state" ASC 


--4
SELECT 
	"state",
	COUNT("avg_math_4_score") AS "count_math_4_score",
	min("avg_math_4_score") AS "min_math_4_score",
	max("avg_math_4_score") AS "max_math_4_score",
	avg("avg_math_4_score") AS "avg_math_4_score",
	max("avg_math_4_score") - min("avg_math_4_score") AS "avg_math_4_score"
FROM 
	naep
GROUP BY "state"
HAVING   
	(max("avg_math_4_score") - min("avg_math_4_score")) >= 30
ORDER BY "state" ASC 

--5
SELECT 
	"state" as "bottom_10"
FROM 
	naep
WHERE 
	"year" = 2000
ORDER BY "avg_math_4_score" ASC 
LIMIT 10

--6
SELECT 
	ROUND(avg("avg_math_4_score"):: numeric, 2) as "avg_score"
FROM 
	naep
WHERE 
	"year" = 2000
	AND "avg_math_4_score" is NOT null
ORDER BY "avg_score" DESC  

--7
SELECT
	"state" AS "below_average_states_y2000"
FROM 
	naep
WHERE 
	"year" = 2000
	AND "avg_math_4_score" is NOT null
	AND "avg_math_4_score" < (SELECT AVG("avg_math_4_score") FROM naep)
-- 8
SELECT
	"state" as "scores_missing_y2000"
FROM 
	naep
WHERE 
	"year" = 2000
	AND "avg_math_4_score" is null

-- 9
SELECT 
	naep.state,
	ROUND(avg("avg_math_4_score")::numeric, 2) as "avg_score"
	,"total_expenditure"
FROM 
	naep
LEFT JOIN finance ON 
	naep.id = finance.id
WHERE 
	naep.year = 2000
	AND "avg_math_4_score" is NOT null
GROUP BY 
	naep.state
	,"total_expenditure"
ORDER BY "total_expenditure" DESC 
	

	