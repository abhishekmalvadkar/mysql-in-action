-- Retrieve the names and salaries of all employees in the “Engineering” department.
select 
	concat(e.first_name, ' ', upper(e.last_name)) as empFullname,
	e.salary
from employees e 
join departments d on d.department_id = e.department_id 
where d.department_name = 'Engineering';

-- List all employees who were hired in the last year.
select * from employees e 
where year(hire_date) = year(curdate()) - 1;

-- Find the top 3 departments with the highest average salary.
select 
	d.department_name ,
	avg(e.salary) 
from employees e 
join departments d on d.department_id = e.department_id 
group by d.department_name 
order by 2 desc limit 3
;

-- Retrieve employees who are assigned to more than one project.
select 
	e.employee_id , e.first_name ,
	count(1) as totalProject
from employee_projects ep 
join employees e on e.employee_id = ep.employee_id 
join projects p on p.project_id = ep.project_id 
group by e.employee_id, e.first_name
having totalProject > 1
;

-- Write a query to find employees who earn more than the average salary of their respective departments.
with DEPT_EMP_AVG_SALARY as
(
	select
		d.department_id,
		e.first_name ,
		e.salary as empSalary,
	avg(e.salary) over(partition by d.department_id) as avgSalyDept 
	from
	employees e 
	join departments d on d.department_id = e.department_id
)
select * 
from DEPT_EMP_AVG_SALARY
where empSalary > avgSalyDept
;
