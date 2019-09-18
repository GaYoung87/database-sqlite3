-- DML Data Manipulation Language

-- <INSERT>
INSERT INTO classmates (name, age)
VALUES ('홍길동', 23);
SELECT * FROM classmates;

INSERT INTO classmates (name, age, address)
VALUES ('홍길동', 30, '서울');
SELECT * FROM classmates;

-- 이때, head의 순서대로 모든 데이터를 나열해두면 그대로 들어간다. 
-- but, 하나의 데이터라도 빠지면 안됨
INSERT INTO classmates   
VALUES ('홍길동', 30, '서울');
SELECT * FROM classmates;

-- 따로 PRIMARY KEY 속성 컬럼을 작성하지 않으면, 값이 자동으로 증가하는 PK옵션을 가진 rowid 컬럼을 정의한다
-- SQLite는 PK를 지정하지 않으면, rowid를 자동으로 정의
SELECT rowid, * FROM classmates;
/*
rowid       name        age         address
----------  ----------  ----------  ----------
1           홍길동         23
2           홍길동         23          서울
3           홍길동         30          서울
*/

-- 여러data추가하려면 
INSERT INTO classmates   
VALUES ('양희철', 27, '연신내'),('김은성', 27, '위례신도시'),('정승원', 25, '신대방삼거리'),('김현화', 24, '낙성대'),('김혜준', 26, '수원'),('박권응', 28, '구디'),('이인동', 29, '혜화') ;
SELECT * FROM classmates;



-- <데이터 조회(SELECT)> -> 특정 데이터만 가지고 온다
-- classmates에서 id, name colum만 가지고오기
SELECT rowid, name FROM classmates;

-- classmates에서 id, name colum 1개만 가지고오기
SELECT rowid, name FROM classmates LIMIT 1;
 
-- classmates에서 id, name 값ㅇ르 세번째에 있는 값 하나만 가지고오기
SELECT rowid, name FROM classmates LIMIT 1 OFFSET 2;

-- classmates에서 id, name 값 중에 주소가 서울인 사람만 가지고오기
SELECT rowid, name FROM classmates WHERE address='서울';

-- classmates에서 age값 전체를 중복없이 가지고오기
SELECT DISTINCT age FROM classmates;



-- <DELETE>
-- 중복이 불가능한 값인 rowid를 기준으로 하자!!!!
-- classmates에서 id가 4인 레코드를 삭제하기
DELETE FROM classmates WHERE rowid=4;

-- classmate에 id가 1인 레코드를 이름 홍길동, 주소 제주도로 바꾸기
UPDATE classmates
SET name="홍길동", address="제주도" WHERE rowid=2;



-- <WHERE문 심화>
-- users에서 age가 30 이상인 사람만 가지고온다면?
SELECT * FROM users WHERE age>=30;

-- users에서 age가 30 이상인 사람의 이름만 가지고온다면?
SELECT first_name FROM users WHERE age>=30;

-- users에서 age가 30 이상이고, 성이 김인 사람의 이름과 나이만 가지고온다면?
SELECT first_name, age FROM users WHERE age>=30 AND last_name="김";

-- users 테이블의 레코드 총 개수는?
SELECT COUNT(*) FROM users;

-- users에서 30살 이상인 사람들의 평균 나이는?
SELECT AVG(age) FROM users WHERE age>=30;

-- users에서 계좌잔액(balance)이 가장 높은 사람과 액수는?
SELECT MAX(balance), last_name, first_name FROM users;

-- users에서 30살 이상인 사람의 계좌 평균 잔액은?
SELECT AVG(balance) FROM users WHERE age>=30;



-- <LIKE>
-- 와일드카드 2가지 패턴
    -- - 반드시 이 자리에 한개의 문자가 존재해야함
    -- % 이 뒤에 문자가 있을 수도있고, 없을수도 있다.                    

-- user에서 20대인 사람은?
SELECT * FROM users WHERE age LIKE '2%';

-- users에서 지역번호가 02인 사람만?
SELECT * FROM users WHERE phone LIKE '02-%';

-- users에서 이름이 '준'으로 끝나는 사람만?
SELECT * FROM users WHERE first_name LIKE '%준';

-- users에서 가운데 번호가 '5114'인 사람만?
SELECT * FROM users WHERE phone LIKE '%5114%';



-- <ORDER>
-- users에서 나이순으로 오름차순 정렬하여 상위 10개만 뽑아보면?
SELECT * FROM users ORDER BY age ASC LIMIT 10;
-- ASC는 디폴트값, 나이가 같은 사람들이 10명보다 많다면, id값을 기준으로 뽑게됨

-- users에서 나이순으로 내림차순 정렬하여 상위 10개만 뽑아보면?
SELECT * FROM users ORDER BY age DESC LIMIT 10;

-- users에서 나이순, 성 순으로 오름차순 정렬하여 상위 10개만 뽑아보면?
SELECT * FROM users ORDER BY age, last_name ASC LIMIT 10;

-- user에서 계좌잔액순으로 내림차순 정렬하여 해당하는 사람의 성과 이름을 10개만 뽑아보면?
SELECT last_name, first_name, balance FROM users ORDER BY balance DESC LIMIT 10;


-- balance가 TEXT
SELECT last_name, first_name, balance FROM _users ORDER BY balance DESC LIMIT 10;
-- balance가 INTEGER
SELECT last_name, first_name, balance FROM users ORDER BY balance DESC LIMIT 10;