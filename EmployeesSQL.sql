-- Tables cleaning
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;


-- Tables creation

-- Titles table
CREATE TABLE titles 
(
    title_id VARCHAR(20) NOT NULL,
    title VARCHAR(20) NOT NULL,
    PRIMARY KEY (title_id)
);

-- Employees table
CREATE TABLE employees
(
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(10) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    sex CHAR NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY (emp_no),
    CONSTRAINT fk_titles
      FOREIGN KEY(emp_title_id) 
	  REFERENCES titles(title_id)

);

-- Salaries table
CREATE TABLE salaries
(
    emp_no INT NOT NULL,
    salary MONEY,
    CONSTRAINT fk_employees
      FOREIGN KEY(emp_no) 
	  REFERENCES employees(emp_no)
);

-- Departments table
CREATE TABLE departments 
(
    dept_no VARCHAR(20) NOT NULL,
    dept_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (dept_no)
);

-- Dept_manager table
CREATE TABLE dept_manager 
(
    dept_no VARCHAR(20) NOT NULL,
    emp_no INT NOT NULL,
    CONSTRAINT fk_emp_manager
      FOREIGN KEY(emp_no) 
	  REFERENCES employees(emp_no),
    CONSTRAINT fk_dept_no
      FOREIGN KEY(dept_no)
      REFERENCES departments(dept_no)
);

-- Dept_emp table
CREATE TABLE dept_emp 
(
    emp_no INT NOT NULL,
    dept_no VARCHAR(20) NOT NULL,
    CONSTRAINT fk_emp_dept
      FOREIGN KEY(emp_no) 
	  REFERENCES employees(emp_no),
    CONSTRAINT fk_emp_dept_no
      FOREIGN KEY(dept_no)
      REFERENCES departments(dept_no)
);

-- Copy files to the database (file_path represent an internal location where the file is saved with reading permisions)
-- Titles tables
COPY titles 
FROM 'file_path\titles.csv' 
WITH
(
	FORMAT 'csv',
	DELIMITER ',',
	HEADER
);

-- Employees table
COPY employees 
FROM 'file_path\employees.csv' 
WITH
(
	FORMAT 'csv',
	DELIMITER ',',
	HEADER
);

-- Salaries table 
COPY salaries 
FROM 'file_path\salaries.csv' 
WITH
(
	FORMAT 'csv',
	DELIMITER ',',
	HEADER
);

-- Departments table
COPY departments 
FROM 'file_path\departments.csv' 
WITH
(
	FORMAT 'csv',
	DELIMITER ',',
	HEADER
);

-- Dept_manager table
COPY dept_manager 
FROM 'file_path\dept_emp.csv' 
WITH
(
	FORMAT 'csv',
	DELIMITER ',',
	HEADER
);

-- Dept_emp table
COPY dept_emp 
FROM 'file_path\dept_emp.csv' 
WITH
(
	FORMAT 'csv',
	DELIMITER ',',
	HEADER
);


-- Ckecking the information from each table 
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;

-- DATA ANALYSIS DEVELOPMENT (QUERIES)

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
FROM  employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '01/01/1986' AND '01/31/1986';

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- List the department of each employee with the following information: employee number, last name, first name, and department name
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name LIKE 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name,
-- and department name.
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name LIKE 'Sales' OR departments.dept_name LIKE 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Repetition number"
FROM employees
GROUP BY last_name
ORDER BY "Repetition number" DESC;