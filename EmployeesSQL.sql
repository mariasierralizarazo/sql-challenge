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

-- Dept_emp
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

