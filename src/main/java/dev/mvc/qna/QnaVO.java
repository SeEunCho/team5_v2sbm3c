package dev.mvc.qna;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class QnaVO {
    
    private int qnano;
    private String title = ""; // for avoiding NPE
    private String secret = "";
    private String text = ""; 
    private String qdate = ""; 
    private int qcateno;
    private int memberid; // FK needed when insert to DB ****
    
    // 추후 주택 데이터의 사용 여부에 따라 houseno pk까지 포함하여 개발 할수도 있음.
    
    public QnaVO(int qnano, String title, String secret, String text, String qdate, int qcateno, int memberid) {
        this.qnano = qnano;
        this.title = title;
        this.secret = secret;
        this.text = text;
        this.qdate = qdate;
        this.qcateno = qcateno;
        this.memberid = memberid;
    }
    
    // java bean 규약 따르기
    public QnaVO () {
        
    }
    
    
}
