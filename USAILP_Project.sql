Drop Table TRANSACTION;
Drop Table EMPLOYEE;
Drop Table ROLE;
Drop Table ACCOUNT;
Drop Table CUSTOMER;

DELETE FROM ROLE;
DELETE FROM EMPLOYEE;
DELETE FROM CUSTOMER;
DELETE FROM ACCOUNT;
DELETE FROM TRANSACTION;


SELECT * FROM CUSTOMER;
SELECT * FROM ACCOUNT;
SELECT * FROM TRANSACTION;

CREATE TABLE ROLE
(   roleId      NUMBER          PRIMARY KEY,
    roleName	VARCHAR2(10)    NOT NULL    UNIQUE    
);
INSERT INTO ROLE VALUES(1,'Admin');
INSERT INTO ROLE VALUES(2,'Cashier');
SELECT * FROM ROLE;
SELECT * FROM ROLE WHERE roleName = ''; 
COMMIT;

CREATE TABLE EMPLOYEE
(   empId       NUMBER          PRIMARY KEY,
    username	VARCHAR2(255)   NOT NULL    UNIQUE CHECK(LENGTH(username) > 10),
    password	VARCHAR2(255)	NOT NULL,
    empName     VARCHAR2(100)   NOT NULL,
    isDeleted   NUMBER          DEFAULT 0 CHECK(isDeleted IN (0, 1)), --0 is active employee, 1 is inactive employee
    roleId	    NUMBER	        NOT NULL    REFERENCES ROLE(roleId)   
);
INSERT INTO EMPLOYEE VALUES(1,'user@123456','123456789', 'Leela Kosaraju',0, 1);
INSERT INTO EMPLOYEE(empId,username,password,empName,roleId) VALUES(2,'haiv@123456','123456789', 'Hai Vu', 2);
COMMIT;
SELECT * FROM EMPLOYEE;

CREATE TABLE CUSTOMER
(   cusId     	    NUMBER       	NOT NULL    PRIMARY KEY,
    cusSSN    	    VARCHAR2(10)	NOT NULL	UNIQUE,
    isDeleted       NUMBER          DEFAULT 0   CHECK(isDeleted IN (0, 1)), --0 is active,  1 is inactive 
    cusName   	    VARCHAR2(255)	NOT NULL,
    cusAddress	    VARCHAR2(255)	NOT NULL,
    cusState        VARCHAR(255)    NOT NULL,
    cusCity         VARCHAR(255)    NOT NULL,
    cusAge	        NUMBER(3,0)	    NOT NULL,
    cusUpMessage    VARCHAR2(500)   NOT NULL,
    lastUp          TIMESTAMP       NOT NULL,
    CONSTRAINT cusSSN CHECK(LENGTH(cusSSN) = 9)
);

INSERT INTO CUSTOMER VALUES(1,'123456789', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(2,'123456788', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(3,'123456787', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(4,'123456786', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(5,'123456785', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(6,'123456784', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(7,'123456783', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(8,'123456782', 1, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(9,'123456781', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(10,'123456780', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(11,'123456779', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(12,'123456778', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(13,'123456777', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(14,'123456776', 1, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(15,'123456775', 1, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(16,'123456774', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(17,'123456773', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(18,'123456772', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(19,'123456771', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER VALUES(20,'123456770', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
COMMIT;
SELECT * FROM CUSTOMER;
SELECT MAX(cusId) FROM CUSTOMER;

SELECT * FROM (
    SELECT cusId, cusSSN, isDeleted, cusName, cusAddress, cusState, cusCity, cusAge, cusUpMessage, lastUp, row_number()
    OVER (ORDER BY cusId) rowNumber
    FROM CUSTOMER
    WHERE isDeleted = 0
)
--WHERE rn BETWEEN :n AND :m
WHERE rowNumber BETWEEN 5 AND 15
ORDER BY rowNumber;
--N = From, M = To, N > 0

UPDATE CUSTOMER 
SET isDeleted = 1, cusUpMessage = '', lastUp = ''
WHERE cusId = ''



CREATE TABLE ACCOUNT
(   accId     	    NUMBER  	    NOT NULL    PRIMARY KEY,
    cusId	        NUMBER       	NOT NULL	REFERENCES CUSTOMER(cusId),
    accType 	    VARCHAR2(10)	NOT NULL    CHECK(accType in ('CURRENT', 'SAVINGS')),
    accBalance      NUMBER(10,2)    NOT NULL,
    isDeleted       NUMBER          DEFAULT 0   CHECK(isDeleted IN (0, 1)), --0 is active,  1 is inactive 
    accUpMessage    VARCHAR2(500)   NOT NULL,
    lastUp          TIMESTAMP       NOT NULL
);

INSERT INTO ACCOUNT VALUES(1,'123456789', 0, 'Leela Kosaraju', '1234 Street', 'Ohio', 'Cincinnati', 26, 'Cutomer has been created', CURRENT_TIMESTAMP);
COMMIT;
SELECT * FROM ACCOUNT;

CREATE TABLE TRANSACTION
(   trnId       NUMBER PRIMARY KEY,
    trnType     VARCHAR2(20)     NOT NULL   CHECK(trnType in ('WITHDRAW', 'DEPOSIT','TRANSFER')),
    trnDate     TIMESTAMP        NOT NULL,
    trnAmount   NUMBER           NOT NULL   CHECK(trnAmount > 0),
    trnSource   NUMBER       	 NOT NULL	REFERENCES ACCOUNT(accId),
    trnTarget   NUMBER           NULL 	    REFERENCES ACCOUNT(accId)
);
--COMMIT;