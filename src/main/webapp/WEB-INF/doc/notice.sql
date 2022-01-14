/**********************************/
/* Table Name: 공지사항 */
/**********************************/
CREATE TABLE notice(
		noticeno NUMERIC(10) NOT NULL PRIMARY KEY,
		memberid NUMERIC(30) NOT NULL,
		adminid NUMERIC(10) NOT NULL,
  FOREIGN KEY (memberid) REFERENCES member (memberid),
  FOREIGN KEY (adminid) REFERENCES Admin (adminid)
);