/**********************************/
/* Table Name: 질문 카테고리 */
/**********************************/

-- 01.05 memberid컬럼 삭제(회원은 카테고리를 관리할 필요가 없음.)

DROP TABLE qna_cate CASCADE CONSTRAINTS;
CREATE TABLE qna_cate(
        qcateno                             NUMBER(10)       NOT NULL        PRIMARY KEY,
        name                                VARCHAR2(100)        NOT NULL,
        adminid                             NUMBER(10)       NULL ,
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

COMMENT ON TABLE qna_cate is '질문 카테고리';
COMMENT ON COLUMN qna_cate.qcateno is '질문 카테고리 번호';
COMMENT ON COLUMN qna_cate.name is '질문 카테고리 이름';
COMMENT ON COLUMN qna_cate.adminid is '관리자번호';


DROP SEQUENCE qna_cate_seq;
CREATE SEQUENCE qna_cate_seq
  START WITH 1             
  INCREMENT BY 1         
  MAXVALUE 9999999999 
  CACHE 2                     
  NOCYCLE; 
  
 -- forign key 해결되는대로 추가 insert
insert into qna_cate(qcateno, name, adminid) values(qna_cate_seq.nextval, '상품', 1);
insert into qna_cate(qcateno, name, adminid) values(qna_cate_seq.nextval, '기타', 1);
insert into qna_cate(qcateno, name, adminid) values(qna_cate_seq.nextval, '홈페이지', 1);
insert into qna_cate(qcateno, name, adminid) values(qna_cate_seq.nextval, '삭제컬럼', 1);

commit;

select * from qna_cate;

select name from qna_cate ;


select qnano, q.title, q.text, secret, q.qdate, q.qcateno, q.memberid
from qna_cate c, qna q
where c.qcateno=q.qcateno;


select * from qna;

select qcateno, name, adminid
from qna_cate

update qna_cate
set name='사용방법'
where name='기타' and adminid=1;

delete from qna_cate
where qcateno=5;

commit;



/**********************************/
/* Table Name: 질문 */
/**********************************/

-- 01.05 memberid fk 추가

DROP TABLE qna CASCADE CONSTRAINTS;
CREATE TABLE qna(
        qnano                               NUMBER(10)          NOT NULL         PRIMARY KEY,
        title                               VARCHAR2(100)       NOT NULL,
        secret                              CHAR(1)             DEFAULT 'N'      NOT NULL,
        text                                VARCHAR2(500)       NOT NULL,
        qdate                               DATE                NOT NULL,
        qcateno                             NUMBER(10)          NULL ,
        memberid                            NUMBER(10)          NULL,
        
  FOREIGN KEY (memberid) REFERENCES member (memberid),
  FOREIGN KEY (qcateno) REFERENCES qna_cate (qcateno)
);

COMMENT ON TABLE qna is '질문';
COMMENT ON COLUMN qna.qnano is '질문 번호';
COMMENT ON COLUMN qna.title is '제목';
COMMENT ON COLUMN qna.secret is '비공개글 여부';
COMMENT ON COLUMN qna.text is '본문';
COMMENT ON COLUMN qna.qdate is '문의일자';
COMMENT ON COLUMN qna.qcateno is '질문 카테고리 번호';


DROP SEQUENCE qna_seq;
CREATE SEQUENCE qna_seq
  START WITH 1             
  INCREMENT BY 1         
  MAXVALUE 9999999999 
  CACHE 2                     
  NOCYCLE; 

insert into answer(answerno, answer, adate, qnano, adminid)
values (answer_seq.nextval, '홍길동입니다.', sysdate, 1, 1);
insert into answer(answerno, answer, adate, qnano, adminid)
values (answer_seq.nextval, '밥 여기있어요', sysdate, 1, 1);
insert into answer(answerno, answer, adate, qnano, adminid)
values (answer_seq.nextval, '그럴리가요', sysdate, 2, 2);
insert into answer(answerno, answer, adate, qnano, adminid)
values (answer_seq.nextval, '잘가요', sysdate, 3, 3);

commit; 

select qnano, title, secret, text, qdate, memberid 
from qna
where memberid=7;

commit;

update qna
set title='삭제되기전 업데이트', text='업데이트 테스트', secret='Y'
where qnano = 6;

delete from qna
where qcateno=5;

commit;


