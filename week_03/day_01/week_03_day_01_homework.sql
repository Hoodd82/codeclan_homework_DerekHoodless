/* Question 1 */

SELECT *
FROM employees
WHERE department = 'Human Resources';

/* Question 2 */

SELECT	first_name,
		Last_name,
		country
FROM employees
WHERE department = 'Legal';

/* Question 3 */

SELECT 
	COUNT(*) AS employees_portugal
FROM employees
WHERE country = 'Portugal';

/* Question 4 */

SELECT 
	COUNT(*) AS portugal_spain_employees
FROM employees
WHERE country = 'Portugal' OR country = 'Spain';

/* Question 5 */

SELECT 
	COUNT(*) AS acc_no_null_count
FROM pay_details
WHERE local_account_no IS NULL;

/* Question 6 */

SELECT 
	COUNT(*) AS acc_no_and_iban_null_count
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL;

/* Question 7 */

SELECT 	first_name,
		last_name
FROM employees
ORDER BY last_name NULLS LAST;

/* Question 8 */

SELECT	first_name,
		last_name,
		country
FROM employees
ORDER BY country, last_name NULLS LAST;

/* Question 9 */

SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;

/* Question 10 */

SELECT	first_name,
		last_name,
		salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary
LIMIT 1;

/* Question 11 */

SELECT
	COUNT(*) AS first_names_beginning_with_f
FROM employees
WHERE first_name LIKE 'F%';

/* Question 12 */

SELECT *
FROM employees
WHERE email LIKE '%@yahoo.%';

/* Question 13 */

SELECT
	COUNT(*) AS no_pension_enrolled
FROM employees
WHERE (country NOT IN ('France', 'Germany')) AND pension_enrol = TRUE;

/* Question 14 */

SELECT
	MAX(salary)
FROM employees
WHERE department = 'Engineering' AND fte_hours = 1;

/* Question 15 */

SELECT	first_name,
		last_name,
		fte_hours,
		salary,
		fte_hours * salary AS effective_yearly_salary
FROM employees
WHERE salary IS NOT NULL
ORDER BY effective_yearly_salary DESC;

/* Question 16 */

SELECT	first_name,
		last_name,
		department,
		CONCAT(first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees
WHERE department IS NOT NULL;

/* Question 17 */

SELECT	first_name,
		last_name,
		department,
		start_date,
		CONCAT(first_name, ' ', last_name, ' - ', department, ' (joined ', start_date, ')') AS badge_label
FROM employees
WHERE department IS NOT NULL AND start_date IS NOT NULL AND first_name IS NOT NULL AND last_name IS NOT NULL;

SELECT	first_name,
		last_name,
		department,
		CONCAT(first_name, ' ', last_name, ' - ', department,
		' (Joined ', TO_CHAR(start_date, 'Mon'), ' ', DATE_PART('year', start_date), ')') AS badge_label
FROM employees
WHERE department IS NOT NULL
	AND start_date IS NOT NULL 
	AND first_name IS NOT NULL 
	AND last_name IS NOT NULL;

SELECT
  first_name,
  last_name,
  department,
  start_date,
  CONCAT(
    first_name, ' ', last_name, ' - ', department, ' (joined ', 
    TO_CHAR(start_date, 'FMMonth'), ' ', TO_CHAR(start_date, 'YYYY'), ')'
  ) AS badge_label
FROM employees
WHERE 
  first_name IS NOT NULL AND 
  last_name IS NOT NULL AND 
  department IS NOT NULL AND
  start_date IS NOT NULL;

/* Question 18 */

SELECT	
	first_name,
	last_name,
	salary,
	CASE
		WHEN salary < 	40000 THEN 'low'
		WHEN salary >= 	40000 THEN 'high'
	END salary_review
FROM employees
WHERE 	salary IS NOT NULL
		AND first_name IS NOT NULL 
  		AND last_name IS NOT NULL;
  		
  	