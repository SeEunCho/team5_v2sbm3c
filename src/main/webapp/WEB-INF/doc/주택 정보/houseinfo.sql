/**********************************/
/* Table Name: 주택 정보 */
/**********************************/
DROP TABLE house;
DROP TABLE house CASCADE CONSTRAINTS;
CREATE TABLE house(
		houseno NUMERIC(10) NOT NULL PRIMARY KEY,
		nomination VARCHAR(30) NOT NULL,
		area VARCHAR(30) NOT NULL,
		terrain VARCHAR(30),
		price INT NOT NULL,
		hdate DATE NOT NULL,
		likes INT NOT NULL,
		himage VARCHAR(100) ,
		loca VARCHAR(100) NOT NULL,
		adminid NUMERIC(10),
		hname VARCHAR(100) NOT NULL,
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

COMMENT ON TABLE house is '주택 정보';
COMMENT ON COLUMN house.houseno is '주택 정보 번호';
COMMENT ON COLUMN house.nomination is '지목';
COMMENT ON COLUMN house.area is '면적';
COMMENT ON COLUMN house.terrain is '지세';
COMMENT ON COLUMN house.price is '토지면적당 단가';
COMMENT ON COLUMN house.hdate is '매물등록일';
COMMENT ON COLUMN house.likes is '좋아요';
COMMENT ON COLUMN house.himage is '주택 사진';
COMMENT ON COLUMN house.loca is '주택 위치';
COMMENT ON COLUMN house.adminid is '관리자 번호';
COMMENT ON COLUMN house.hname is '주택 명';

DROP SEQUENCE house_seq;
CREATE SEQUENCE house_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999    -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지
  
commit;

-- 개인 회원 테스트 계정
INSERT INTO house(houseno, nomination, area, terrain, price, hdate, likes, loca,  hname)
VALUES (house_seq.nextval, '대', '396.9㎡', '평지', '1800000000', sysdate, 1, '서울특별시 중구 만리동1가 35-5' ,  '단독다가구');
INSERT INTO house(houseno, nomination, area, terrain, price, hdate, likes, loca,  hname)
VALUES (house_seq.nextval, '대', '203.2㎡', '평지', '1537500000', sysdate, 1, '서울특별시 중구 만리동1가 53-2' ,  '상업업무');
INSERT INTO house(houseno, nomination, area, terrain, price, hdate, likes, loca,  hname)
VALUES (house_seq.nextval, '대', '68.1㎡', '평지', '510000000', sysdate, 1, '서울특별시 중구 중림동 324-1' ,  '상업업무');

-- 조회
SELECT houseno, likes, adminid, hname
FROM house
ORDER BY houseno ASC;

SELECT houseno, likes, adminid, hname
FROM house
WHERE houseno = 1;

-- 수정
UPDATE house
SET nomination='전', hname='토지'
WHERE houseno=1;

-- 삭제
DELETE FROM house
WHERE houseno=39;

