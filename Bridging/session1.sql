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
  
ALTER TABLE DEPARTMENT ADD (city VARCHAR(20) NULL);
ALTER TABLE DEPARTMENT DROP COLUMN city;

ALTER TABLE DEPARTMENT MODIFY city VARCHAR(30);

INSERT INTO EMPLOYEE VALUES(2, 'James' , 'Bond','12-AUG-1980', 'Finance');

INSERT INTO DEPARTMENT VALUES('Finance', 123.45, NULL, 'Dapto');

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE VALUES(3, 'Robin' , 'Hood','12-AUG-1234', 'Sales');

INSERT INTO DEPARTMENT VALUES('Sales', 1253.45, NULL, 'Sydney');

DELETE FROM DEPARTMENT
WHERE dname = 'Finance' ;

UPDATE EMPLOYEE
SET dname = 'Sales', fname= 'George'
WHERE enum = 2;

UPDATE EMPLOYEE
SET dname = 'HR'
WHERE enum = 2;

ROLLBACK;

COMMIT;
INSERT INTO EMPLOYEE VALUES(3, 'Robin' , 'Hood','12-AUG-1234', 'Sales');

ROLLBACK;

SELECT dname, budget
FROM DEPARTMENT;

SELECT DEPARTMENT.* 
FROM DEPARTMENT;

SELECT dname, budget
FROM DEPARTMENT
WHERE dname='Sales';




