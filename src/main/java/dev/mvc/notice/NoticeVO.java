package dev.mvc.notice;

import java.util.Date;
import lombok.Data;

/*
CREATE TABLE notice(
  noticeno            NUMBER(10)   NOT NULL    PRIMARY KEY,
  adminid            NUMBER(10)   NOT NULL,
  noticetitle         VARCHAR(50)   NOT NULL,
  noticecontent       VARCHAR(225)   NOT NULL, 
  rdate               DATE   NOT NULL,
  FOREIGN KEY (adminid) REFERENCES admin (adminid)
);
 */

//@Data
public class NoticeVO {
	/** 공지사항 번호 */
	private int noticeno;
	/** 관리자 번호 */
	private int adminid;
	/** 공지사항 제목 */
	private String noticetitle;
	/** 공지사항 내용 */
	private String noticecontent;
	/** 날짜 */
	private String rdate;

	public int getNoticeno() {
		return noticeno;
	}

	public void setNoticeno(int noticeno) {
		this.noticeno = noticeno;
	}

	public int getAdminid() {
		return adminid;
	}

	public void setAdminid(int adminid) {
		this.adminid = adminid;
	}

	public String getNoticetitle() {
		return noticetitle;
	}

	public void setNoticetitle(String noticetitle) {
		this.noticetitle = noticetitle;
	}

	public String getNoticecontent() {
		return noticecontent;
	}

	public void setNoticecontent(String noticecontent) {
		this.noticecontent = noticecontent;
	}

    public String getRdate() {
        return rdate;
    }

    public void setRdate(String rdate) {
        this.rdate = rdate;
    }

	

}
