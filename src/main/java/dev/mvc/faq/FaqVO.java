package dev.mvc.faq;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class FaqVO {
    
    private int faqno;
 
    // adding validation constraints
    @NotNull(message = "title is null.")
    @NotEmpty(message = "title is empty")
    private String title;
    
    @NotNull(message = "text is null.")
    @NotEmpty(message = "text is empty")
    private String text;
    private String cdate;
    private int adminid;

    public FaqVO() {
        
    }
    
    public FaqVO(int faqno, @NotNull(message = "title is null.") @NotEmpty(message = "title is empty") String title,
            @NotNull(message = "text is null.") @NotEmpty(message = "text is empty") String text, String cdate,
            int adminid) {
        this.faqno = faqno;
        this.title = title;
        this.text = text;
        this.cdate = cdate;
        this.adminid = adminid;
    }
    
}
