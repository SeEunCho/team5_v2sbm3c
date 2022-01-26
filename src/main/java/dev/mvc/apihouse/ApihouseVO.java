package dev.mvc.apihouse;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ApihouseVO {
    
    private int houseno;
    private String rcode;
    private String name; // OO동 OOOO아파트
    private String area;
    private String amount;
    private String year;
    private String cyear; // 건축년도(year: 거래년도)
    private String month;
    private String lat; // 위도
    private String lon; // 경도
    
    public ApihouseVO () {
        
    }


}
