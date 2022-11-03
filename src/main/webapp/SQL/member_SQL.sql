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

select * from members; 