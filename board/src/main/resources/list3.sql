create table tbl_board3 (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

create sequence seq_board3 nocache;

alter table tbl_board3 add constraint pk_board3
primary key (bno);

create table tbl_reply3 (
    rno number(10, 0),
    bno number(10, 0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);

create sequence seq_reply3 nocache;

alter table tbl_reply3 add constraint pk_reply3 primary key(rno);

alter table tbl_reply3 add constraint fk_reply_board3
foreign key (bno) references tbl_board3(bno);

create index idx_reply3 on tbl_reply3 (bno desc, rno asc);

alter table tbl_board3 add (replycnt number default 0);

update tbl_board3 set replycnt = (select count(rno) from tbl_reply3 where tbl_reply3.bno = tbl_board3.bno);

insert into tbl_board3(bno,title,content, writer) (select seq_board3.nextval,title,content, writer from tbl_board3); //더미데이터 생산


create table tbl_member3(
      userid varchar2(50) not null primary key,
      userpw varchar2(100) not null,
      username varchar2(100) not null,
      regdate date default sysdate, 
      updatedate date default sysdate,
      enabled char(1) default '1'
);

create table tbl_member_auth3 (
     userid varchar2(50) not null,
     auth varchar2(50) not null,
     constraint fk_member_auth3 foreign key(userid) references tbl_member3(userid)
);

create table persistent_logins3 (
	username varchar(64) not null,
	series varchar(64) primary key,
	token varchar(64) not null,
	last_used timestamp not null
);