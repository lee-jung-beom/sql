2021-0405-01) 인덱스 객체
(사용형식)
CREATE [UNIQUE[BITMAP] INDEX 인덱스명
    ON 테이블명(컬럼명1 [, 컬럼명2,....]) [ASC|DESC]
*용어 : 식별자 관계
*비식별 관계

사용예)상품테이블에서 상품명으로 NORMAL INDEX를 구성하시오
CREATE INDEX IDX_PROD_NAME
    ON PROD(PROD_NAME);
    
사용예)장바구니 테이블에서 장바구니 번호 중 3번째에서 6글자로 인덱스를
    구성하시오.
CREATE INDEX IDX_CART_NO
    ON CART(SUBSTR(CART_NO, 3, 6));
    
**인덱스의 재구성
 - 데이터 테이블을 다른 테이블스페이스로 이동시킨 후 
 - 자료의 삽입과 삭제 동작 후 
 (사용형식)
 ALTER INDEX 인덱스명 REBUILD;
 

2021-0405-02)PL/SQL
 - PROCEDURAL LANGUAGE sql의 약자
 - 표준 SQL에 절차적 언어의 기능(비교, 반복, 변수 등)이 추가
 - 블록(BLOCK)구조로 구성
 - 미리 컴파일되어 실행 가능한 강태로 서버에 저장되어 필요시 호출되어 사용됨
 - 모듈화, 캡슐화 기능 제공
 - Anonymous Block, Stored Procedure, User Defined Function,
   Package, Trigger 등으로 구성
   
1. 익명블록
    - pl/sql의 기본 구조
    - 선언부와 실행부로 구성
    (구성형식)
DECLARE 
    --선언영역
    --변수, 상수, 커서 선언 
BEGIN 
    --실행영역
    --BUSINESS LOGIC 처리
    
    [EXCEPTION 
     예외처리명령;
    ]
END;

사용예) 키보드로 2-9사이의 값을 입력 받아 그 수에 해당하는 구구단을 작성하시오

ACCEPT P_NUM PROMPT '수 입력(2-0) : '
DECLARE
    V_BASE NUMBER :=  TO_NUMBER('&p_NUM');
    V_CNT NUMBER :=  0;
    V_RES NUMBER :=  0;
BEGIN 
    LOOP
        V_CNT := V_CNT + 1;
        EXIT WHEN V_CNT > 9;
        V_RES := V_BASE * V_CNT;
        
        DBMS_OUTPUT.PUT_LINE(V_BASE || '*' || V_CNT || '=' || V_RES);
    END LOOP;
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM); --SQLERRM : 에러메시지를 출력하는 기능
END;        
    
 1)변수, 상수 선언 
  - 실행영역에서 사용할 변수 및 상수 선언 
  (1)변수의 종류 
    . SCLAR 변수 - 하나의 데이터를 저장하는 일반적 변수
    . REFERENCE 변수 - 해당 테이블의 컬럼이나 행에 대응하는 타입과
      크기를 참조하는 변수
    . COMPOSITE 변수 - PL/SQL에서 사용하는 배열 변수
      RECORD TYPE
      TABLE TYPE 변수 
    . BIND 변수 - 파라미터로 넘겨지는 IN, ON, INOUT에서 사용되는 변수
        RETURN되는 값을 전달받기 위한 변수
  (2)선언방식
    변수명 [CONSTANT] 데이터타입 [:=초기값]
    변수명 테이블명.컬럼명%TYPE [:=초기값], -> 컬럼 참조형
    변수명 테이블명%ROWTYPE -> 행참조형
  (3)데이터타입
    - 표준 SQL에서 사용하는 데이터 타입
    - PLS_INTEGER, BINARY_INTEGER : 2147483647 ~~ 2147483648까지 자료 처리
    - BOOLEAN : TRUE, FALSE, NULL 처리
    - LONG, LONG RAW : DEPRECATED
        
예)장바구니에서 2005년 5월 가장 많은 구매를 한(구매금액 기준) 회원정보를 
   조회하시오(회원번호, 회원명, 구매금액합)
   
(표준 SQL)
SELECT 회원번호, 회원명, 구매금액합
    FROM (SELECT A.CART_MEMBER AS MID, 
                 SUM(C.PROD_PRICE*A.CART_QTY) AS AMT 
          FROM CART A, PROD C
          WHERE AND A.CART_PROD = C.PROD_ID
          GROUP BY A.CART_MEMBER
          ORDER BY 2 DESC) D, MEMBER B
        
GROUP BY A.CART_MEMBER, B.MEM_NAME
ORDER BY 3 DESC;

  
SELECT *
FROM member;


