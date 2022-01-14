/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
DROP TABLE  hgroup;
DROP TABLE  hgroup CASCADE CONSTRAINTS;
CREATE TABLE hgroup(
		groupno NUMERIC(10) NOT NULL PRIMARY KEY,
		grpname VARCHAR(50) NOT NULL,
		goryno NUMERIC(10)
);

COMMENT ON TABLE hgroup is '카테고리 그룹';
COMMENT ON COLUMN hgroup.groupno is '카테고리 그룹 번호';
COMMENT ON COLUMN hgroup.grpname is '이름';
COMMENT ON COLUMN hgroup.goryno is '카테고리 번호';