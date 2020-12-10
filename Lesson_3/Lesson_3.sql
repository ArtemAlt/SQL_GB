-- База данных «Страны и города мира»:
-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.

SELECT 
    cs.title, rg.title, cou.title
FROM
    _cities cs
        JOIN
    _regions rg ON cs.region_id = rg.id
        JOIN
    _countries cou ON rg.country_id = cou.id
WHERE
    cs.title = 'Чоп'
-- 2. Выбрать все города из Московской области.
SELECT 
 cs.title, rg.title, cou.title
FROM
    _cities cs
    join _regions rg on cs.region_id=rg.id
    join _countries cou on rg.country_id=cou.id
    
    where rg.title = 'Московская область'
    
-- База данных «Сотрудники»:
-- 1. Выбрать среднюю зарплату по отделам.
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
-- 2. Выбрать максимальную зарплату у сотрудника.
SELECT 
    e.first_name, MAX(salary)
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
GROUP BY e.first_name
-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
DELETE FROM salaries ORDER BY salary DESC LIMIT 1

-- 4. Посчитать количество сотрудников во всех отделах.
SELECT 
    dept_no, COUNT(emp_no) AS total_employees
FROM
    dept_emp
GROUP BY dept_no;

-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.    
SELECT 
    de.dept_no,
    COUNT(de.emp_no) AS total_employees,
    SUM(s.salary) AS total_expenses
FROM
    dept_emp de
        JOIN
    salaries s ON s.emp_no = de.emp_no
WHERE
    de.to_date = '99990101'
GROUP BY de.dept_no;



