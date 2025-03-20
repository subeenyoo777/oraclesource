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
 SELECT
	*
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
--9) 집합 연산자 : UNION, MINUS, INTERSECT



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



--집합 연산자
--UNION(합집합)
--부서번호 10, 20 사원 조회(or, in)

SELECT * FROM EMP E WHERE E.DEPTNO = 10 OR E.DEPTNO = 20 ;

SELECT * FROM EMP E WHERE E.DEPTNO IN (10, 20) ;

--타입 일치만 확인 => 타입이 맞는다면 연결
SELECT E.EMPNO, E.ENAME, E.SAL FROM EMP E WHERE E.DEPTNO = 10
UNION
SELECT E.EMPNO, E.ENAME, E.SAL FROM EMP E WHERE E.DEPTNO = 20;

--UNION(중복 제외하고 출력), UNION ALL(중복 데이터도 출력)
SELECT E.EMPNO, E.ENAME, E.SAL FROM EMP E WHERE E.DEPTNO = 10
UNION
SELECT E.EMPNO, E.ENAME, E.SAL FROM EMP E WHERE E.DEPTNO = 10;

SELECT E.EMPNO, E.ENAME, E.SAL FROM EMP E WHERE E.DEPTNO = 10
UNION ALL
SELECT E.EMPNO, E.ENAME, E.SAL FROM EMP E WHERE E.DEPTNO = 10;


--ㅡMINUS(차집합)
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO  FROM EMP E 
MINUS 
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO  FROM EMP E WHERE E.DEPTNO = 10;


--INTERSECT(교집합)
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO  FROM EMP E 
INTERSECT
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO  FROM EMP E WHERE E.DEPTNO = 10;

==================================================================
--오라클 함수
--내장함수
--1) 문자함수
--대소문자 바꿔주는 함수 : upper(), lower(), initcap()
--문자의 길이를 구하는 함수 : LENGTH(), LENGTHB()  byte 의미
--문자열 일부 추출 : SUBSTR(문자열데이터, 시작위치, 추출길이)
--문자열 데이터 안에서 특정 문자 위치 찾기 : INSTR()
--특정 문자를 다른 문자로 변경 : REPLACE(원본문자열, 찾을 문자열, 변경 문자열)
--두 문자열 데이터 합치기 : CONCAT(문자열1, 문자열2)    
--	CONCAT보다 이 기회를 더 많이 씀	||
--특정 문자 제거 : TRIM(), LTRIM(왼쪽용), RTRIM(오른쪽용)
--데이터의 공간을 특정 문자로 채우기 : LPAD(), RPAD()
--LPAD(데이터, 데이터 자릿수, 채울문자) .. 왼쪽으로 채움
--LPAD(데이터, 데이터 자릿수, 채울문자) ..오른쪽으로 채움

==================================================================
--Oracle = > 10자리로 표현
SELECT
	'Oracle',
	LPAD('Oracle', 10, '#'),
	RPAD('Oracle', 10, '*'),
	LPAD('Oracle', 10),
	RPAD('Oracle', 10)
FROM
	dual;







--사원 이름을 대문자, 소문자, 첫문자만 대문자로 변경
SELECT e.ENAME , upper(e.ENAME ), lower(e.ENAME ), initcap(E.ENAME )
FROM emp e;
--결과 한줄만 :SMITH / SMITH / smith / Smith

--제목 oracle 검색
--LIKE '%oracle%' OR LIKE '%ORACLE%' OR '%Oracle'
--SELECT * FROM board WHERE title upper(title) = upper('oracle');

--사원명 길이 구하기
SELECT e.ename, LENGTH(e.ename)
FROM emp e;

--사원명 5글자 이상인 사람 조회
SELECT *
FROM emp e
WHERE LENGTH(e.ename) >= 5;

--sql 구문 실행 순서
3 SELECT 
1 FROM
2 where
4 order by(데이터 많으면 속도면에서 안 하는게 나을 수도 있다)

--lengthb() : 문자열 바이트 수 반환
--xe 버전 : 한글에 3 byte 사용
--dual : sys 소유 테이블(임시 연산이나 함수의 결과값 확인 용도로 사용)
SELECT length('한글'), lengthb('한글') 
FROM dual;


--SUBSTR()
--시작위치 지정 시 양수(왼쪽), 음수(오른쪽) : 맨 끝부터 -1
SELECT E.JOB, SUBSTR(E.JOB,1,2), SUBSTR(E.JOB,5)
FROM EMP E;

SELECT
	E.JOB,
	SUBSTR(E.JOB,-LENGTH(E.JOB)), -- 시작위치가 -5
	SUBSTR(E.JOB,-LENGTH(E.JOB), 2 )
FROM
	EMP E;


--INSERT(대상 문자열, 위치를 찾으려는 문자, 시작할 위치, 시작위치에서 찾으려는 문자가 몇 번재인지)
SELECT
	INSTR('HELLO, ORACLE', 'L') AS INSTR_1,   --앞 두 조건은 필수
	INSTR('HELLO, ORACLE', 'L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE', 'L', 2, 2) AS INSTR_3
FROM
	DUAL;


--사원 이름의 S가 있는 사원 조회
SELECT *
FROM EMP E
WHERE E.ENAME LIKE '%S%';
--ORACLE 숫자의 시작은 1<>자바에서 시작은 0
SELECT *
FROM EMP E
WHERE INSTR(E.ENAME , 'S') > 0;

--REPLACE(원본문자열, 찾을 문자열, 변경 문자열)
SELECT '010-1234-5678' AS REPLACE_BEFORE,
REPLACE('010-1234-5678', '-', ' ' ) AS REPLACE1,
REPLACE('010-1234-5678', '-') AS REPLACE2
FROM DUAL;

--CONCAT(문자열1, 문자열2)
--사번 : 사원명 
SELECT CONCAT(E.EMPNO, CONCAT(' : ', E.ENAME ) )
FROM EMP E;

SELECT E.EMPNO || ' : ' || E.ENAME
FROM EMP E;

--TRIM 삭제 옵션(선택), 삭제할 문자(선택) FROM 원본문자열(필수)
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,							
	'[' || TRIM( LEADING FROM ' __Oracle__ ') || ']' AS trim_leading,	
	'[' || TRIM( TRAILING FROM ' __Oracle__ ') || ']' AS trim_trailing,	
	'[' || TRIM( BOTH FROM ' __Oracle__ ') || ']' AS trim_both		
FROM DUAL;
--[__Oracle__]	[__Oracle__✔]	[✔__Oracle__]	[__Oracle__]

SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,							
	'[' || LTRIM( ' __Oracle__ ') || ']' AS L_TRIM,
	'[' || RTRIM(' __Oracle__ ') || ']' AS R_TRIM,
	'[' || RTRIM('<_Oracle_>', '>_' ) || ']' AS RTRIM2			
FROM DUAL;
--[__Oracle__]	[__Oracle__✔]	[✔__Oracle__]	[<_Oracle]


--숫자함수
--반올림 : ROUND()
--버림 : TRUNC()
--가장 큰 정수 : CEIL()
--가장 작은 정수 : FLOOR()
--나머지 : MOD()

--반올림 개념
--      -2 -1  0  1  2
--1  2  3  4.  5  6  7  8

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678,0) AS ROUND1, --없거나 0_소수점 첫째자리에서 반올림
	ROUND(1234.5678,1) AS ROUND2, --6에서 반올림
	ROUND(1234.5678,2) AS ROUND3, --7에서 반올림
	ROUND(1234.5678,-1) AS ROUND4, --양수 4에서 반올림
	ROUND(1234.5678,-2) AS ROUND5 --
	FROM
	DUAL;

--결과값: 1235 / 1235	/ 1234.6 / 1234.57 / 1230 / 1200

SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678,0) AS TRUNC1, --없거나 0_소수점 첫째자리에서 반올림
	TRUNC(1234.5678,1) AS TRUNC2, --6에서 반올림
	TRUNC(1234.5678,2) AS TRUNC3, --7에서 반올림
	TRUNC(1234.5678,-1) AS TRUNC4, --양수 4에서 반올림
	TRUNC(1234.5678,-2) AS TRUNC5 --
	FROM
	DUAL;
--결과값 : 1234 / 1234 / 1234.5 / 1234.56 / 1230 / 1200


SELECT CEIL(3.14), FLOOR(3.14),CEIL(-3.14),FLOOR(-3.14)
FROM DUAL;
--결과값: 4 / 3 / -3 / -4

SELECT MOD(15,6), MOD(10, 2), MOD(11,2)
FROM DUAL;
--결과값 : 3 / 0 / 1

--날짜 함수
--오늘 현재 날짜/시간 : SYSDATE
--연산이 가능하다.
--몇개월 이후 날짜 구하기 : ADD_MONTHS()
--두 날짜 사이 간의 개월 수 차이 구하기 : MONTHS_BETWEEN()
--돌아오는 요일, 달의 마지막 날짜 구하기 : NEXT_DAY(), LAST_DAY()


SELECT
	SYSDATE AS NOW,
	SYSDATE -1  YESTERDATE,
	SYSDATE + 1 AS TOMORROW,
	CURRENT_DATE,
	CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM
	DUAL D;

--오늘 날짜 기준으로 3개월 뒤 날짜를 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) AS ADD_MONTHS
FROM DUAL D;

--출력결과 : 2025-03-19 17:33:19.000  /  2025-06-19 17:33:19.000 


--입사한지 40년이 넘은 사원
SELECT
	*
FROM
	EMP E
WHERE  
	ADD_MONTHS(E.HIREDATE, 480) < SYSDATE;

--HIREDATE 출력 결과
--1980-12-17 00:00:00.000
--1981-02-20 00:00:00.000
--1982-01-23 00:00:00.000

--오늘 날짜와 입사 일자의 차이 구하기
SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(E.HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(E.HIREDATE, E.HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(E.HIREDATE, SYSDATE)) AS MONTH3
FROM
	EMP E;

SELECT
	SYSDATE,
	NEXT_DAY(SYSDATE, '월요일') AS NEXT_DAY_OF_THE_WEEK,
	LAST_DAY(SYSDATE) AS LASTDAY_THIS_MONTH
FROM
	DUAL;

--자료형을 변환하는 형반환 함수
--TO_CHAR() : 숫자 또는 날짜 데이터를 문자열 데이터로 반환 
--TO_NUMBER() : 문자열 데이터를 숫자 데이터로 반환
--TO_DATE() : 문자열 데이터를 날짜 데이터로 반환


--NUMBER + '문자숫자' : 덧셈 가능(자동형변환)
SELECT E.EMPNO , E.ENAME , E.EMPNO + '500'
FROM EMP E 
WHERE E.ENAME = 'SMITH';

-- abcd + SMITH 는 에러
--SELECT E.EMPNO , E.ENAME , E.EMPNO + 'abcd'
--FROM EMP E 
--WHERE E.ENAME = 'SMITH';

--년 / 월 / 일 만 나오게. SIMPLE DATE FORMAT
SELECT  SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD')
FROM DUAL;
--출력 : 2025-03-19 17:55:18.000 / 2025/03/19

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM'),
	TO_CHAR(SYSDATE, 'MON'),
	TO_CHAR(SYSDATE, 'MONTH'),
	TO_CHAR(SYSDATE, 'DD'),
	TO_CHAR(SYSDATE, 'DY'),
	TO_CHAR(SYSDATE, 'DAY')
	TO_CHAR(SYSDATE, 'HH24:MI:SS'),
	TO_CHAR(SYSDATE, 'HH12:MI:AM'),
	TO_CHAR(SYSDATE, 'HH:MI:PM')
FROM DUAL;

--2025-03-19 17:57:40.000 / 03 / 3월 / 3월 / / 19 / 수 / 수요일
--17:59:45 / 05:59:오후 / 05:59:오후

--9 : 숫자 한자리를 의미
--0 : 숫자 한자리를 의미(빈자리를 0으로 채움)
SELECT e.sal, to_char(e.sal, '$999,999'), to_char(e.sal, '$000,999,999')
FROM emp e;
 
--문자열 데이터와 숫자 데이터 연산
SELECT 1300-'1500', 1300+ '1500'
FROM DUAL;
 
SELECT '1300' - '1500'
FROM DUAL;

--컴마가 들어가면 문자가 됨 > 연산X(수치가 부적합합니다)
SELECT '1,300' - '1,500'
FROM DUAL;

--TO_NUMBER('문자열 데이터'. '인식할 숫자 형태')
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500','999,999')
FROM DUAL;
--출력 : -200

--TO_DATE() : 문자열 데이터 => 날짜 형식으로 변경
SELECT
	TO_DATE('2025-03-20', 'YYYY-MM-DD') AS DATE1,
	TO_DATE('2025-03-20', 'YYYY/MM/DD') AS DATE2
FROM
	DUAL;

--NULL
--산술연산이나 비교 연산자(IS NULL)가 제대로 수행되지 않음.
-- 1)NVL(NULL 여부 검사할 데이터, NULL일 때 반환할 데이터)
-- 2) NVL2(NULL 여부 검사할 데이터, NULL이 아닐 때 반환할 데이터,NULL일 때 반환할 데이터)
SELECT E.EMPNO, E.ENAME, E.SAL, E.COMM, E.SAL+E.COMM, NVL(E.COMM, 0), E.SAL + NVL(E.COMM, 0)
FROM EMP E;


SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	E.COMM,
	E.SAL + E.COMM,
	NVL2(E.COMM, 'O', 'X'),
	NVL2(E.COMM, E.SAL *12 + E.COMM, E.SAL*12) AS 연봉
FROM EMP E;

--자바의 IF, SWITCH 구문과 유사
--DECODE
--DECODE( 검사대상이 될 데이터, 
--		  조건1, 만족시 반환할 결과
--		  조건2, 만족시 반환할 결과,
--	      조건1~조건n 일치하지 않을 때 반환할 결과
-- )

--CASE (컴마 사용하지 않음)
--CASE 검사대상이 될 데이터
--		WHEN 조건1 THEN 만족시 반환할 결과
--		WHEN 조건2 THEN 만족시 반환할 결과
--	    ELSE 조건1~조건n 일치하지 않을 때 반환할 결과
--END


--직책이 manager인 사원은 급여의 10%인상
--직책이 salseman인 사원은 급여의 5%인상
--직책이 analyst인 사원은 급여 동결
--나머지는 3% 인상

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB ,
	e.SAL ,
	decode(E.JOB, 'MANAGER' , E.SAL * 1.1,
				  'SALESMAN', E.SAL * 1.05,
				  'ANALYST', E.SAL,
				  E.SAL * 1.03
	)AS UPSAL
FROM
	emp e;

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB ,
	e.SAL ,
	CASE E.JOB
	WHEN 'MANAGER' THEN E.SAL * 1.1
	WHEN 'SALESMAN' THEN E.SAL * 1.05
	WHEN 'ANALYST' THEN E.SAL
	ELSE E.SAL * 1.03
	END AS UPSALL
	FROM
	emp e;


--COMM NULL 인 경우 '해당사항 없음'
--COMM 0 인 경우 '수당없음'
--COMM  > 0 인 경우 '수당 : 800'
--COMMITION이 NULL 이면 = 아닌 IS NULL 써야 해
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB ,
	e.SAL ,
	CASE 
	WHEN E.COMM IS NULL THEN '해당사항없음'
	WHEN E.COMM = 0 THEN '수당없음'
	WHEN E.COMM > 0 THEN '수당 : ' || E.COMM
	END AS COMM_TEXT
	FROM
	emp e;


--[실습]
--1. EMPNO 열에 7369 => 73**, ENAME SMITH => S****
--EMPNO, 마스킹처리EMPNO, ENAME, 마스킹처리ENAME
			 --원본 문자열,       찾을 문자열 		
SELECT REPLACE('7369', SUBSTR('7369',3), '**')
FROM DUAL;
--결과 : 73**

SELECT
	E.EMPNO,
	REPLACE(e.EMPNO, SUBSTR(e.EMPNO,3), '**') AS MASKING_EMPNO,
	E.ENAME,
FROM EMP E;


--RPAD
SELECT
	E.EMPNO,
	RPAD(SUBSTR(e.EMPNO, 1, 2), 4, '**') AS MASKING_EMPNO,
	E.ENAME,
	RPAD(SUBSTR(e.ENAME, 1, 1), 4, '**') AS MASKING_ENAME
FROM
	EMP E;


--2. EMP 테이블에서 사원의 월 평균 근무일수는 21이다.
--하루 근무시간을 8시간으로 보았을 때 사원의 하루 급여(day_pay)와 시급(time_pay)를
--계산하여 출력한다(단, 하루 급여는 소수 셋째자리에서 버리고, 시급은 둘째 자리에서 반올림)
--출력형태)EMPNO, ENAME, SAL, DAY_PAY, TIME_PAY

SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	TRUNC(E.SAL/21, 2)AS DAY_PAY,
	ROUND(E.SAL/21/8, 1) AS TIME_DAY
	FROM
	EMP E;

--3. 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
--사원이 정직원이 되는 날짜(R_JOB)을 YYYY-MM-DD 형식으로 출력한
--단, 추가 수당이 없는 사원의 추가수당은 N/A로 출력
--EMPNO, ENAME, HIREDATE, R_JOB, COMM
SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일') AS R_JOB,
	NVL(TO_CHAR(E.COMM), 'N/A')
	FROM
	EMP E;

--4. 직속상관의 사원번호가 없을 때 : 0000
--직속상관의 사원번호 앞 두자리가 75일 때 : 5555
--직속상관의 사원번호 앞 두자리가 76일 때 : 6666
--직속상관의 사원번호 앞 두자리가 77일 때 : 7777
--직속상관의 사원번호 앞 두자리가 78일 때 : 8888
--그 외 직속상관의 사원 번호일 때: 본래 직속상관 사원번호 그대로 출력
--출력형태 ) EMPNO, ENAME, CHG_MGR
SELECT
	E.EMPNO,
	E.ENAME,
	E.MGR,
	CASE 
		WHEN E.MGR IS NULL THEN '0000'
		WHEN SUBSTR(TO_CHAR(E.MGR), 1, 2) = '75 ' THEN ' 5555 '
		WHEN SUBSTR(TO_CHAR(E.MGR), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(E.MGR), 1, 2) = '76' THEN '7777'
		WHEN SUBSTR(TO_CHAR(E.MGR), 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(E.MGR)
	END AS CHG_MGR
FROM
		EMP E;

SELECT
	E.EMPNO,
	E.ENAME,
	E.MGR,
	CASE 
		WHEN E.MGR IS NULL THEN '0000'
		WHEN E.MGR LIKE '75%' THEN ' 5555'
		WHEN E.MGR LIKE '76%' THEN ' 6666'
		WHEN E.MGR LIKE '77%' THEN ' 7777'
		WHEN E.MGR LIKE '78%' THEN '8888'
		ELSE TO_CHAR(E.MGR)
	END AS CHG_MGR
FROM
		EMP E;

--하나의 열에 출력 결과를 담는 다중행 함수
---NULL 행은 제외하고 연산
-- 1. SUM()/ 2.COUNT() / 3. MAX() /  4. MIN() / 5. AVG()

--전체 사원 급여 합
SELECT SUM(E.SAL) 
FROM EMP E;

--중복된 급여를 제외한 전체 사원의 합
SELECT SUM(DISTINCT E.SAL), SUM(ALL E.SAL) FROM EMP E;

--단일 그룹의 그룹 함수가 아닙니다 (같이 출력하면 안되는 함수를 넣은 것)
SELECT E.ENAME, SUM(E.SAL) FROM EMP E;

--사원 수 구하기
SELECT COUNT(E.EMPNO), COUNT(E.COMM), COUNT(ALL e.COMM )
FROM EMP E;

--급여의 최대값과 최소값 구하기
SELECT
	max(e.SAL),
	min(e.SAL)
FROM
	emp e; 

--10번 부서의 사원 중 급여의 최대값 구하기
SELECT
	max(e.sal),
	min(e.sal)
FROM
	emp e
WHERE
	e.DEPTNO = 10;

--20번 부서의 입사일 중 가장 최근/늦은 입사일 출력(최근일수록 큰 수, 날짜도 숫자로 인식)
SELECT
	MAX(e.HIREDATE),
	MIN(e.HIREDATE)
	FROM emp e
WHERE
	e.DEPTNO = 20;

--부서번호가 30번인 사원의 평균 급여
SELECT AVG(E.SAL)
FROM EMP E
WHERE E.DEPTNO = 30;



--










