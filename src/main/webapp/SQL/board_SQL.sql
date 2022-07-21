drop database nerdCommunity; 
create database nerdCommunity; 
use nerdCommunity; 

-- 1. 1) 게시판 대분류 카테고리 만들기 
drop table boardCategory;
CREATE TABLE nerdCommunity.boardCategory (
	boardCategoryNo int not null auto_increment primary key, 
	boardCategoryName varchar(50) not null,
	creationDate timestamp default now()
); 
-- 1. 2) 아래는 실행할 필요는 없음. 
insert into boardCategory values(1, '관세사 1차', now());
insert into boardCategory(boardCategoryNo, boardCategoryName) values(2, '관세사 2차');
insert into boardCategory(boardCategoryName) values('프로그래밍');
select * from boardCategory order by boardCategoryNo;
commit;

-- 2. 카테고리(대분류)에 속한 게시판 만들기 
drop table boardInCategory;
CREATE TABLE nerdCommunity.boardInCategory (
	boardNo	int not null auto_increment primary key, -- 게시판 자체의 인덱스
	boardName varchar(50) not null,-- 게시판의 이름
	CreationDate timestamp default now(), 
	boardCategoryNo int not null, 
    foreign key(boardCategoryNo) references boardCategory(boardCategoryNo) -- 게시판이 속한 대분류 카테고리의 인덱스 
); 

select * from boardInCategory order by boardNo; 
delete from boardInCategory; 

select * from boardInCategory where boardCategoryNo = 1 order by BoardNo; 
commit;

-- 3. 자유게시판 만들기
drop table freeBoard; 
CREATE TABLE nerdCommunity.freeBoard (
	postNo int not null auto_increment primary key, 
	title varchar(50) not null, 
    content text not null, 
    writer varchar(50) not null, 
    regDate timestamp default now(), 
    viewCount int default 0, 
    boardNo	int not null, 
    foreign key(boardNo) references boardInCategory(boardNo)
); 

commit; 
select * from freeBoard;
