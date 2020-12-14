CREATE VIEW `round_salary` AS
SELECT 
    dpr.dept_name, ROUND((s.salary), 2) AS departament_expenses
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments dpr ON de.dept_no = dpr.dept_no
GROUP BY de.dept_no