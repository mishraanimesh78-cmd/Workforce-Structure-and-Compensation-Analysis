create database companyDB;
use companydb;

select * from department;
select * from dept_emp;
select * from dept_manager;
select *from employee_title;
select * from employees;
select * from salaries;

-- 1.accessing name
select first_name,last_name from employees;

-- 2.dept. numbers and names
select * from department;

-- 3.total no. of employees
select count(emp_no) from employees;

-- 4.Average salaries of all employees
select avg(salary) from salaries;

-- 5.birth date and hre date of emp no.10003
select emp_no,birth_date,hire_date from employees where emp_no=10003;

-- 6.title of employees
select title from employee_title;

-- 7.total no. of department
select count(dep_no) from department;

-- 8.dept no. & name wuth emp no.10004
select d.dep_no,d.dep_name from department d inner join 
dept_emp de on d.dep_no=de.dep_no where emp_no=10004;

-- 9.gender of employee with emp_no.10007
select emp_no,gender from employees where emp_no=10007;

-- 10.all manager with dept name
select e.first_name,d.dep_name,et.title from employees e inner join employee_title et
on e.emp_no=et.emp_no
inner join dept_emp de on e.emp_no=de.emp_no
inner join department d  on de.dep_no=d.dep_no
where et.title='manager';

-- 11.departments with highest no. of employees
select d.dep_name,count(de.emp_no) as employees_count from department d inner join
dept_emp de on d.dep_no=de.dep_no group by d.dep_name
order by employees_count desc limit 1;

-- 12.employee name with salary
select e.emp_no,e.first_name,e.last_name,s.salary from employees e join salaries s on e.emp_no=s.emp_no
where salary>60000;

-- 13.avg salary of each dept.
select d.dep_name,avg(s.salary) as average_salary from department d join dept_emp de on d.dep_no=de.dep_no
join salaries s on de.emp_no=s.emp_no group by d.dep_name;

-- 15.total no. of employees in all depart.
select d.dep_name,count(e.emp_no) employees_count from department d inner join employees e group by d.dep_name;



-- 19.depart. with female manager
select d.dep_no,d.dep_name,e.gender,count(de.emp_no) as total_employees from department d inner join 
dept_manager dm on d.dep_no=dm.dept_no 
inner join employees e on dm.emp_no=e.emp_no
inner join dept_emp de on d.dep_no=de.dep_no
where e.gender='f' group by d.dep_no,d.dep_name;

-- 20.count senior manager
select emp_no,count(emp_no) as total_senior_managers from employee_title 
where title ='senior manager' group by emp_no;

-- 17. EMPLOYEES HIRED IN 2005
select e.emp_no,e.first_name,e.last_name,t.title from employee_title t join employees e  on e.emp_no=t.emp_no
where year(str_to_date(e.hire_date, '%d-%m-%Y')) =2005 ;

-- 18.Employees before 2005
select e.emp_no,e.first_name,e.last_name,e.hire_date,s.salary from employees e join salaries s on e.emp_no=s.emp_no

where e.hire_date< '2005-01-01';

-- 16.departments having more than 3 employees
select d.dep_no,d.dep_name,avg(s.salary) as average_salary 
from dept_manager de
join department d on de.dept_no=d.dep_no
join salaries s on de.emp_no=s.emp_no
group by d.dep_no,d.dep_name
having count(de.emp_no)>3;