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