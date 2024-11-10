-- create epms schema
CREATE SCHEMA epms;

-- use chema
use epms;

-- 1. Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL
);

-- 2. Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 3. Projects Table
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- 4. Employee Projects Table (Associates employees with projects)
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    assigned_date DATE NOT NULL,
    role VARCHAR(50),
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- Insert sample data into departments table
INSERT INTO departments (department_name) VALUES 
('Engineering'),
('Sales'),
('Marketing'),
('Human Resources');

-- Insert sample data into employees table
INSERT INTO employees (first_name, last_name, department_id, hire_date, salary) VALUES 
('Alice', 'Smith', 1, '2022-03-15', 75000),
('Bob', 'Johnson', 1, '2021-06-10', 85000),
('Carol', 'Williams', 2, '2023-01-20', 60000),
('David', 'Brown', 3, '2020-09-05', 70000),
('Eva', 'Jones', 4, '2022-11-25', 50000);

-- Insert sample data into projects table
INSERT INTO projects (project_name, department_id) VALUES 
('Project Alpha', 1),
('Project Beta', 1),
('Project Gamma', 2),
('Project Delta', 3);

-- Insert sample data into employee_projects table
INSERT INTO employee_projects (employee_id, project_id, assigned_date, role) VALUES 
(1, 1, '2023-02-10', 'Developer'),
(1, 2, '2023-05-01', 'Lead Developer'),
(2, 1, '2023-01-15', 'Tester'),
(3, 3, '2023-03-20', 'Sales Representative'),
(4, 4, '2023-04-12', 'Marketing Specialist'),
(2, 2, '2023-06-10', 'Developer');


-- check tables
select * from departments d ;
select * from employees e ;
select * from projects p ;
select * from employee_projects ep ;
