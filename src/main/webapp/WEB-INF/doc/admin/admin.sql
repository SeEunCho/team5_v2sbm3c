/**********************************/
/* Table Name: 관리자 */
/**********************************/
DROP TABLE admin CASCADE CONSTRAINTS;
CREATE TABLE admin(
    adminid         NUMBER(10)     NOT NULL    PRIMARY KEY,
    ID                   VARCHAR2(20)     NOT NULL,
    passwd      VARCHAR(50)   NOT NULL
);

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.adminid is '관리자 번호';
COMMENT ON COLUMN admin.ID is '아이디';
COMMENT ON COLUMN admin.passwd is '패스워드';

DROP SEQUENCE admin_seq;
CREATE SEQUENCE admin_seq
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 9999999999
  CACHE 2
  NOCYCLE;

-- 관리자 테스트 계정
INSERT INTO admin(adminid, id, passwd)
VALUES(admin_seq.nextval, 'admin1', '1234');

INSERT INTO admin(adminid, id, passwd)
VALUES(admin_seq.nextval, 'admin2', '1234');

INSERT INTO admin(adminid, id, passwd)
VALUES(admin_seq.nextval, 'admin3', '1234');

-- 조회
SELECT adminid, id, passwd FROM admin ORDER BY adminid ASC;

-- 수정
UPDATE admin
SET id='admin11'
WHERE adminid=1;

-- 삭제
DELETE FROM admin
WHERE adminid=2;

commit;