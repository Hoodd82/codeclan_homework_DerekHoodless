-- MVP

-- Qu. 1

SELECT
	count(*) AS missing_grade_and_salary
FROM
	employees
WHERE
	grade IS NULL AND salary IS NULL;
	
-- Qu. 2

SELECT
	department,
	CONCAT(first_name, ' ', last_name) AS full_name
FROM
	employees
ORDER BY department, last_name;

-- Qu. 3

SELECT
	first_name,
	last_name,
	salary
FROM
	employees
WHERE 
	last_name LIKE 'A%' 
	AND salary IS NOT NULL
ORDER BY 
	salary DESC
LIMIT
	10;
	
-- Qu. 4

SELECT
	COUNT(id) AS num_employees_started_in_2003
FROM
	employees
WHERE
	start_date BETWEEN '2003-01-01' AND '2003-12-31';
	
-- Qu. 5

SELECT
	department,
	fte_hours,
	COUNT(id) AS most_common_fte_hours
FROM 
	employees
GROUP BY 
	department, fte_hours
ORDER BY department, fte_hours;

-- Qu. 6

SELECT
	first_name,
	last_name,
	CASE
		WHEN pension_enrol = TRUE THEN 'enrolled'
		WHEN pension_enrol = FALSE THEN 'not enrolled'
		ELSE 'unknown'
	END pension_scheme_status
FROM 
	employees;

-- Qu. 7

SELECT
	id,
	first_name,
	last_name,
	salary
FROM
	employees
WHERE
	department = 'Accounting'
	AND pension_enrol IS FALSE
	AND salary IS NOT NULL
ORDER BY 
	salary DESC
LIMIT
	1;

-- Qu. 8

SELECT
	country,
	COUNT(id) AS num_of_employees,
	AVG(salary) AS avg_salary
FROM
	employees
GROUP BY
	country
HAVING COUNT(id) > 30
ORDER BY avg_salary DESC;

-- Qu. 9

SELECT
	first_name,
	last_name,
	fte_hours,
	salary,
	(fte_hours * salary) AS effective_yearly_salary
FROM
	employees
WHERE
	fte_hours * salary > 30000
ORDER BY
	effective_yearly_salary DESC;
	
-- Qu. 10

SELECT
	e.first_name,
	e.last_name,
	t.name AS team_name
FROM 
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
WHERE 
	t.name = 'Data Team 1' 
	OR t.name = 'Data Team 2'
ORDER BY team_name;

-- Qu. 11

SELECT
	e.first_name,
	e.last_name,
	pd.local_tax_code
FROM 
	employees AS e LEFT JOIN pay_details AS pd
	ON e.id = pd.id
WHERE pd.local_tax_code IS NULL;

-- Qu. 12

SELECT
	e.first_name,
	e.last_name,
	(48 * 35 * CAST(t.charge_cost AS INT) - e.salary) * e.fte_hours AS expected_profit
FROM
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id;

-- Qu. 13

SELECT
	first_name,
	last_name,
	salary,
	fte_hours
FROM
	employees
WHERE
	country = 'Japan'
	AND fte_hours = (SELECT MODE() WITHIN GROUP (ORDER BY fte_hours) FROM employees)
	AND salary IS NOT NULL
ORDER BY salary
LIMIT 1;

-- Qu. 14

SELECT
	department,
	count(id) AS num_employees_missing_first_name
FROM
	employees
WHERE
	first_name IS NULL
GROUP BY 
	department
ORDER BY
	num_employees_missing_first_name DESC, department;

-- Qu. 15

SELECT
	first_name,
	COUNT(id) AS num_of_names
FROM 
	employees
WHERE
	first_name IS NOT NULL
GROUP BY
	first_name
ORDER BY 
	num_of_names DESC, first_name;

-- Qu. 16

SELECT
	department,
	grade,
	COUNT(id) AS num_employees
FROM
	employees
WHERE
	grade IS NOT NULL
GROUP BY 
	department, grade
ORDER BY
	department, grade;

-- Del's solution

SELECT
	department,
	SUM((grade =1)::INT)/COUNT(id)::REAL
FROM
	employees
GROUP BY department;

-- Aileen's solution

WITH depart_g1 AS (
SELECT 
	department,
	COUNT(id) AS employ_g1
FROM employees
WHERE grade = 1
GROUP BY department
)
SELECT 
	employees.department,
	COUNT(employees.id) AS employ_all,
	depart_g1.employ_g1,
	depart_g1.employ_g1::FLOAT/COUNT(employees.id) 
FROM employees
LEFT JOIN depart_g1 
ON employees.department = depart_g1.department
GROUP BY employees.department, depart_g1.employ_g1

-- EXT

-- Qu. 1

SELECT
	id,
	first_name,
	last_name,
	department,
	salary,
	fte_hours,
	salary / AVG(salary) OVER (PARTITION BY department) AS salary_ratio,
	fte_hours / AVG(fte_hours) OVER (PARTITION BY department) AS fte_ratio
FROM
	employees
WHERE
	department = (SELECT department FROM employees GROUP BY department ORDER BY COUNT(*) DESC LIMIT 1)
	AND salary IS NOT NULL;

-- Qu. 2

-- not sure whether this is the answer???

SELECT
	first_name,
	last_name,
	CASE
		WHEN pension_enrol = TRUE THEN 'enrolled'
		WHEN pension_enrol = FALSE THEN 'not enrolled'
		ELSE 'unknown'
	END pension_scheme_status
FROM 
	employees;
	
-- Qu. 3

SELECT
	e.first_name,
	e.last_name,
	ec.committee_id,
	c.name
FROM 
	employees AS e INNER JOIN employees_committees AS ec
	ON e.id = ec.employee_id
INNER JOIN committees AS c
ON c.id = ec.committee_id;



SELECT department FROM employees GROUP BY department ORDER BY COUNT(*) DESC LIMIT 1

