drop table LoginRecord;

CREATE TABLE GoroGoroCommunity.LoginRecord (
	loginRecordNo int not null auto_increment primary key, -- 로그인 일련번호
	memberNo int, -- 회원일련번호
	email varchar(100) not null, -- 가입자 이메일 번호(로그인시 아이디로 사용할 예정, 중복금지)
	loginRecordRealTime timestamp default now()
);

select * from LoginRecord;
commit;