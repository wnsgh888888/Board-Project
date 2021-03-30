create table tbl_board2 (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

create sequence seq_board2 nocache;

alter table tbl_board2 add constraint pk_board2
primary key (bno);

create table tbl_reply2 (
    rno number(10, 0),
    bno number(10, 0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

create sequence seq_reply2 nocache;

alter table tbl_reply2 add constraint pk_reply2 primary key(rno);

alter table tbl_reply2 add constraint fk_reply_board2
foreign key (bno) references tbl_board2(bno);

create index idx_reply2 on tbl_reply2 (bno desc, rno asc);

alter table tbl_board2 add (replycnt number default 0);

update tbl_board2 set replycnt = (select count(rno) from tbl_reply2 where tbl_reply2.bno = tbl_board2.bno);

insert into tbl_board2(bno,title,content, writer) (select seq_board2.nextval,title,content, writer from tbl_board2); //더미데이터 생산


create table tbl_member2(
      userid varchar2(50) not null primary key,
      userpw varchar2(100) not null,
      username varchar2(100) not null,
      regdate date default sysdate, 
      updatedate date default sysdate,
      enabled char(1) default '1'
);

create table tbl_member_auth2 (
     userid varchar2(50) not null,
     auth varchar2(50) not null,
     constraint fk_member_auth3 foreign key(userid) references tbl_member3(userid)
);

create table persistent_logins2 (
	username varchar(64) not null,
	series varchar(64) primary key,
	token varchar(64) not null,
	last_used timestamp not null
);
