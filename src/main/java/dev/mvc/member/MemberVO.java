package dev.mvc.member;

import lombok.Data;

/*
    memberid NUMBER(10) NOT NULL,
    id        VARCHAR(20)   NOT NULL UNIQUE,
    passwd    VARCHAR(50)   NOT NULL, 
    name      VARCHAR(30)   NOT NULL, 
    phone     VARCHAR(20)   NOT NULL, 
    email     VARCHAR(80)   NOT NULL UNIQUE,
    address   VARCHAR(150)  NULL, 
    grade     NUMBER(3)     NOT NULL,
    PRIMARY KEY (memberid)
*/

@Data
public class MemberVO {
    
    private int memberid;
    private String id = "";
    private String passwd = "";
    private String name = "";
    private String phone = "";
    private String email = "";
    private String address = "";
    private int grade = 1;
   
}
