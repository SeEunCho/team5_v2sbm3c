package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public interface MemberProcInter {
    /**
     * 중복 아이디 검사
     * @param id
     * @return 중복 아이디 갯수
     */
    public int checkID(String id);
    
    /**
     * 중복 이메일 검사
     * @param email
     * @return 중복 이메일 갯수
     */
    public int checkEmail(String email);
    
    /**
     * 회원 가입
     * @param memberVO
     * @return
     */
    public int create(MemberVO memberVO);
    
    /**
     * 회원 전체 목록
     * @return
     */
    public List<MemberVO> list();
    
    /**
     * memberid로 회원 정보 조회
     * @param memberid
     * @return
     */
    public MemberVO read(int memberid);
    
    /**
     * id로 회원 정보 조회
     * @param id
     * @return
     */
    public MemberVO readById(String id);
    
    /**
     * 수정 처리
     * @param memberVO
     * @return
     */
    public int update(MemberVO memberVO);
    
    /**
     * 회원 삭제 처리
     * @param memberid
     * @return
     */
    public int delete(int memberid);
    
    /**
     * 회원 삭제_update
     * @param memberid
     * @return
     */
    public int delete_update(int memberid);
    
    /**
     * 현재 패스워드 검사
     * @param map
     * @return 0: 일치하지 않음, 1: 일치함
     */
    public int passwd_check(HashMap<Object, Object> map);
    
    /**
     * 패스워드 변경
     * @param map
     * @return 변경된 패스워드 갯수
     */
    public int passwd_update(HashMap<Object, Object> map);
    
    /**
     * 로그인 처리
     */
    public int login(Map<String, Object> map);
    
    /**
     * 아이디 찾기
     */
    public String find_id(String email);
    
    /**
     * 인증키생성
     */
    public String create_key() throws Exception;
    
    /**
     * 이메일 인증코드 발송
     */
    public void emailcheck(String div, String sm_email, String auth_key) throws Exception;
    
    /**
     * 이메일발송
     */
    public void sendEmail(MemberVO vo, String div) throws Exception;
    
    /**
     * 검색 레코드 갯수
     */
    public int search_count(HashMap<String, Object> hashMap);
    
    /**
     * 검색 + 페이징 목록
     */
    public List<MemberVO> list_by_search_paging(HashMap<String, Object> map);
    
    /**
     * 페이지 목록 문자열 생성, Box 형태
     * @param search_count 검색 갯수
     * @param now_page 현재 페이지, now_page는 1부터 시작
     * @param word 검색어
     * @return
     */
    public String pagingBox(int search_count, int now_page, String word);


    
}
