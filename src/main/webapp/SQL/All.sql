drop database nerdcommunity; 
create database GoroGoroCommunity; 
use GoroGoroCommunity; 

-- 1. 게시판 대분류 카테고리 만들기 
drop table boardCategory;
CREATE TABLE GoroGoroCommunity.boardCategory (
	boardCategoryNo int not null auto_increment primary key, 
	boardCategoryName varchar(50) not null,
	creationDate timestamp default now()
); 
select * from boardCategory;
rollback;
-- 2. 카테고리(대분류)에 속한 "게시판 만들기" 
drop table boardInCategory;
CREATE TABLE GoroGoroCommunity.boardInCategory (
	boardNo	int not null auto_increment primary key, -- 게시판 자체의 인덱스
	boardName varchar(50) not null,-- 게시판의 이름
	CreationDate timestamp default now(), 
	boardCategoryNo int not null, 
    foreign key(boardCategoryNo) references boardCategory(boardCategoryNo) on delete cascade-- 게시판이 속한 대분류 카테고리의 인덱스 
); 
select * from boardInCategory; 
alter table boardInCategory 
modify column boardCategoryNo int not null; 

-- 3. 자유게시판 만들기(자유게시판을 삭제하고자 한다면 먼저 댓글테이블부터 제거해야합니다. )
drop table freeBoard; 
CREATE TABLE GoroGoroCommunity.freeBoard (
	postNo int not null auto_increment primary key, -- 게시물 번호
	title varchar(50) not null, -- 게시물 제목(index)
	content text not null, -- 업로드한 게시물의 내용
	writer varchar(50) not null, -- 작성자
	regDate timestamp default now(), -- 작성일
    viewCount int default 0, -- 조회수
    sameThinking int default 0, -- 공감수
    fileName varchar(100), -- 업로드한 파일이 있는 경우, 파일이름
    boardNo	int not null, -- 이 게시판의 번호(index)
	imageFileName varchar(100) default null, -- 업로드 하신 이미지 파일이 있는 경우, 이미지 파일의 이름  
    foreign key(boardNo) references boardInCategory(boardNo) on delete cascade
); 

commit; 
select * from boardInCategory;
insert into boardInCategory(boardNo, boardName, boardCategoryNo) values(1, '공지사항', null); 
insert into boardInCategory(boardNo, boardName, boardCategoryNo) values(2, '익명', null); 
insert into boardInCategory(boardNo, boardName, boardCategoryNo) values(3, '내가 쓴 게시물', null); 
delete from boardInCategory where boardNo=3;


-- 4. 댓글(게시판 삭제하실려면 먼저 댓글부터 삭제해야합니다. )
drop table reply; 
CREATE TABLE GoroGoroCommunity.reply (
	postNo	int not null, -- 이 게시물의 번호(index)
    replyNo int not null auto_increment primary key, -- 댓글 번호
	replyContent text not null, -- 업로드한 댓글의 내용
    replyWriter varchar(50) not null, -- 댓글 작성자
    replyRegDate timestamp default now(), -- 댓글 작성일
    foreign key(postNo) references freeBoard(postNo) on delete cascade
); 

-- 5. 회원가입
drop table members; 
CREATE TABLE GoroGoroCommunity.members (
	memberNo	int not null auto_increment primary key, -- 회원 일련번호(index)
    email		varchar(100) not null unique, -- 가입자 이메일 번호(로그인시 아이디로 사용할 예정, 중복금지)
	passwords	varchar(100) not null, -- 비밀번호
    nick		varchar(100) not null unique, -- 회원 이름(닉네임, 변경가능으로 할예정)
	question	varchar(100) not null, -- 이메일, 비밀번호 분실 시 질문 
    answer		varchar(100) not null, -- 이메일, 비밀번호 분실 시 답변
    signUpDate timestamp default now() -- 회원가입날짜
); 

-- 3. 자유게시판 만들기(자유게시판을 삭제하고자 한다면 먼저 댓글테이블부터 제거해야합니다. )
drop table freeBoard; 
CREATE TABLE GoroGoroCommunity.freeBoard (
	postNo int not null auto_increment primary key, -- 게시물 번호
	title varchar(50) not null, -- 게시물 제목(index)
	content text not null, -- 업로드한 게시물의 내용
	writer varchar(50) not null, -- 작성자
	regDate timestamp default now(), -- 작성일
    viewCount int default 0, -- 조회수
    sameThinking int default 0, -- 공감수
    fileName varchar(100), -- 업로드한 파일이 있는 경우, 파일이름
    boardNo	int not null, -- 이 게시판의 번호(index)
	imageFileName varchar(100) default null, -- 업로드 하신 이미지 파일이 있는 경우, 이미지 파일의 이름  
    foreign key(boardNo) references boardInCategory(boardNo) on delete cascade
); 
select * from members;
drop table reportBoard;
CREATE TABLE GoroGoroCommunity.reportBoard (
	respotNo int not null auto_increment primary key, -- 신고번호
	reportReason varchar(50) not null, -- 신고사유(제목)
	detail text not null, -- 신고 상세사유
	reporter varchar(50) not null, -- 신고자
    reported varchar(50) not null, -- 신고당한사람
    reportDate timestamp default now(), 
	postNo	int not null, -- 이 게시판의 번호(index)
    fileName varchar(100), -- 업로드한 파일이 있는 경우, 파일이름
	imageFileName varchar(100) default null, -- 업로드 하신 이미지 파일이 있는 경우, 이미지 파일의 이름  
    foreign key(postNo) references freeboard(postNo) on delete cascade
); 


