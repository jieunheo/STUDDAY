/****** create database ******/
create database studdaydb;
use studdaydb;

/****** drop table ******/
drop table user;
drop table board;
drop table attach;
drop table reply;

/****** create table ******/
create table user
(
	no INT PRIMARY KEY auto_increment comment '회원번호',
	id VARCHAR(100) comment '아이디',
	pw VARCHAR(100) comment '비밀번호',
	nickname VARCHAR(50) comment '닉네임',
	email VARCHAR(50) comment '이메일',
	join_date DATETIME default now() comment '가입일시',
	retire VARCHAR(2) default 'N' comment '탈퇴여부',
	jop VARCHAR(100) comment '직업',
	interest VARCHAR(255) comment '관심사',
	intro TEXT comment '자기소개',
	page VARCHAR(255) comment '홈페이지',
	user_rank varchar(2) default 'U' comment '회원등급';
);

create table board
(
	bno INT PRIMARY KEY auto_increment comment '게시물번호',
	no INT comment '회원번호',
	kinds VARCHAR(2) comment '게시물종류',
	title VARCHAR(100) comment '제목',
	post TEXT comment '내용',
	lang VARCHAR(20) comment '언어',
	date DATETIME default now() comment '작성일',
	views INT default 0 comment '조회수',
	start_date DATETIME comment '시작날짜',
	end_date DATETIME comment '끝날짜',
	foreign key(no) references user(no)
);

create table attach
(
	ano INT PRIMARY KEY auto_increment comment '첨부번호',
	bno INT comment '게시물번호',
	no INT comment '회원번호',
	pname VARCHAR(255) comment '논리파일명',
	fname VARCHAR(255) comment '물리파일명',
	foreign key(no) references user(no),
	foreign key(bno) references board(bno)
);

create table reply
(
	rno int primary key auto_increment comment '댓글번호',
	bno int comment '게시물번호',
	no int comment '회원번호',
	rpost TEXT comment '댓글내용',
	rdate DATETIME default now() comment '댓글작성일',
	foreign key(no) references user(no),
	foreign key(bno) references board(bno)
);

