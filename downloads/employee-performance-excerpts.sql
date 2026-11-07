-- Employee Performance Mapping | SQL excerpts
-- Simulated employee records; MySQL syntax.
-- Department performance comparison
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,
       MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS dept_max_rating
FROM emp_record_table;

-- Reporting lines and number of direct reports
SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, r.Reporters
FROM emp_record_table AS e
INNER JOIN (
  SELECT MANAGER_ID, COUNT(*) AS Reporters
  FROM emp_record_table
  WHERE MANAGER_ID IS NOT NULL
  GROUP BY MANAGER_ID
) AS r ON e.EMP_ID = r.MANAGER_ID;

-- Salary ranges by role
SELECT FIRST_NAME, LAST_NAME, ROLE,
       MAX(SALARY) OVER (PARTITION BY ROLE) AS role_max_salary,
       MIN(SALARY) OVER (PARTITION BY ROLE) AS role_min_salary
FROM emp_record_table;

-- Experience ranking
SELECT FIRST_NAME, LAST_NAME, EXP,
       RANK() OVER (ORDER BY EXP DESC) AS seniority_rank
FROM emp_record_table;
