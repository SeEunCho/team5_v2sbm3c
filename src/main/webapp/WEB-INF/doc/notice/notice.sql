/**********************************/
/* Table Name: 공지사항 */
/**********************************/

DROP TABLE notice CASCADE CONSTRAINTS;
CREATE TABLE notice(
<<<<<<< Updated upstream
  noticeno            NUMERIC(10)   NOT NULL    PRIMARY KEY,
  adminid            NUMERIC(10)   NOT NULL,
  noticetitle         VARCHAR(50)   NOT NULL,
  noticecontent       VARCHAR(225)   NOT NULL, 
  rdate               DATE   NOT NULL,
    FOREIGN KEY (adminid) REFERENCES admin (adminid)
=======
  noticeno            NUMBER(10)   NOT NULL    PRIMARY KEY,
  adminid            NUMBER(10)   NOT NULL,
  noticetitle         VARCHAR(50)   NOT NULL,
  noticecontent       VARCHAR(225)   NOT NULL, 
  rdate               DATE   NOT NULL,
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
>>>>>>> Stashed changes
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
  
<<<<<<< Updated upstream
INSERT INTO notice(noticeno,adminid, noticetitle, noticecontent, rdate)
VALUES(notice_seq.nextval, 1,'notice1', 'content1', sysdate);
=======
SELECT * FROM ADMIN;  
   ADMINID ID                   PASSWD                                            
---------- -------------------- --------------------------------------------------
         1 admin1               1234                                              
         2 admin2               1234                                              
         3 admin3               1234                                              
>>>>>>> Stashed changes

  
INSERT INTO notice(noticeno, adminid, noticetitle, noticecontent, rdate)
VALUES(notice_seq.nextval, 1, 'notice1', 'content1', sysdate);

SELECT noticeno, adminid, noticetitle, noticecontent, rdate 
FROM notice 
ORDER BY noticeno DESC;
COMMIT;

SELECT noticeno, adminid, noticetitle, noticecontent, rdate 
FROM notice 
WHERE noticeno=2;

UPDATE notice
SET noticetitle='공지사항1', noticecontent='내용1', rdate=sysdate
WHERE noticeno=2;
COMMIT;

DELETE FROM notice
<<<<<<< Updated upstream
WHERE noticetitle='공지사항1';

commit;
=======
WHERE noticeno=2;
COMMIT;
>>>>>>> Stashed changes
