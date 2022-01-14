/**********************************/
/* Table Name: 공지사항 */
/**********************************/

DROP TABLE notice CASCADE CONSTRAINTS;
CREATE TABLE notice(
  noticeno            NUMERIC(10)   NOT NULL    PRIMARY KEY,
  adminid            NUMERIC(10)   NOT NULL,
  noticetitle         VARCHAR(50)   NOT NULL,
  noticecontent       VARCHAR(225)   NOT NULL, 
  rdate               DATE   NOT NULL,
    FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

COMMENT ON TABLE notice is '공지사항';
COMMENT ON COLUMN notice.noticeno is '공지사항 번호';
COMMENT ON COLUMN notice.adminid is '관리자 번호';
COMMENT ON COLUMN notice.noticetitle is '공지사항 제목';
COMMENT ON COLUMN notice.noticecontent is '공지사항 내용';
COMMENT ON COLUMN notice.rdate is '날짜';

DROP SEQUENCE notice_seq;
CREATE SEQUENCE notice_seq
  START WITH 1                   
  MAXVALUE 99999
  MINVALUE 0
  NOCACHE                     
  NOCYCLE;         
  
INSERT INTO notice(noticeno,adminid, noticetitle, noticecontent, rdate)
VALUES(notice_seq.nextval, 1,'notice1', 'content1', sysdate);

SELECT noticeno, noticetitle, noticecontent, rdate FROM notice ORDER BY noticeno DESC;

UPDATE notice
SET noticetitle='공지사항1'
WHERE noticetitle='notice1';

DELETE FROM notice
WHERE noticetitle='공지사항1';

commit;