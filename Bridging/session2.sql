DROP TABLE DEPARTMENT PURGE; 
DROP TABLE EMPLOYEE PURGE;
                                     /* NUMBER  (7,2)   xxxxx.yy */
                                     -- PL/SQL
CREATE TABLE DEPARTMENT(
 dname      VARCHAR(20)     NOT NULL,
 budget     NUMBER(7,2)     NOT NULL,
 advisor    VARCHAR(30)         NULL,
  CONSTRAINT DEPARTMENT_PK PRIMARY KEY (dname),
  CONSTRAINT DEPARTMENT_CK UNIQUE(advisor) );
  
CREATE TABLE EMPLOYEE(
 enum       NUMBER(6)      NOT NULL,
 fname      VARCHAR(20)     NOT NULL,
 lname      VARCHAR(20)     NOT NULL,
 dob        DATE               NULL,
 dname      VARCHAR(20)        NULL,
  CONSTRAINT EMPLOYEE_PK PRIMARY KEY (enum),
  CONSTRAINT EMPLOYEE_FK FOREIGN KEY (dname) REFERENCES DEPARTMENT(dname) );


SELECT dname, budget
FROM DEPARTMENT;

SELECT DEPARTMENT.* 
FROM DEPARTMENT;


SELECT *
FROM EMPLOYEE;

INSERT INTO EMPLOYEE VALUES(4, 'Harry','Potter','12-AUG-2000', 'Sales');
INSERT INTO EMPLOYEE VALUES(5, 'Harry','Smith','12-AUG-1990', 'Sales');


SELECT DISTINCT dname
FROM EMPLOYEE;

UPDATE DEPARTMENT
SET ADVISOR = 'Janusz'
WHERE DnAME = 'Sales';

SELECT *
FROM DEPARTMENT
WHERE BUDGET > 1000;

SELECT *
FROM DEPARTMENT
WHERE ADVISOR IS NULL;

SELECT *
FROM DEPARTMENT
WHERE NOT(ADVISOR IS NULL);

SELECT *
FROM DEPARTMENT
WHERE ADVISOR IS NOT NULL;

select sysdate from dual;

select to_char(sysdate, 'DD-Month-YYYY HH:MI:SS') from dual;

select to_char(sysdate, 'DD-Month-YYYY HH:MI:SS') from department;

select upper(fname || ' ' || lname) from employee;

select *
from department
where upper(dname) = 'SALES';

select upper(dname)
from department;

select avg(budget)
from department;

select count(*)
from employee;

select count(fname)
from employee;

select count(distinct fname)
from employee;

select dname, count(*)
from employee
group by dname;

select dname, fname, count(*)
from employee
group by dname, fname;

select *
from employee;

select dname, count(*)
from employee
group by dname
having count(*) > 1;

select *
from employee
order by fname;

select *
from employee
order by fname desc;

select *
from employee
order by fname desc, lname asc;

select dname, count(*)
from employee
group by dname
order by dname asc;

select dname Department, count(*) total
from employee
group by dname
order by total desc;


CREATE TABLE DEPARTMENT(
 dname      VARCHAR(20)     NOT NULL,
 budget     NUMBER(7,2)     NOT NULL,
 advisor    VARCHAR(30)         NULL,
  CONSTRAINT DEPARTMENT_PK PRIMARY KEY (dname),
  CONSTRAINT DEPARTMENT_CK UNIQUE(advisor) );
  
CREATE TABLE EMPLOYEE(
 enum       NUMBER(6)      NOT NULL,
 fname      VARCHAR(20)     NOT NULL,
 lname      VARCHAR(20)     NOT NULL,
 dob        DATE               NULL,
 dname      VARCHAR(20)        NULL,
  CONSTRAINT EMPLOYEE_PK PRIMARY KEY (enum),
  CONSTRAINT EMPLOYEE_FK FOREIGN KEY (dname) REFERENCES DEPARTMENT(dname) );
  
select employee.fname, employee.lname, department.budget
from employee join department
              on employee.dname = department.dname;
              
select employee.fname, employee.lname, department.budget
from employee, department
where employee.dname = department.dname;

select fname, lname, budget
from employee join department
              on department.dname = employee.dname
where fname like 'H%';

select employee.*, budget, advisor
from employee join department
              on employee.dname = department.dname;
              
select dname, count(advisor)
from department
group by dname;

select fname, count(*)
from employee join department
              on employee.dname = department.dname
group by fname; 

select * from employee;

select dname, count(*)
from employee
group by dname;

insert into department values('IT', 12345.66, NULL);

select department.dname, count(enum)
from department left outer join employee
              on employee.dname = department.dname
group by department.dname;

select *
from department left outer join employee
              on employee.dname = department.dname;


INSERT INTO EMPLOYEE VALUES(6, 'Jane','Smith','12-AUG-1999', NULL);

select *
from employee;

select *
from department full outer join employee
              on employee.dname = department.dname;
              
select *
from department left outer join employee
              on employee.dname = department.dname
where enum is null;

select department.dname, fname
from department left outer join employee
              on employee.dname = department.dname;
              


select dname
from department
intersect
select distinct fname
from employee;

update employee
set fname = 'IT'
where enum = 5;

select dname
from department
minus
select distinct fname
from employee;

select dname, NULL a
from department
union
select fname, lname
from employee
order by a asc ;

select * from employee;
select * from department;

select fname
from employee
minus
select dname
from department;

select fname
from employee
intersect
select dname
from department;

select dname
from department
union all
select distinct fname
from employee;
              






              
              








