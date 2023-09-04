create table board(
	num int not null auto_increment, -- 자동 증가
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(100) not null,
	indate datetime default now(), -- now() --> sysdate
	count int default 0,
	primary key(num)
);

create table reply(
	num int not null auto_increment, -- 자동 증가
	username varchar(255) not null, -- 사용자 아이디
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(100) not null,
	indate datetime default now(), -- now() --> sysdate
	count int default 0,
	-- 답변형 게시판
	bgroup int, -- 원글과 답글을 하나로 묶는 역할, 0 1 2 3 : 
	bseq int, -- 답글의 순서(asc)(0, 1, 2 ~)
	blevel int, -- 답글의 들여쓰기(0, 1, 2 ~)
	bdelete int default 0, -- 0(정상글), 1(삭제된 글)
	primary key(num)
);
select max(bgroup) from reply; -- null(0)
select IFNULL(max(bgroup)+1, 0) as bgroup from reply;
select * from reply;


-- insert
insert into board(title,content,writer)
values('스프링게시판','스프링게시판','관리자');
insert into board(title,content,writer)
values('스프링게시판','스프링게시판','정교훈');
insert into board(title,content,writer)
values('스프링게시판','스프링게시판','신형만');

select * from board;

create table member(
	idx int auto_increment primary key, -- 자동 증가
	username varchar(255) not null unique,
	password varchar(255) not null,
	name varchar(255) not null,
	email varchar(255) not null
);

-- member insert
insert into member(username,password,name,email)
values('smhrd01','smhrd01','관리자','smhrd01@naver.com');
insert into member(username,password,name,email)
values('jungkyohoon','11111','정교훈','jungkyohoon@naver.com');
insert into member(username,password,name,email)
values('smhrd02','smhrd02','신형만','smhrd02@naver.com');

select * from member;