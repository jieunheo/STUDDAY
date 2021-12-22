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
	no INT PRIMARY KEY auto_increment comment 'ȸ����ȣ',
	id VARCHAR(100) comment '���̵�',
	pw VARCHAR(100) comment '��й�ȣ',
	nickname VARCHAR(50) comment '�г���',
	email VARCHAR(50) comment '�̸���',
	join_date DATETIME default now() comment '�����Ͻ�',
	retire VARCHAR(2) default 'N' comment 'Ż�𿩺�',
	jop VARCHAR(100) comment '����',
	interest VARCHAR(255) comment '���ɻ�',
	intro TEXT comment '�ڱ�Ұ�',
	page VARCHAR(255) comment 'Ȩ������',
	user_rank varchar(2) default 'U' comment 'ȸ�����';
);

create table board
(
	bno INT PRIMARY KEY auto_increment comment '�Խù���ȣ',
	no INT comment 'ȸ����ȣ',
	kinds VARCHAR(2) comment '�Խù�����',
	title VARCHAR(100) comment '����',
	post TEXT comment '����',
	lang VARCHAR(20) comment '���',
	date DATETIME default now() comment '�ۼ���',
	views INT default 0 comment '��ȸ��',
	start_date DATETIME comment '���۳�¥',
	end_date DATETIME comment '����¥',
	foreign key(no) references user(no)
);

create table attach
(
	ano INT PRIMARY KEY auto_increment comment '÷�ι�ȣ',
	bno INT comment '�Խù���ȣ',
	no INT comment 'ȸ����ȣ',
	pname VARCHAR(255) comment '�����ϸ�',
	fname VARCHAR(255) comment '�������ϸ�',
	foreign key(no) references user(no),
	foreign key(bno) references board(bno)
);

create table reply
(
	rno int primary key auto_increment comment '��۹�ȣ',
	bno int comment '�Խù���ȣ',
	no int comment 'ȸ����ȣ',
	rpost TEXT comment '��۳���',
	rdate DATETIME default now() comment '����ۼ���',
	foreign key(no) references user(no),
	foreign key(bno) references board(bno)
);

