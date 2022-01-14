/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member (
  memberid NUMBER(10) NOT NULL,
  id             VARCHAR(20)   NOT NULL UNIQUE,
  passwd      VARCHAR(50)   NOT NULL, 
  name      VARCHAR(30)   NOT NULL, 
  phone     VARCHAR(20)   NOT NULL, 
  email     VARCHAR(80)   NOT NULL UNIQUE, 
  address   VARCHAR(150)    NULL, 
  grade        NUMBER(3)     NOT NULL,
  PRIMARY KEY (memberid)
);
 
COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.memberid is '회원 번호';
COMMENT ON COLUMN MEMBER.ID is '아이디';
COMMENT ON COLUMN MEMBER.PASSWD is '패스워드';
COMMENT ON COLUMN MEMBER.NAME is '성명';
COMMENT ON COLUMN MEMBER.phone is '전화번호';
COMMENT ON COLUMN MEMBER.email is '이메일';
COMMENT ON COLUMN MEMBER.ADDRESS is '주소';
COMMENT ON COLUMN MEMBER.GRADE is '등급';


DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1             
  INCREMENT BY 1         
  MAXVALUE 9999999999 
  CACHE 2                     
  NOCYCLE;     

-- 개인 회원 테스트 계정
INSERT INTO member(memberid, id, passwd, name, phone, email, address, grade)
VALUES (member_seq.nextval, 'user1', '1234', 'user1', '010-1234-5678', 'user1@user.com', '서울시 종로구', 10);
INSERT INTO member(memberid, id, passwd, name, phone, email, address, grade)
VALUES (member_seq.nextval, 'user2', '1234', 'user2', '010-1234-5678', 'user2@user.com', '서울시 종로구', 10);
INSERT INTO member(memberid, id, passwd, name, phone, email, address, grade)
VALUES (member_seq.nextval, 'user3', '1234', 'user3', '010-1234-5678', 'user3@user.com', '서울시 종로구', 10);

-- 조회
SELECT memberid, id, passwd, name, phone, email, address, grade
FROM member
ORDER BY memberid ASC;

SELECT memberid, id, passwd, name, phone, email, address, grade
FROM member
WHERE memberid = 1;

-- 수정
UPDATE member
SET name='user11', email='user11@user.com'
WHERE memberid=1;

-- 삭제
DELETE FROM member
WHERE memberid=1;

commit;