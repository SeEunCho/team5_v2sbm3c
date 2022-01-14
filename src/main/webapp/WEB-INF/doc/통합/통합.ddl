/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		memberid NUMERIC(10) DEFAULT 1 NOT NULL IDENTITY PRIMARY KEY,
		id VARCHAR(20) NOT NULL,
		passwd VARCHAR(50) NOT NULL,
		name VARCHAR(30) NOT NULL,
		phone VARCHAR(20) NOT NULL,
		email VARCHAR(80) NOT NULL,
		address VARCHAR(150) NOT NULL
);

/**********************************/
/* Table Name: 관리자 */
/**********************************/
CREATE TABLE admin(
		adminid NUMERIC(10) DEFAULT 1 NOT NULL IDENTITY PRIMARY KEY,
		id VARCHAR(20) NOT NULL,
		passwd VARCHAR(50) NOT NULL
);

/**********************************/
/* Table Name: 질문 카테고리 */
/**********************************/
CREATE TABLE qna_cate(
		qcateno NUMERIC(10) DEFAULT 1 NOT NULL IDENTITY PRIMARY KEY,
		name VARCHAR(20) NOT NULL,
		memberid NUMERIC(10),
		adminid NUMERIC(10) NOT NULL,
  FOREIGN KEY (memberid) REFERENCES member (memberid),
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

/**********************************/
/* Table Name: 질문 */
/**********************************/
CREATE TABLE qnA(
		qnano NUMERIC(10) DEFAULT 1 NOT NULL IDENTITY PRIMARY KEY,
		title VARCHAR(30) NOT NULL,
		secret CHAR(1) DEFAULT N NOT NULL,
		text VARCHAR(500) NOT NULL,
		qdate DATE NOT NULL,
		qcateno NUMERIC(10) NOT NULL,
  FOREIGN KEY (qcateno) REFERENCES qna_cate (qcateno)
);

/**********************************/
/* Table Name: 주택정보 */
/**********************************/
CREATE TABLE house(
		houseno NUMERIC(10) NOT NULL PRIMARY KEY,
		nomination VARCHAR(30) NOT NULL,
		area VARCHAR(10) NOT NULL,
		terrain VARCHAR(30),
		price INT NOT NULL,
		hdate DATE NOT NULL,
		likes INT NOT NULL,
		himage VARCHAR(100) NOT NULL,
		loca VARCHAR(100) NOT NULL,
		adminid NUMERIC(10) NOT NULL,
		hname VARCHAR(100) NOT NULL,
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

/**********************************/
/* Table Name: 공지사항 */
/**********************************/
CREATE TABLE notice(
		noticeno NUMERIC(10) NOT NULL PRIMARY KEY,
		memberid NUMERIC(30) NOT NULL,
		adminid NUMERIC(10) NOT NULL,
		noticecontent VARCHAR(225) NOT NULL,
		rdate DATE NOT NULL,
		noticetitle VARCHAR(50) NOT NULL,
  FOREIGN KEY (memberid) REFERENCES member (memberid),
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

/**********************************/
/* Table Name: 답변 */
/**********************************/
CREATE TABLE answer(
		answerno NUMERIC(10) NOT NULL PRIMARY KEY,
		qnano NUMERIC(10) NOT NULL,
		adminid NUMERIC(10) NOT NULL,
		answer VARCHAR(500),
  FOREIGN KEY (qnano) REFERENCES qnA (qnano),
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

/**********************************/
/* Table Name: 추천 */
/**********************************/
CREATE TABLE reco(
		recono NUMERIC(10) NOT NULL PRIMARY KEY,
		memberid NUMERIC(10) NOT NULL,
		houseno NUMERIC(10) NOT NULL,
  FOREIGN KEY (houseno) REFERENCES house (houseno),
  FOREIGN KEY (memberid) REFERENCES member (memberid)
);

/**********************************/
/* Table Name: 자주묻는질문(FAQ) */
/**********************************/
CREATE TABLE faq(
		faqno NUMERIC(10) NOT NULL PRIMARY KEY,
		title VARCHAR(50) NOT NULL,
		text VARCHAR(500) NOT NULL,
		Cdate DATE NOT NULL,
		adminid NUMERIC(10),
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);

