# 데이터베이스(DB)

1. 개념 : 데이터베이스는 체계회된 데이터의 모임

   ​		   몇개의 자료 파일을 조직적으로 통합해, 자료항목의 중복을 없애고, 자료를 구조화

2. 장점 : 데이터 중복 최소화, 데이터무결성(정확한 정보를 보장), 일관성, 독립성

3. 관계형 데이터베이스

   ​		[고객] : 릴레이션 이름

   ​		번호    이름    주소    전화번호    취미   :  head, intention(내포)

   ​          1	     가영	서울	123-456	운동   : body, extention

   ​          2

   ​		식별자   

   어트리뷰트  어트리뷰트  어트리뷰트  어트리뷰트  어트리뷰트

4.  SQLite : 서버가 아닌 응용 프로그램에 넣어 사용하는 비교적 간단한 SQL

5. 기본 용어

    - ##### 스키마  (자료의 구조, 표현방법, 관계 등을 정의한 구조)

      	column      datatype
        	​     id				INT
        	​     age			 INT
      
    - ##### table, column(고유의 datatype으로 저장), row(테이블의 데이터가 행에 저장됨)
      
    - ##### PK(기본키)



## SQL 개념

      ​	관계형 데이터 베이스 관리시스템의 데이터를 관리하기 위해 설계된 특수 목적의 프로그래밍 언어
      ​	DDL - 데이터 정의 언어
      ​	DML - 데이터 조작 언어 - 데이터 저장, 수정, 삭제, 조회 (Django에서 crud)
      		  ex. INSERT, UPDATE, DELETE, SELECT



## SQlite

계정의 환경변수에 sqlite 압축푼거 저장.

development 안에 database만든 후, sqlite3치면  -> 해당 DB를 콘솔로 연다

	SQLite version 3.29.0 2019-07-10 17:32:03
	Enter ".help" for usage hints.
	Connected to a transient in-memory database.
	Use ".open FILENAME" to reopen on a persistent database.
	sqlite> 
이렇게 나와야함. 이를 끄기 위해선 Ctrl + Z + Enter 또는 .exit

### [ DDL ] : CREATE, DRPO, ALTER

```bash
$ sqlite3 tutorial.sqlite3
sqlite> .databases  # 우리는 현재 tutorial.sqlite3 안에 있음
sqlite> .mode csv    # csv를 import 할것이다.
sqlite> .import hellodb.csv examples  # 어떤 테이블로 만들 것인지 명시해줌
sqlite> SELECT * FROM examples;  # examples안에 있는 모든 데이터를 보겠다 (키워드(SELECT문) * 키워드)

# 이쁘게 보기
sqlite> .headers on
sqlite> .mode column
sqlite> SELECT * FROM example;  # 키워드는 대문자로 쓰고, 나머지는 소문자로 쓰는 것을 권장
id          first_name  last_name   age         country     phone
----------  ----------  ----------  ----------  ----------  -------------
1           길동          홍           600         충청도         010-2424-1232
```

```bash
# Table 생성
sqlite> CREATE TABLE classmates( 
   ...> id INTEGER PRIMARY KEY,   # 어떤 타입이 들어가는지
   ...> name TEXT
   ...> );  # ; 나오면 모든 것이 작성되었다고 본다
   
# 하나의 DB안에 여러 table이 있음(user table, movies table, movie_rates table,,)
```

* datatype 
  	 - BOOLEAN은 0과 1로 표현
    	 - NUMERIC : 시간, BOOLEAN
        	 - BLOB : 이미지파일, 텍스트파일과 같은 것들

```bash
# table 확인
sqlite> .tables
classmates  examples  # 지금 table 2개 있음

# classmates shema 확인
sqlite> .schema classmates
CREATE TABLE classmates(
id INTEGER PRIMARY KEY,
name TEXT
);

# example schema 확인
sqlite> .schema examples
CREATE TABLE examples(
  "id" TEXT,
  "first_name" TEXT,
  "last_name" TEXT,
  "age" TEXT,
  "country" TEXT,
  "phone" TEXT
);
```

```bash
# table 삭제
sqlite> DROP TABLE classmates;
sqlite> .tables
examples
```

```bash
# 실습
$ sqlite3 tutorial.sqlite3
SQLite version 3.29.0 2019-07-10 17:32:03
Enter ".help" for usage hints.
sqlite> .tables
examples
sqlite> CREATE TABLE classmates(
   ...>     name TEXT,
   ...>     age INT,
   ...>     address TEXT
   ...> );
sqlite> .tables
classmates  examples
```

```bash
# id를 PK로 넣어줌
sqlite> DROP TABLE classmates;  # 지우고
sqlite> CREATE TABLE classmates(  # 다시만든다
   ...>     id INTEGER PRIMARY KEY,
   ...>     name TEXT NOT NULL,
   ...>     age INT NOT NULL,
   ...>     address TEXT NOT NULL
   ...> );
   
# 이때, id값도 넣어줘야함. -> SQLite가 만들어주는 id값을 사용하는 것이 편리
sqlite> INSERT INTO classmates
   ...> VALUES (1, '홍길동', 30, '서울');
sqlite> SELECT * FROM classmates;
id          name        age         address
----------  ----------  ----------  ----------
1           홍길동         30          서울
```



### [ DML ]

1. INSERT

```bash
# 실습 : 이름 홍길동, 나이 23 인 데이터를 추가하라
# INSERT
sqlite> INSERT INTO classmates (name, age)
   ...> VALUES ("홍길동", 23);
sqlite> SELECT * FROM classmates;
홍길동|23|
# 이쁘게 보기
sqlite> .header on
sqlite> .mode colum
sqlite> SELECT * FROM classmates;
name        age         address
----------  ----------  ----------
홍길동         23


# 실습 : 이름 홍길동, 나이 30인 데이터를 추가하라
INSERT INTO classmates (name, age, address)
VALUES ('홍길동', 30, '서울');
SELECT * FROM classmates;
# 이때, head의 순서대로 모든 데이터를 나열해두면 그대로 들어간다. 
# but, 하나의 데이터라도 빠지면 안됨
INSERT INTO classmates  # 가능!
VALUES ('홍길동', 30, '서울');
SELECT * FROM classmates;  

# 따로 PRIMARY KEY 속성 컬럼을 작성하지 않으면, 값이 자동으로 증가하는 PK옵션을 가진 rowid 컬럼을 정의한다.
# SQLite는 PK를 지정하지 않으면, rowid를 자동으로 정의
# INTEGER PRIMARY KEY 하면 rowid로 나옴
sqlite> SELECT rowid, * FROM classmates;
rowid       name        age         address
----------  ----------  ----------  ----------
1           홍길동         23
2           홍길동         23          서울
3           홍길동         30          서울

# data추가하려면 
INSERT INTO classmates   
VALUES ('양희철', 27, '연신내'),('김은성', 27, '위례신도시'),('정승원', 25, '신대방삼거리'),('김현화', 24, '낙성대'),('김혜준', 26, '수원'),('박권응', 28, '구디'),('이인동', 29, '혜화') ;
SELECT * FROM classmates;

```



2. SELECT 

```bash
# 특정 데이터만 가지고 온다
# classmates에서 id, name colum만 가지고오기
sqlite> SELECT rowid, name FROM classmates;
rowid       name
----------  ----------
1           홍길동
2           양희철
3           김은성
4           정승원
5           김현화
6           김혜준
7           박권응
8           이인동

# classmates에서 id, name colum 1개만 가지고오기
sqlite> SELECT rowid, name FROM classmates LIMIT 1;
rowid       name
----------  ----------
1           홍길동

# classmates에서 id, name 값ㅇ르 세번째에 있는 값 하나만 가지고오기
sqlite> SELECT rowid, name FROM classmates LIMIT 1 OFFSET 2;  # 2번을 뛰어넘은 값으로 가겠다
rowid       name
----------  ----------
3           김은성

# classmates에서 id, name 값 중에 주소가 서울인 사람만 가지고오기
sqlite> SELECT rowid, name FROM classmates WHERE address='서울';
rowid       name
----------  ----------
1           홍길동

# classmates에서 age값 전체를 중복없이 가지고오기
sqlite> SELECT DISTINCT age FROM classmates;
age
----------
30
27
25
24
26
28
29
```

```
sqlite에 명령하는 것은 .help, .tables와 같은 것은 ;이 붙지 않음
SELECT와 같이 특정 데이터를 핸들링하는 것은 ; 붙음
```



3. DELETE

###### 중복이 불가능한 값인 rowid를 기준으로 하자!!!!

```bash
# classmates에서 id가 4인 레코드를 삭제하기
sqlite> DELETE FROM classmates WHERE rowid=4;
sqlite> SELECT rowid, * FROM classmates;
rowid       name        age         address
----------  ----------  ----------  ----------
1           홍길동         30          서울
2           양희철         27          연신내
3           김은성         27          위례신도시
5           김현화         24          낙성대
6           김혜준         26          수원
7           박권응         28          구디
8           이인동         29          혜화


# classmate에 id가 1인 레코드를 이름 홍길동, 주소 제주도로 바꾸기
UPDATE classmates
SET name="홍길동", address="제주도" WHERE rowid=2;
```

```bash
# AUTOINCREMENT가 메모리를 많이 차지함으로, 특정한 요구사항이 없다면 AUTOINCREMENT속성을 사용하지 않아야함
# PK를 재사용하지 말고, 사용하지 않은 다음행 값으로 사용하자 -> AUTOINCREMENT
sqlite> CREATE TABLE tests(
   ...>     id INTEGER PRIMARY KEY AUTOINCREMENT,
   ...>     name TEXT
   ...> );
sqlite> INSERT INTO tests VALUES (1, '홍길동'),(2, '김철수');
sqlite> SELECT * FROM tests;
id          name
----------  ----------
1           홍길동
2           김철수
   
# rowid 2번 삭제
sqlite> DELETE FROM tests WHERE id=2;
sqlite> SELECT * FROM tests;
id          name
----------  ----------
1           홍길동

# 사람 추가해도 2번 말고 3번부터 들어감
sqlite> INSERT INTO tests (name) VALUES ('최철순');
sqlite> SELECT * FROM tests;
id          name
----------  ----------
1           홍길동
3           최철순
```



4. WHERE문 심화

``` bash
# users에서 age가 30 이상인 사람만 가지고온다면?
sqlite> SELECT * FROM users WHERE age>=30;

# users에서 age가 30 이상인 사람의 이름만 가지고온다면?
sqlite> SELECT first_name FROM users WHERE age>=30;

# users에서 age가 30 이상이고, 성이 김인 사람의 이름과 나이만 가지고온다면?
sqlite> SELECT first_name, age FROM users WHERE age>=30 AND last_name="김";

# users 테이블의 레코드 총 개수는?
sqlite> SELECT COUNT(*) FROM users;

# users에서 30살 이상인 사람들의 평균 나이는?
sqlite> SELECT AVG(age) FROM users WHERE age>=30;

# users에서 계좌잔액(balance)이 가장 높은 사람과 액수는?
sqlite> SELECT MAX(balance), last_name, first_name FROM users;  # WHERE문 필요 없음
MAX(balance)  last_name   first_name
------------  ----------  ----------
990000        김           선영

# users에서 30살 이상인 사람의 계좌 평균 잔액은?
sqlite> SELECT AVG(balance) FROM users WHERE age>=30;
AVG(balance)
----------------
153541.425120773
```



5. LIKE (wild cards)

```bash
# 와일드카드 2가지 패턴
    # _ 반드시 이 자리에 한개의 문자가 존재해야함
    # % 이 뒤에 문자가 있을 수도있고, 없을수도 있다.  
# 2% : 2로 시작하는 값
# %2 : 2로 끝나는 값
# %2% : 2가 들어가는 값
# _2% : 아무값이나 들어가고 두번째가 2로 시작하는 값(최소 두글자)
# 1_ _ _ : 1로 시작하고 4자리인 값
# 2_%_%/2_ _ % : 2로 시작하고 3자리 이상
```

```bash
# user에서 20대인 사람은?
sqlite> SELECT * FROM users WHERE age LIKE '2%';

# users에서 지역번호가 02인 사람만?
sqlite> SELECT * FROM users WHERE phone LIKE '02-%';

# users에서 이름이 '준'으로 끝나는 사람만?
sqlite> SELECT * FROM users WHERE first_name LIKE '%준';

# users에서 가운데 번호가 '5114'인 사람만?
sqlite> SELECT * FROM users WHERE phone LIKE '%5114%';
```



6. ORDER

```bash
# users에서 나이순으로 오름차순 정렬하여 상위 10개만 뽑아보면?
sqlite> SELECT * FROM users ORDER BY age ASC LIMIT 10;
# ASC는 디폴트값, 나이가 같은 사람들이 10명보다 많다면, id값을 기준으로 뽑게됨

# users에서 나이순으로 내림차순 정렬하여 상위 10개만 뽑아보면?
sqlite> SELECT * FROM users ORDER BY age DESC LIMIT 10;

# users에서 나이순, 성 순으로 오름차순 정렬하여 상위 10개만 뽑아보면?
sqlite> SELECT * FROM users ORDER BY age, last_name ASC LIMIT 10;

# user에서 계좌잔액순으로 내림차순 정렬하여 해당하는 사람의 성과 이름을 10개만 뽑아보면?
sqlite> SELECT last_name, first_name, balance FROM users ORDER BY balance DESC LIMIT 10;
last_name   first_name  balance   # 이것은 오답 why? balance가 TEXT로 되어있어서!!!
----------  ----------  ----------   # 쿼리문 자체는 틀리지 않음
김           선영          990000
나           상현          99000   
이           정호          99000
이           상철          99000
최           지아          9900
박           준서          9900
문           미영          980000
고           하윤          980000
유           은정          980000
안           서윤          980000
```



7. 테이블 이름 변경   8. 새로운 컬럼 추가

```bash
# articles만들기
sqlite> CREATE TABLE articles(
   ...> title TEXT NOT NULL,
   ...> content TEXT NOT NULL
   ...> );
   
# 7. 테이블 이름 변경
sqlite> ALTER TABLE articles RENAME TO news;

# 8. 새로운 컬럼 추가
sqlite> ALTER TABLE news ADD COLUMN create_at DATETIME;
sqlite> ALTER TABLE news ADD COLUMN subtitle TEXT NOT NULL DEFAULT 1;
```

### [schema 바꾸기]

```bash
sqlite> .schema users
sqlite> CREATE TABLE users(
   ...> "id" TEXT,
   ...> "first_name" TEXT,
   ...> "last_name" TEXT,
   ...> "age" TEXT,
   ...> "country" TEXT,
   ...> "phone" TEXT,
   ...> "balance" TEXT
   ...> );
sqlite> INSERT INTO users SELECT * FROM _users;

sqlite> SELECT * FROM users;


# balance가 TEXT
SELECT last_name, first_name, balance FROM _users ORDER BY balance DESC LIMIT 10;
# balance가 INTEGER
SELECT last_name, first_name, balance FROM users ORDER BY balance DESC LIMIT 10;
```



