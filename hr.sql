-- employees ( scott 의 emp 동일 개념)
--first_name, last_name, job_name 조회

SELECT
	e.first_name,
	e.last_name,
	e.job_id
FROM
	EMPLOYEES e ;  --from을 먼저 하면 필드 조회하기 쉬워짐.

--job_id 중복제외 후 조회
SELECT
	DISTINCT e.job_id
FROM
	EMPLOYEES e;

--사번이 176인 사원의 last_name 과 부서번호 조회
SELECT e.last_name, e. DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE e.EMPLOYEE_ID = 176;

--급여가 12000 이상되는 사원의 last_name과 급여를 조회
SELECT e.last_name, e.SALARY
FROM EMPLOYEES e 
WHERE e.salary >= 12000
ORDER BY e.SALARY ASC;


--급여가 5000 ~ 12000 범위가 아닌 사원의 last_name, 급여 조회
SELECT e.last_name, e.SALARY
FROM EMPLOYEES e 
WHERE NOT (e.salary <= 5000 AND e.SALARY >= 12000);
-- WHERE e.salary < 5000 OR e.SALARY > 12000;


--BETWEEN A AND B
SELECT e.last_name, e.SALARY
FROM EMPLOYEES e 
WHERE e.salary NOT BETWEEN 500 AND 1200;

--IN / NOT IN
--20, 50 번 부서에 근무하는 사원 조회(LAST_NAME, 부서번호), LAST_NAME 오름차순
SELECT
	E.LAST_NAME, E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID IN (20, 50)
ORDER BY E.LAST_NAME ASC; 
	

--SALARY가 2500, 3500, 7000 이 아니며
--직무가 SA_ERP, ST_CLERK 가 아닌 사원 조회
SELECT *
FROM EMPLOYEES E
WHERE E.SALARY NOT IN (2500, 3500, 7000)
  AND E.JOB_ID NOT IN ('SA_ERP', 'ST_CLERK');


--고용일이 2014년인 사원을 조회(2014-01-01 ~ 2014-12-31)
--(문자뿐 아니라) 날짜 데이터에 '' 사용
SELECT * 
FROM EMPLOYEES e 
WHERE E.HIRE_DATE >= '2014-01-01' 
AND E.HIRE_DATE <= '2014-12-31' ;

--BETWEEN A AND B
SELECT * 
FROM EMPLOYEES e 
WHERE E.HIRE_DATE BETWEEN '2014-01-01' AND '2014-12-31';


--LIKE
--LAST_NAME에 u 가 포함되는 사원들의 사번, last_name 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE last_name LIKE '%u%';


--last_name의 4번째 글자가 a인 사원들의 사번, last_name 조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE last_name LIKE '___a%';


--last_name 에 a 혹은 e 글자가 있는 사원들의 사번, last_name 조회(last_name 내림차순)
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE e.last_name LIKE '%a%' OR 
	  e.LAST_NAME like '%e%'
ORDER BY e.last_name DESC;

--last_name 에 a와 e 글자가 있는 사원들의 last_name 조회(last_name 내림차순)
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e 
WHERE e.last_name LIKE '%a%e%' or 
	  e.LAST_NAME like '%e%a%'
ORDER BY e.last_name DESC;

--IS NULL
--메니저가 없는 사원들의 LAST_NAME, JOB_ID 조회
SELECT E.LAST_NAME, E.JOB_ID
FROM 
EMPLOYEES e 
WHERE E.MANAGER_ID IS NULL;

--ST_CLERK 인 직업을 가진 사원이 없는 부서 번호 조회(단 부서번호가 NULL값인 부서 제외)
SELECT DISTINCT E.DEPARTMENT_ID 
FROM EMPLOYEES E
WHERE E.JOB_ID != 'ST_CLERK '
AND E.DEPARTMENT_ID IS NOT NULL;

--COMMISION_PCT 가 NULL 이 아닌 사원들 중에서 COMMISSION = SALARY * COMMISSION_PCT 를 구한다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, E.SALARY * E.COMMISSION_PCT AS COMMISSION  
FROM EMPLOYEES E 
WHERE E.COMMISSION_PCT  IS NOT NULL;

--first name이 'Curtis'인 사람의 fist_name과 last_name, email, phone_number, job_id 조회
--단 job_id 결과는 소문자로 출력한다.
SELECT e.FIRST_NAME, e.LAST_NAME , e.EMAIL , e.PHONE_NUMBER , lower(e.JOB_ID) AS JOB_ID   
FROM EMPLOYEES e 
WHERE e.FIRST_NAME = 'Curtis';
--출력) Curtis / Davies / CDAVIES / 1.650.555.0142 / st_clerk


--부서번호가 60, 70, 80, 90 인 사원들의 사번, first_name, last_name, hire_date, job_id 조회
--단 job_id 가 IT_PROG인 사원들의 경우 '프로그래머'로 변경하여 출력한다.
SELECT e.FIRST_NAME, e.LAST_NAME , e.HIRE_DATE , REPLACE(e.JOB_ID, 'IT_PROG', '프로그래머') AS job_id 
FROM EMPLOYEES e 
WHERE e.DEPARTMENT_ID IN (60, 70, 80, 90);

--job_id 가 AD_PRES, PU_CLERK 인 사원들의 사번, first_name, last_name, 부서번호, job_id 조회
--단 사원명은 first_name, last_name을 연결하여 출력한다(예_ Douglas Grant)
SELECT e.EMPLOYEE_ID , e.FIRST_NAME ||' ' || e.LAST_NAME AS name, e.DEPARTMENT_ID , e.JOB_ID  
FROM EMPLOYEES e 
WHERE e.job_id IN ('AD_PRES', 'PU_CLERK');


--입사 10주년이 되는 날짜 출력
SELECT
	E.EMPLOYEE_ID,
	E.HIRE_DATE,
	ADD_MONTHS(HIRE_DATE, 120)
FROM
	EMPLOYEES e; 
--출력 한 줄: 199 / Douglas	 / 2018-01-13 00:00:00.000 / 2028-01-13 00:00:00.000



--회사 내의 최대연봉과 최소연봉의 차이 조회
SELECT MAX(E.SALARY) - MIN(E.SALARY) AS GAP FROM EMPLOYEES E;


--매니저로 근무하는 사원들의 숫자 조회
SELECT COUNT(DISTINCT E.MANAGER_ID)
FROM EMPLOYEES E;










