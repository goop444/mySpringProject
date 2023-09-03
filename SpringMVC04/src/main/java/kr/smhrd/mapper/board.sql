create table reply(
	num int not null auto_increment, -- 자동증가
	username varchar(255) not null, -- 사용자 아이디
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(100) not null,
	indate datetime default now(),-- mysql에 있는 날짜와 시간을 저장하는 함수 sysdate랑 같음
	count int default 0,
	-- 답변형 게시판에서 필요한 컬럼
	bgroup int, -- 원글(부모글)과 답글을 하나로 묶는 역할, 순차적으로 증가시켜서 그룹을 만들어 주면 된다. 0부터 시작할지 1부터 시작할지 지정해 주면 된다. 내림차순으로 정렬 한다.
				-- 0 부터 하는게 좋다. 이유:
	bseq int, -- 답글의 순서를 지정할때 필요 ; 답글의 순서이기 때문에 부모 글은 무조건 0 이다. 부모 A의 답글 R1의 시퀀스는 1이다 부모(A)는 0 답글도 최근 글이 먼저 보여야 한다. 답글은 시퀀스를 기준으로 오름차순으로 정렬
	blevel int, -- 답글의 들여쓰기(0: 부모는 들여쓰기 안함, 1: 답글을 한칸 들여쓰기 함, 2는 두칸 들여쓰기, 3은 세칸 들여쓰기, 4는 4칸.... 간격 맞추기
	bdelete int default 0, -- 0(정상글) 1(삭제된글) // 게시글이 삭제되면 디비에서 지우는게 아니라 1로 바꾸고 1이면 삭제된 게시물입니다 하고 보여준다. 
	primary key(num)
);

select *from reply;
create table board(
	num int not null auto_increment, -- 자동증가
	title varchar(100) not null,
	content varchar(2000) not null,
	writer varchar(100) not null,
	indate datetime default now(),-- mysql에 있는 날짜와 시간을 저장하는 함수 sysdate랑 같음
	count int default 0,
	primary key(num)
);
create table member(
	idx int auto_increment primary key,
	username varchar(255) not null unique,
	password varchar(255) not null,
	name varchar(255) not null,
	email varchar(255) not null
);
select max(bgroup) from reply; --null 이 나
select IFNULL(max(bgroup)+1,0) as bgroup from reply; 
insert into member(username,password,name,email)
values('smhrd01','smhrd01','관리자','smhrd01@naver.com');
insert into member(username,password,name,email)
values('smhrd02','smhrd02','이종은','smhrd02@naver.com');
insert into member(username,password,name,email)
values('smhrd03','smhrd03','피카츄','smhrd03@naver.com');


select * from member;

