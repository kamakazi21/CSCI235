set echo on
set feedback on
set linesize 300
set pagesize 500
spool dbcreate

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* The relational tables of TPC HR benchmark database				 */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

CREATE TABLE REGION(
R_REGIONKEY	NUMBER(12)	NOT NULL,
R_NAME		CHAR(25)	NOT NULL,
R_COMMENT	VARCHAR(152)	NOT NULL,
	CONSTRAINT REGION_PKEY PRIMARY KEY(R_REGIONKEY),
	CONSTRAINT REGION_CHECK1 CHECK(R_REGIONKEY >= 0) );

CREATE TABLE NATION(
N_NATIONKEY	NUMBER(12)	NOT NULL,
N_NAME		CHAR(25)	NOT NULL,
N_REGIONKEY	NUMBER(12)	NOT NULL,
N_COMMENT	VARCHAR(152)	NOT NULL,
	CONSTRAINT NATION_PKEY PRIMARY KEY (N_NATIONKEY),
	CONSTRAINT NATION_FKEY1 FOREIGN KEY (N_REGIONKEY)
		REFERENCES REGION(R_REGIONKEY),
	CONSTRAINT NATION_CHECK1 CHECK(N_NATIONKEY >= 0) );

CREATE TABLE PART(
P_PARTKEY 	NUMBER(12) 	NOT NULL,
P_NAME		VARCHAR(55)	NOT NULL,
P_MFGR		VARCHAR(25)	NOT NULL,
P_BRAND		CHAR(10)	NOT NULL,
P_TYPE		VARCHAR(25)	NOT NULL,
P_SIZE		NUMBER(12)	NOT NULL,
P_CONTAINER 	CHAR(10)	NOT NULL,
P_RETAILPRICE	NUMBER(12,2)	NOT NULL,
P_COMMENT	VARCHAR(23)	NOT NULL,
	CONSTRAINT PART_PEKEY PRIMARY KEY (P_PARTKEY),
	CONSTRAINT PART_CHECK1 CHECK(P_PARTKEY >= 0),
	CONSTRAINT PART_CHECK2 CHECK(P_SIZE >= 0),
	CONSTRAINT PART_CHECK3 CHECK(P_RETAILPRICE >= 0) );

CREATE TABLE SUPPLIER(
S_SUPPKEY 	NUMBER(12)	NOT NULL,
S_NAME		CHAR(25)	NOT NULL,
S_ADDRESS	VARCHAR(40)	NOT NULL,
S_NATIONKEY	NUMBER(12)	NOT NULL,
S_PHONE 	CHAR(15)	NOT NULL,
S_ACCTBAL	NUMBER(12,2)	NOT NULL,
S_COMMENT	VARCHAR(101)	NOT NULL,
	CONSTRAINT SUPPLIER_PKEY PRIMARY KEY (S_SUPPKEY),
	CONSTRAINT SUPPLIER_FKEY1 FOREIGN kEY (S_NATIONKEY)
		REFERENCES NATION(N_NATIONKEY),
	CONSTRAINT SUPPLIER_CHECK1 CHECK(S_SUPPKEY >= 0) );

CREATE TABLE PARTSUPP(
PS_PARTKEY 	NUMBER(12)	NOT NULL,
PS_SUPPKEY	NUMBER(12)	NOT NULL,
PS_AVAILQTY	NUMBER(12)	NOT NULL,
PS_SUPPLYCOST	NUMBER(12,2)	NOT NULL,
PS_COMMENT	VARCHAR(199)	NOT NULL,
	CONSTRAINT PARTSUPP_PKEY PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY),
	CONSTRAINT PARTSUPP_FKEY1 FOREIGN KEY (PS_PARTKEY)
		REFERENCES PART(P_PARTKEY),
	CONSTRAINT PARTSUPP_FKEY2 FOREIGN kEY (PS_SUPPKEY)
		REFERENCES SUPPLIER(S_SUPPKEY),
	CONSTRAINT PARTSUPP_CHECK1 CHECK(PS_PARTKEY >= 0),
	CONSTRAINT PARTSUPP_CHECK2 CHECK(PS_AVAILQTY >= 0),
	CONSTRAINT PARTSUPP_CHECK3 CHECK(PS_SUPPLYCOST >= 0) );

CREATE TABLE CUSTOMER(
C_CUSTKEY	NUMBER(12)	NOT NULL,
C_NAME 		VARCHAR(25)	NOT NULL,
C_ADDRESS	VARCHAR(40)	NOT NULL,
C_NATIONKEY	NUMBER(12)	NOT NULL,
C_PHONE		CHAR(15)	NOT NULL,
C_ACCTBAL	NUMBER(12,2)	NOT NULL,
C_MKTSEGMENT	CHAR(10)	NOT NULL,
C_COMMENT	VARCHAR(117)	NOT NULL,
	CONSTRAINT CUSTOMER_PKEY PRIMARY KEY(C_CUSTKEY),
	CONSTRAINT CUSTOMER_FKEY1 FOREIGN kEY (C_NATIONKEY)
		REFERENCES NATION(N_NATIONKEY),
	CONSTRAINT CUSTOMER_CHECK1 CHECK(C_CUSTKEY >= 0) );

CREATE TABLE ORDERS(
O_ORDERKEY	NUMBER(12)	NOT NULL,
O_CUSTKEY	NUMBER(12)	NOT NULL,
O_ORDERSTATUS	CHAR(1)		NOT NULL,
O_TOTALPRICE	NUMBER(12,2)	NOT NULL,
O_ORDERDATE	DATE		NOT NULL,
O_ORDERPRIORITY CHAR(15)	NOT NULL,
O_CLERK		CHAR(15)	NOT NULL,
O_SHIPPRIORITY	NUMBER(12)	NOT NULL,
O_COMMENT	VARCHAR(79)	NOT NULL,
	CONSTRAINT ORDERS_PKEY PRIMARY KEY (O_ORDERKEY),
	CONSTRAINT ORDERS_FKEY1 FOREIGN kEY (O_CUSTKEY)
		REFERENCES CUSTOMER(C_CUSTKEY),
	CONSTRAINT ORDER_CHECK1 CHECK( O_TOTALPRICE >= 0) );

CREATE TABLE LINEITEM(
L_ORDERKEY 	NUMBER(12)	NOT NULL,
L_PARTKEY	NUMBER(12)	NOT NULL,
L_SUPPKEY	NUMBER(12)	NOT NULL,
L_LINENUMBER	NUMBER(12)	NOT NULL,
L_QUANTITY	NUMBER(12,2)	NOT NULL,
L_EXTENDEDPRICE NUMBER(12,2)	NOT NULL,
L_DISCOUNT	NUMBER(12,2)	NOT NULL,
L_TAX		NUMBER(12,2)	NOT NULL,
L_RETURNFLAG	CHAR(1)		NOT NULL,
L_LINESTATUS	CHAR(1)		NOT NULL,
L_SHIPDATE	DATE		NOT NULL,
L_COMMITDATE	DATE		NOT NULL,
L_RECEIPTDATE	DATE		NOT NULL,
L_SHIPINSTRUCT	CHAR(25)	NOT NULL,
L_SHIPMODE	CHAR(10)	NOT NULL,
L_COMMENT	VARCHAR(44)	NOT NULL,
	CONSTRAINT LINEITEM_PKEY PRIMARY KEY (L_ORDERKEY, L_LINENUMBER),
	CONSTRAINT LINEITEM_FKEY1 FOREIGN kEY (L_ORDERKEY)
		REFERENCES ORDERS(O_ORDERKEY),
	CONSTRAINT LINEITEM_FKEY2 FOREIGN KEY (L_PARTKEY)
		REFERENCES PART(P_PARTKEY),
	CONSTRAINT LINEITEM_FKEY3 FOREIGN KEY (L_PARTKEY,L_SUPPKEY)
		REFERENCES PARTSUPP(PS_PARTKEY, PS_SUPPKEY),
	CONSTRAINT LINEITEM_FKEY4 FOREIGN kEY (L_SUPPKEY)
		REFERENCES SUPPLIER(S_SUPPKEY),
	CONSTRAINT LINEITEM_CHECK1 CHECK (L_QUANTITY >= 0),
	CONSTRAINT LINEITEM_CHECK2 CHECK (L_EXTENDEDPRICE >= 0),
	CONSTRAINT LINEITEM_CHECK3 CHECK (L_TAX >= 0),
	CONSTRAINT LINEITEM_CHECK4 CHECK (L_DISCOUNT BETWEEN 0.00 AND 1.00) );

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* Multitable constraints							 */
/*	1.L_SHIPDATE <= L_RECEIPTDATE						 */
/*	2.O_ORDERDATE <= L_SHIPDATE						 */
/*	3.O_ORDERDATE <= L_COMMITDATE						 */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* End of script								 */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

spool off

