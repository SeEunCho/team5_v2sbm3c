package dev.mvc.qnacate;

import org.springframework.beans.factory.annotation.Value;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class QnacateVO {
    
    private int qcateno;
    private String name = ""; // for avoiding NPE
    private int adminid;
        
    public QnacateVO(int qcateno, String name, int adminid) {
        this.qcateno = qcateno;
        this.name = name;
        this.adminid = adminid;
    }
    
    public QnacateVO() {
        
    }

}
