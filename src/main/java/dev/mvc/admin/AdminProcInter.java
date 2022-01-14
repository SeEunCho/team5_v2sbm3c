package dev.mvc.admin;

import java.util.Map;

public interface AdminProcInter {
    
    /**
     * 로그인 처리
     */
    public int login(Map<String, Object> map);
    

    /**
     * id로 회원 정보 조회
     */
    public AdminVO readById(String id);
}
