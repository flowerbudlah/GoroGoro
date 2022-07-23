drop database GoroGoroCommunity; 
create database GoroGoroCommunity; 
use GoroGoroCommunity; 

-- 1. 게시판 대분류 카테고리 만들기 
drop table boardCategory;
CREATE TABLE GoroGoroCommunity.boardCategory (
	boardCategoryNo int not null auto_increment primary key, -- 대분류 인덱스
	boardCategoryName varchar(50) not null,--대분류 이름
	creationDate timestamp default now() -- 카테고리 만든날
); 
commit;

-- 2. 위 카테고리(대분류)에 속한 게시판 만들기 
drop table boardInCategory;
CREATE TABLE GoroGoroCommunity.boardInCategory (
	boardNo	int not null auto_increment primary key, -- 게시판 자체의 인덱스
	boardName varchar(50) not null,-- 게시판의 이름
	CreationDate timestamp default now(), --게시판 만든날
	boardCategoryNo int not null, --이 게시판이 속한 대분류 카테고리 번호
    foreign key(boardCategoryNo) references boardCategory(boardCategoryNo) -- 게시판이 속한 대분류 카테고리의 인덱스와 외래키
); 

select * from boardInCategory order by boardNo; 
delete from boardInCategory; 
select * from boardInCategory where boardCategoryNo = 1 order by BoardNo; 
commit;

-- 3. 자유게시판 만들기
drop table freeBoard; 
CREATE TABLE GoroGoroCommunity.freeBoard (
	postNo int not null auto_increment primary key, -- 게시물 번호
	title varchar(50) not null, -- 게시물 제목(index)
    content text not null, -- 업로드한 게시물의 내용
    writer varchar(50) not null, -- 작성자
    regDate timestamp default now(), -- 작성일
    viewCount int default 0, -- 조회수
    sameThinking int default 0, -- 공감수
    uploadFileName varchar(500), -- 업로드한 파일이 있는 경우, 파일이름
    boardNo	int not null, -- 이 게시판의 번호(index)
    foreign key(boardNo) references boardInCategory(boardNo)
); 

commit;

update freeboard set sameThinking = 0 where postNo=1; 

select count(*) from freeBoard where boardNo = 1; 

select * from freeBoard; 
delete from freeboard; 
select * from freeBoard where postno=1;

-- 4. 댓글 
drop table reply; 
CREATE TABLE GoroGoroCommunity.reply (
	postNo	int not null, -- 이 게시물의 번호(index)
    replyNo int not null auto_increment primary key, -- 댓글 번호
	replyContent text not null, -- 업로드한 댓글의 내용
    replyWriter varchar(50) not null, -- 댓글 작성자
    replyRegDate timestamp default now(), -- 댓글 작성일
	
    foreign key(postNo) references freeBoard(postNo)
); 
select * from reply; 
commit; 


