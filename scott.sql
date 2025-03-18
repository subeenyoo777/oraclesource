-- RDBMS 
-- 기본단위 : 테이블

-- EMP(사원정보 테이블)
-- empno(사번), ename(사원명), job(직책), mgr(직속상관사번), hiredate(입사일), sal(급여), comm(추가수당), deptno(부서번호)
-- NUMBER(4,0) : 전체 자릿수 4자리(소수점 자릿수 0)
-- VARCHAR2(10) : 문자열 10Byte (VAR : 가변 - 7byte 문자열 저장했다면 7byte 공간만 사용)
--                영어 10문자, 한글 2byte, utf-8 3byte 할당 
-- DATE : 날짜

-- DEPT(부서테이블)
-- deptno(부서번호), dname(부서명), loc(부서위치)

-- SALGRADE(급여테이블)
-- grade(급여등급), losal(최저급여), hisal(최대급여)

-- 개발자 : CR(Read)UD
-- SQL(Structured Query Language : 구조질의언어) : RDBMS 데이터를 다루는 언어


-- 1. 조회(SELECT) - Read
-- 사원정보조회(전체조회)
-- * (모든 열)
SELECT * FROM EMP e; 

-- 특정 열 조회
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e; 

-- 사원번호, 부서번호만 조회
SELECT e.EMPNO, e.DEPTNO FROM EMP e;


--별칭
SELECT
	ename,
	sal,
	sal * 12 + comm AS "annsal",
	comm
FROM
	emp;

SELECT
	ename,
	sal,
	sal * 12 + comm AS annsal,
	comm
FROM
	emp;

SELECT
	ename,
	sal,
	sal * 12 + comm AS 연봉,
	comm
FROM
	emp;

--에러 남. 이름이 공백이 있을 시, 쌍 따옴표 필수
--SELECT ename, sal, sal * 12 + comm AS 연 봉, comm FROM emp;

SELECT
	ename,
	sal,
	sal * 12 + comm AS "연 봉",
	comm
FROM
	emp;


SELECT
	e.ename 사원명,
	e.sal 급여,
	e.sal * 12 + e.comm AS 연봉,
	e.comm 수당
FROM
	emp e;

--원하는 순서대로 출력 데이터를 (오름, 내림 차순)정렬
--오름차순일 때 asc 생략 가능(default 설정)
--emp 테이블의 모든 열을 급여 기준으로 오름차순 조회
SELECT * FROM emp ORDER BY sal ASC;-- 오름차순
SELECT * FROM emp ORDER BY sal;-- 오름차순
SELECT * FROM emp ORDER BY sal DESC;-- 내림차순

--사원번호, 이름, 직무만 급여기준으로 내림차순 조회 
SELECT
	e.empno,
	e.ename,
	e.job
FROM
	emp e
ORDER BY
	e.sal DESC;

--부서번호의 오름차순 > 급여의 내림차순
 SELECT
	*
FROM
	emp e
ORDER BY
	e.DEPTNO ASC,
	e.SAL DESC;


SELECT
	e.EMPNO AS employee_no,
	e.ename AS employee_name,
	e.mgr AS manager,
	e.sal AS salary,
	e.comm AS commission,
	e.DEPTNO AS department_no
FROM
	emp e;


 SELECT
	*
FROM
	emp e
ORDER BY
	e.DEPTNO ASC,
	e.ename DESC;
 
 --where: 조회 시 조건 부여
--부서 번호가 30번인 사원 조회
SELECT *
FROM
	EMP e
WHERE
	e.deptno = 30;
	
 
 --사번이 7782 조회
 SELECT *
FROM
	EMP e
WHERE
	e.EMPNO = 7782;
 
--부서번호 30, 직책이 SALESMAN 조회
--오라클에서 문자는 '' 만 허용.
--문자열은 대소문자 구분함.
 SELECT *
FROM
	EMP e
WHERE
	e.deptno = 30
AND e.job = 'SALESMAN';
 

--사원번호 7499, 부서번호 30 사원 조회
SELECT
	*
FROM
	EMP E
WHERE
	E.EMPNO = 7499 AND E.DEPTNO = 30;

SELECT
	*
FROM
	EMP E
WHERE
	E.EMPNO = 7499 OR E.DEPTNO = 30;

--연산자 
--1) 산술 연산자 : +, -, *, /
--2)비교 연산자 : <, >, <=, >=
--3)등가비교연산자 : =, 같지 않다(!=, <>, ^=) 
 --4) 논리부정연산자 : NOT
--5)			  : IN
--6) 범위 : between A and B
--7) 검색 : LIKE 연산자와 와일드 카드(_ , % )
--8) IS NULL  : NULL 과 같다.

--연봉이 (SAL*12)3,6000 인 사원을 조회
SELECT
	*
FROM
	EMP E
WHERE
	E.SAL * 12 = 3600;

--급여가 30000이상인 사원을 조회
SELECT
	*
FROM
	EMP E
WHERE
	E.SAL * 12 >= 3000;

--급여가 2500이상이고 직업이 ANALYST 사원 조회
SELECT
	*
FROM
	EMP E
WHERE
	E.SAL * 12 >= 2500
	AND E.JOB = 'ANALYST';
 
--문자를 대소 비교 
--사원명의 첫 문자가 F 와 같거나 F 보다 뒤에 있는 사원 조회.
SELECT * 
FROM EMP E
WHERE E.ENAME >= 'F';
 
--급여가 30000 아닌 사원을 조회
SELECT * FROM EMP E WHERE E.SAL*12 != 3000;
SELECT * FROM EMP E WHERE E.SAL*12 <> 3000;
SELECT * FROM EMP E WHERE E.SAL*12 ^= 3000;
SELECT * FROM EMP E WHERE NOT E.SAL*12 = 3000;

--JOB이 MANAGER or SALESMAN or CLERK 사원 조회
SELECT 
	*
FROM
	emp e
WHERE
	e.job = 'MANAGER'
	OR e.job = 'SALESMAN'
	OR e.job = 'CLERK';

--IN version (in 연산자로 변경)
SELECT 
	*
FROM
	emp e
WHERE
	e.job IN( 'MANAGER', 'SALESMAN', 'CLERK');

--IN not version (in 연산자로 변경)
SELECT 
	*
FROM
	emp e
WHERE
	e.job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK');
 
--BETWEEN A AND B
--급여 2000이상  3000이하
SELECT * FROM EMP E WHERE E.SAL >= 2000 AND E.SAL <=3000;

SELECT * FROM EMP E WHERE E.SAL BETWEEN 2000 AND 3000;
--급여 2000이상  3000이하 아닌 사원 조회
SELECT * FROM EMP E WHERE E.SAL NOT BETWEEN 2000 AND 3000;


--LIKE : 검색 ( '=' 못 쓴다)
-- _ : 어떤 값이든 상관없이 한 개의 문자열 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자열 데이터를 의미 


-- 사원명이 S로 시작하는 사원 조회 
SELECT * FROM EMP E WHERE E.ENAME LIKE 'S%';

--사원 이름의 두번째 글자가 L인 사원을 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE '_L%';

--사원명에 AM 이 포함된 사원 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE '%AM%';

--사원명에 AM 이 포함되지 않은 사원 조회
SELECT * FROM EMP E WHERE E.ENAME NOT LIKE '%AM%';




--IS NULL
--COMM 이  NULL 인 사원 조회
SELECT * 
FROM EMP E
WHERE E.COMM IS NULL;

--MGR이 NULL 인 사원 조회 (=직속상관 없는)
SELECT * 
FROM EMP E
WHERE E.MGR IS NULL;

--직속 상관이 있는 사원 조회
SELECT * 
FROM EMP E
WHERE E.MGR IS NOT NULL;




















