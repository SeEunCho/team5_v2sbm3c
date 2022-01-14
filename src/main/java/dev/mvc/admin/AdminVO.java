package dev.mvc.admin;

import lombok.Data;
    
/*  
    adminid         NUMBER(10)     NOT NULL PRIMARY KEY,
    id              VARCHAR2(20)   NOT NULL UNIQUE,
    passwd          VARCHAR(50)    NOT NULL
*/

@Data
public class AdminVO {

    private int adminid;
    private String id = "";
    private String passwd = "";

}
