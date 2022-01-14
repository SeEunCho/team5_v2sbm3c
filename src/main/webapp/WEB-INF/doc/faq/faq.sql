/**********************************/
/* Table Name: 자주묻는질문(FAQ) */
/**********************************/
CREATE TABLE faq(
		faqno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		title                         		VARCHAR2(50)		 NOT NULL,
		text                          		VARCHAR2(500)		 NOT NULL,
		Cdate                         		DATE		 NOT NULL,
		adminid                       		NUMBER(10)		 NULL ,
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

COMMENT ON TABLE faq is '자주묻는질문(FAQ)';
COMMENT ON COLUMN faq.faqno is 'FAQ번호';
COMMENT ON COLUMN faq.title is 'FAQ제목';
COMMENT ON COLUMN faq.text is 'FAQ본문';
COMMENT ON COLUMN faq.Cdate is '생성일자';
COMMENT ON COLUMN faq.adminid is '관리자번호';
DROP SEQUENCE faq_seq;
CREATE SEQUENCE faq_seq;
  START WITH 1             
  INCREMENT BY 1         
  MAXVALUE 9999999999 
  CACHE 2                     
  NOCYCLE; 
  
  
INSERT INTO faq(faqno, title, text, Cdate, adminid)
VALUES (faq_seq.nextval, '사용법이 궁금해요!', '아직 만들고 있는 중이에요!', sysdate, 1);

INSERT INTO faq(faqno, title, text, Cdate, adminid)
VALUES (faq_seq.nextval, '뭘 하는 사이트인가요?', '주택정보를 제공하는 홈페이지입니다.', sysdate, 2);

INSERT INTO faq(faqno, title, text, Cdate, adminid)
VALUES (faq_seq.nextval, '더미데이터에요!', '안녕하세요', sysdate, 1);

INSERT INTO faq(faqno, title, text, Cdate, adminid)
VALUES (faq_seq.nextval, 'deleteTest', 'test', sysdate, 2);



select faqno, title, text, Cdate
from faq;

select faqno, title, text, Cdate
from faq
where adminid=2;

update faq
set title='updateTest', text='업데이트 본문'
where adminid=2;


delete from faq
where title='updateTest';


commit;
