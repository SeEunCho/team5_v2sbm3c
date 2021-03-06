package dev.mvc.member;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {
    @Autowired
    private MemberDAOInter memberDAO;

    public MemberProc() {
        // System.out.println("-> MemberProc created.");
    }

    @Override
    public int checkID(String id) {
        int cnt = this.memberDAO.checkID(id);
        return cnt;
    }

    @Override
    public int checkEmail(String email) {
        int cnt = this.memberDAO.checkEmail(email);
        return cnt;
    }

    @Override
    public int create(MemberVO memberVO) {
        int cnt = this.memberDAO.create(memberVO);
        return cnt;
    }

    @Override
    public List<MemberVO> list() {
        List<MemberVO> list = this.memberDAO.list();
        return list;
    }

    @Override
    public MemberVO read(int memberid) {
        MemberVO memberVO = this.memberDAO.read(memberid);
        return memberVO;
    }

    @Override
    public MemberVO readById(String id) {
        MemberVO memberVO = this.memberDAO.readById(id);
        return memberVO;
    }

    @Override
    public int update(MemberVO memberVO) {
        int cnt = this.memberDAO.update(memberVO);
        return cnt;
    }

    @Override
    public int delete(int memberid) {
        int cnt = this.memberDAO.delete(memberid);
        return cnt;
    }
    
    @Override
    public int delete_update(int memberid) {
        int cnt = this.memberDAO.delete_update(memberid);
        return cnt;
    }

    @Override
    public int passwd_check(HashMap<Object, Object> map) {
        int cnt = this.memberDAO.passwd_check(map);
        return cnt;
    }

    @Override
    public int passwd_update(HashMap<Object, Object> map) {
        int cnt = this.memberDAO.passwd_update(map);
        return cnt;
    }

    @Override
    public int login(Map<String, Object> map) {
        int cnt = this.memberDAO.login(map);
        return cnt;
    }

    @Override
    public String find_id(String email) {
        String id = this.memberDAO.find_id(email);
        return id;
    }
    
    // 인증키 생성
    @Override
    public String create_key() throws Exception {
        String key = "";
        Random rd = new Random();

        for (int i = 0; i < 8; i++) {
            key += rd.nextInt(10);
        }
        return key;
    }
    
    //이메일 인증코드 발송
    @Override
    public void emailcheck(String div, String sm_email, String auth_key) throws Exception {
        
        // Mail Server 설정
        String charSet = "utf-8";
        String hostSMTP = "smtp.gmail.com"; 
        String hostSMTPid = "team5manager0@gmail.com";
        String hostSMTPpwd = "admin54321!";

        // 보내는 사람 EMail, 제목, 내용
        String fromEmail = "team5manager0@gmail.com";
        String fromName = "team5";
        String subject = "";
        String msg = "";
        
        // 회원가입 메일 내용
        if(div.equals("join")) {
            subject = "구해줘!홈즈 회원가입 인증 메일입니다.";
            msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
            msg += "<h3 style='color: blue;'>";
            msg += "회원가입 인증번호 입니다.</h3>";
            msg += "<p>[인증번호] : ";
            msg += auth_key + "</p> <br/> 인증번호 확인란에 기입해주십시오. </div>";
        }

        // 받는 사람 E-Mail 주소
        String mail = sm_email;
        String name = sm_email;
        try {
            HtmlEmail email = new HtmlEmail();
            email.setDebug(true);
            email.setCharset(charSet);
            email.setSSL(true);
            email.setHostName(hostSMTP);
            email.setSmtpPort(465); 

            email.setAuthentication(hostSMTPid, hostSMTPpwd);
            email.setTLS(true);
            email.addTo(mail, name);
            email.setFrom(fromEmail, fromName, charSet);
            email.setSubject(subject);
            email.setHtmlMsg(msg);
            email.send();
        } catch (Exception e) {
            System.out.println("메일발송 실패 : " + e);
        }
        
    }

    
    //비밀번호 찾기 이메일발송
    @Override
    public void sendEmail(MemberVO memberVO, String div) throws Exception {
        
        // Mail Server 설정
        String charSet = "utf-8";
        String hostSMTP = "smtp.gmail.com"; 
        String hostSMTPid = "team5manager0@gmail.com";
        String hostSMTPpwd = "admin54321!";

        // 보내는 사람 EMail, 제목, 내용
        String fromEmail = "team5manager0@gmail.com";
        String fromName = "team5";
        String subject = "";
        String msg = "";
        
        // 회원가입 메일 내용
        if(div.equals("find_pw")) {
            subject = "구해줘!홈즈 임시 비밀번호 입니다.";
            msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
            msg += "<h3 style='color: blue;'>";
            msg += memberVO.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
            msg += "<p>임시 비밀번호 : ";
            msg += memberVO.getPasswd() + "</p></div>";
        }

        // 받는 사람 E-Mail 주소
        String mail = memberVO.getEmail();
        String name = memberVO.getName();
        try {
            HtmlEmail email = new HtmlEmail();
            email.setDebug(true);
            email.setCharset(charSet);
            email.setSSL(true);
            email.setHostName(hostSMTP);
            email.setSmtpPort(465); 

            email.setAuthentication(hostSMTPid, hostSMTPpwd);
            email.setTLS(true);
            email.addTo(mail, name);
            email.setFrom(fromEmail, fromName, charSet);
            email.setSubject(subject);
            email.setHtmlMsg(msg);
            email.send();
        } catch (Exception e) {
            System.out.println("메일발송 실패 : " + e);
        }
    }

    @Override
    public int search_count(HashMap<String, Object> hashMap) {
        int cnt = this.memberDAO.search_count(hashMap);
        return cnt;
    }

    
    @Override
    public List<MemberVO> list_by_search_paging(HashMap<String, Object> map) {
        /*
        페이지당 10개의 레코드 출력
        1 page: WHERE r >= 1 AND r <= 10
        2 page: WHERE r >= 11 AND r <= 20
        3 page: WHERE r >= 21 AND r <= 30
          
        페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
        1 페이지 시작 rownum: now_page = 1, (1 - 1) * 10 --> 0 
        2 페이지 시작 rownum: now_page = 2, (2 - 1) * 10 --> 10
        3 페이지 시작 rownum: now_page = 3, (3 - 1) * 10 --> 20
        */
        
        int begin_of_page = ((Integer)map.get("now_page") - 1) * Member.RECORD_PER_PAGE;
       
        // 시작 rownum 결정
        // 1 페이지 = 0 + 1: 1
        // 2 페이지 = 10 + 1: 11
        // 3 페이지 = 20 + 1: 21 
        int start_num = begin_of_page + 1;
        
        //  종료 rownum
        // 1 페이지 = 0 + 10: 10
        // 2 페이지 = 0 + 20: 20
        // 3 페이지 = 0 + 30: 30
        int end_num = begin_of_page + Member.RECORD_PER_PAGE;   
        /*
        1 페이지: WHERE r >= 1 AND r <= 10
        2 페이지: WHERE r >= 11 AND r <= 20
        3 페이지: WHERE r >= 21 AND r <= 30
        */
        map.put("start_num", start_num);
        map.put("end_num", end_num);
       
        List<MemberVO> list = this.memberDAO.list_by_search_paging(map);
       
        
        return list;
    }
    
    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param list_file 목록 파일명 
     * @param cateno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param now_page     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    
    @Override
    public String pagingBox(int search_count, int now_page, String word) {
        int total_page = (int)(Math.ceil((double)search_count/Member.RECORD_PER_PAGE)); // 전체 페이지 수 
        int total_grp = (int)(Math.ceil((double)total_page/Member.PAGE_PER_BLOCK)); // 전체 그룹  수
        int now_grp = (int)(Math.ceil((double)now_page/Member.PAGE_PER_BLOCK));  // 현재 그룹 번호
        
        // 1 group: 1, 2, 3 ... 9, 10
        // 2 group: 11, 12 ... 19, 20
        // 3 group: 21, 22 ... 29, 30
        int start_page = ((now_grp - 1) * Member.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
        int end_page = (now_grp * Member.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
         
        StringBuffer str = new StringBuffer(); 
         
        str.append("<style type='text/css'>"); 
        str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
        str.append("  #paging A:link {text-decoration:none; color: black; font-size: 1em;}"); 
        str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
        str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
        str.append("  .span_box_1{"); 
        str.append("    text-align: center;");  
        str.append("    background-color: #FFFFFF;"); 
        str.append("    color: #FFFFFF;"); 
        str.append("    font-size: 1em;"); 
        str.append("    border: 1px;"); 
        str.append("    border-style: solid;"); 
        str.append("    border-color: #95a5a6;"); 
        str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
        str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
        str.append("  }"); 
        str.append("  .span_box_2{"); 
        str.append("    text-align: center;");    
        str.append("    background-color: #2c3e50;"); 
        str.append("    color: #FFFFFF;"); 
        str.append("    font-size: 1em;"); 
        str.append("    border: 1px;"); 
        str.append("    border-style: solid;"); 
        str.append("    border-color: #2c3e50;"); 
        str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
        str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
        str.append("  }"); 
        str.append("</style>"); 
        str.append("<DIV id='paging'>"); 
//        str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
     
        // 이전 10개 페이지로 이동
        // now_grp: 1 (1 ~ 10 page)
        // now_grp: 2 (11 ~ 20 page)
        // now_grp: 3 (21 ~ 30 page) 
        // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
        // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
        int _now_page = (now_grp - 1) * Member.PAGE_PER_BLOCK;  
        if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 페이지수가 11페이 이상임으로 이전 그룹으로 갈수 있는 링크 생성 
          str.append("<span class='span_box_1'><A href='"+Member.LIST_FILE+"?&word="+word+"&now_page="+_now_page+"'>이전</A></span>"); 
        } 
     
        // 중앙의 페이지 목록
        for(int i=start_page; i<=end_page; i++){ 
          if (i > total_page){ // 마지막 페이지를 넘어갔다면 페이 출력 종료
            break; 
          } 
      
          if (now_page == i){ // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
            str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
          }else{
            // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
            str.append("<span class='span_box_1'><A href='"+Member.LIST_FILE+"?word="+word+"&now_page="+i+"'>"+i+"</A></span>");   
          } 
        } 
     
        // 10개 다음 페이지로 이동
        // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
        // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
        // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
        // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
        _now_page = (now_grp * Member.PAGE_PER_BLOCK)+1; //  최대 페이지수 + 1 
        if (now_grp < total_grp){ 
          str.append("<span class='span_box_1'><A href='"+Member.LIST_FILE+"?&word="+word+"&now_page="+_now_page+"'>다음</A></span>"); 
        } 
        str.append("</DIV>"); 
         
        return str.toString(); 
    }

    

    
}
