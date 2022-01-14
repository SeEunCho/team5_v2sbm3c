/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE gory;
DROP TABLE gory CASCADE CONSTRAINTS;
CREATE TABLE gory(
		goryno NUMERIC(10) NOT NULL PRIMARY KEY,
		groupno NUMERIC(10) NOT NULL,
		hname VARCHAR(30) NOT NULL,
		houseno NUMERIC(10) NOT NULL,
		notice VARCHAR(100) NOT NULL,
		hlocation VARCHAR(50) NOT NULL,
		noticeno NUMERIC(10) NOT NULL,
  FOREIGN KEY (groupno) REFERENCES hgroup (groupno),
  FOREIGN KEY (noticeno) REFERENCES notice (noticeno)
);

COMMENT ON TABLE gory is '카테고리';
COMMENT ON COLUMN gory.goryno is '카테고리 번호';
COMMENT ON COLUMN gory.groupno is '카테고리 그룹 번호';
COMMENT ON COLUMN gory.hname is '카테고리 이름';
COMMENT ON COLUMN gory.houseno is '주택 정보 번호';
COMMENT ON COLUMN gory.notice is '공지사항';
COMMENT ON COLUMN gory.hlocation is '위치검색';
COMMENT ON COLUMN gory.noticeno is '공지사항 번호';