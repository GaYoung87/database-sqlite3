-- DDL Data Definition Language
/*
    여기는 주석
*/
DROP TABLE classmates;
CREATE TABLE classmates(
    name TEXT,
    age INT,
    address TEXT
);


-- id 지정해줌 -> 이때, insert into 하고 values에 값 넣을때, id값도 무조건 넣어줘야함
DROP TABLE classmates;
CREATE TABLE classmates(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INT NOT NULL,
    address TEXT NOT NULL
);


-- SQLite에서 제공하는 id값 사용하기
DROP TABLE classmates;
CREATE TABLE classmates(
    name TEXT NOT NULL,
    age INT NOT NULL,
    address TEXT NOT NULL
);


-- PK를 재사용하지 말고, 사용하지 않은 다음행 값으로 사용하자 -> AUTOINCREMENT
-- table이름은 복수형인것이 좋음
CREATE TABLE tests(  
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

INSERT INTO tests VALUES (1, '홍길동'),(2, '김철수');


-- articles만들기
CREATE TABLE articles(
title TEXT NOT NULL,
content TEXT NOT NULL
);

-- 테이블 이름 변경
ALTER TABLE articles RENAME TO news;

-- 새로운 컬럼 추가
ALTER TABLE news ADD COLUMN create_at DATETIME;
ALTER TABLE news ADD COLUMN subtitle TEXT NOT NULL DEFAULT 1;



-- <schema 바꾸기>
ALTER TABLE users RENAME TO _users;

CREATE TABLE users(
"id" INTEGER PRIMARY KEY AUTOINCREMENT,
"first_name" TEXT,
"last_name" TEXT,
"age" INTEGER,
"country" TEXT,
"phone" TEXT,
"balance" INTEGER
);

INSERT INTO users SELECT * FROM _users;

SELECT * FROM users;