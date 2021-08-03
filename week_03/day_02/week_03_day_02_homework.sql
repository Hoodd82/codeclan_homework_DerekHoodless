-- MVP

-- Qu. 1a

SELECT
	e.first_name,
	e.last_name,
	t.name AS team_name
FROM 
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id;

-- Qu. 1b

SELECT
	e.first_name,
	e.last_name,
	t.name AS team_name
FROM 
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
WHERE pension_enrol IS TRUE;

-- Qu. 1c

SELECT
	e.first_name,
	e.last_name,
	t.name AS team_name
FROM 
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
WHERE CAST(charge_cost AS NUMERIC) > 80;

-- Qu. 2a

SELECT
	e.*,
	pd.local_account_no,
	pd.local_sort_code
FROM 
	employees AS e LEFT JOIN pay_details AS pd
	ON e.id = pd.id;

-- Qu. 2b

SELECT
	e.*,
	pd.local_account_no,
	pd.local_sort_code,
	t.name AS team_name
FROM 
	(employees AS e LEFT JOIN pay_details AS pd
	ON e.id = pd.id)
INNER JOIN teams AS t
ON t.id = e.team_id;

-- Qu. 3a

SELECT
	e.id AS employee_id,
	t.name AS team_name
FROM 
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id;

-- Qu. 3b

SELECT
	t.name,
	COUNT(e.id)
FROM 
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
GROUP BY t.name;

-- Qu. 3c

SELECT
	t.name,
	COUNT(e.id) AS no_of_employees
FROM 
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
GROUP BY t.name
ORDER BY no_of_employees;

-- Qu. 4a

SELECT
	t.id,
	t.name,
	COUNT(e.id) AS no_of_employees
FROM
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
GROUP BY t.id
ORDER BY id;

-- Qu. 4b

SELECT
	t.id,
	t.name,
	CAST(t.charge_cost AS NUMERIC) * COUNT(e.id) AS total_day_charge
FROM
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
GROUP BY t.id
ORDER BY t.id;

-- Qu. 4c

SELECT
	t.id,
	t.name,
	CAST(t.charge_cost AS NUMERIC) * COUNT(e.id) > 5000 AS total_day_charge
FROM
	employees AS e INNER JOIN teams AS t
	ON e.team_id = t.id
GROUP BY t.id
ORDER BY t.id;

-- EXT

-- Qu. 5

SELECT 
	employee_id, 
	COUNT(*) AS how_many_committees
FROM employees_committees
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- Qu. 6

SELECT 
	*
FROM 
	employees AS e LEFT JOIN employees_committees AS ec
	ON e.id = ec.employee_id
WHERE ec.employee_id IS NULL;








