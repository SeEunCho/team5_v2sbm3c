package dev.mvc.answer;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class AnswerVO {
    
    private int answerno;
    private int qnano;
    private int adminid;
    private String answer = ""; // avoiding NPE
    private String adate = "";
    
    // 답변일자, 답변본문, 
    
    
    public AnswerVO(int answerno, int qnano, int adminid, String answer, String adate) {
        this.answerno = answerno;
        this.qnano = qnano;
        this.adminid = adminid;
        this.answer = answer;
        this.adate = adate;
    }
    
    // java Bean default constructor
    public AnswerVO() {
        
    }
    
}
