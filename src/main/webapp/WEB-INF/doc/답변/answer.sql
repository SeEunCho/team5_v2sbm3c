DROP TABLE answer CASCADE CONSTRAINTS;
CREATE TABLE answer(
        answerno                            NUMBER(10)       NOT NULL        PRIMARY KEY,
        answer                              VARCHAR2(500)        NOT NULL,
        adate                               DATE         NOT NULL,
        qnano                               NUMBER(10)       NULL,
        adminid                             NUMERIC(10)      NULL ,
  FOREIGN KEY (qnano) REFERENCES qna (qnano),
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

COMMENT ON TABLE answer is '답변';
COMMENT ON COLUMN answer.answerno is '답변번호';
COMMENT ON COLUMN answer.answer is '답변본문';
COMMENT ON COLUMN answer.adate is '답변일자';
COMMENT ON COLUMN answer.qnano is '질문번호(FK)';
COMMENT ON COLUMN answer.adminid is '관리자 번호';

DROP SEQUENCE answer_seq;
CREATE SEQUENCE answer_seq
  START WITH 1             
  INCREMENT BY 1         
  MAXVALUE 9999999999 
  CACHE 2                     
  NOCYCLE; 
  
  
insert into answer(answerno, answer, adate)
values (answer_seq.nextval, '홍길동입니다.', sysdate);
insert into answer(answerno, answer, adate)
values (answer_seq.nextval, '밥 여기있어요', sysdate);
insert into answer(answerno, answer, adate)
values (answer_seq.nextval, '그럴리가요', sysdate);
insert into answer(answerno, answer, adate)
values (answer_seq.nextval, '잘가요', sysdate);

commit; 
select answerno, answer, adate, qnano, adminid
from answer
where qnano=25;

update answer
set answer='잘가기 전에 업데이트'
where answerno=4;

delete from answer
where answerno=4;

commit;