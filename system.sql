-- 오라클 관리자
-- system, sys(최고권한)

-- 사용자이름 : sys as sysdba
-- 비밀번호 : 엔터
 
-- 오라클 12c 버전부터 사용자계정 생성시 접두어(c##)를 요구함, 무조건
-- c##hr
-- c## 사용하지 않을때
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- @C:\app\soldesk\product\21c\dbhomeXE\rdbms\admin\scott.sql

-- 비밀번호 변경
-- 비밀번호만 대소문자 구별함
ALTER USER hr IDENTIFIED BY hr;

-- 계정 잠금 해제
-- ALTER USER hr account unlock;

--데이터 사전 DBA_USERS를 사용하여 사용자 정보 조회
--시스템에서만 가능한 것
--회사에선 보통 시스템 관리자만 권한 있음
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';

--scott view 생성 권한 부여
GRANT CREATE VIEW TO scott;


--사용자 관리
--오라클은 테이블, 인덱스, 뷰 등 사용자별로 여러 객체를 생성하므로 업무별 사용자를 생성한 후에 각 사용자
--업무에 맞는 데이터 구조를 만들어 관리하는 방식 사용

--데이터네비게이터 위치 : 사용자(scott..._) 들어있었음
--데이터베이스 스키마
--스키마 : 데이터베이스에서 데이터 간 관계, 데이터 구조, 제약 조건 등 데이터를 저장하고 관리하고자 정의한 데이터베이스 구조 범위

--오라클 데이터베이스에서는 스키마 == 사용자
--제일 처음에 설치했을 때 xe라는 이름을 가진 사용자가 존재했고, 그 밑에 스키마를 만들고 있는 것이다.

--우리만의 사용자를 만드는 방법
--사용사 생성 구문
--CREATE USER 사용자 이름 IDENTIFIED BY 비밀번호;

--CREATE USER 사용자 이름 IDENTIFIED BY 비밀번호
--DEFAULT TABLESPACE 테이블 스페이스명
--TEMPORARY TABLESPACE 테이블 스페이스 그룹명 ...임시 공간 설정
--QUOTA 테이블 스페이스 크기 ON 테이블 스페이스명;


--권한을 가지고 있지 않음.. 로그온 거절..
-- 1. 사용자 생성
CREATE USER C##JAVA IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS;

--2. 권한 부여(grant)
-- C##TEST의 BOARD 테이블에 SELECT, INSERT, DELETE 권한을 부여할게.
--GRANT SELECT, INSERT, DELETE ON BOARD TO C##TEST1;

--롤 : 여러 개의 권한이 묶여서 정의되어 있음(한꺼번에)
GRANT CONNECT, RESOURCE TO C##JAVA;
-- 앞으로 사용자 여러개 만들 예정임.

--[에러]공통 사용자 또는 롤 이름이 부적합합니다. 막아놓은 다음에 생성가능
--12ver~. C##을 안 붙였기 때문에 나는 오류
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; ---- c## 사용하지 않을때( Oracle의 내부 스크립트 모드로 전환하는 비공식(undocumented) 설정)
CREATE USER TEST2 IDENTIFIED BY 12345;

--전체 사용자 정보 조회
SELECT * FROM ALL_USERS
WHERE USERNAME = 'C##TEST1';

--비밀번호 변경(기존 CONNECTION을 끊고 다시 연결해야 함)
ALTER USER C##TEST1 IDENTIFIED BY 54321;
--==> 사용자~ 모두 시스템(관리자)할 수 있는 일

--사용자 제거
-- 현재 접속되어 있는 사용자는 삭제할 수 없습니다(접속 끊은 후에 사용 가능)
DROP USER C##TEST1;

DROP USER C##TEST1 cascade;


















