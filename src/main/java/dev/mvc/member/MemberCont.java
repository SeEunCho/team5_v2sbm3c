package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MemberCont {
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc = null;

    public MemberCont() {
        // System.out.println("-> MemberCont created.");
    }
    
    // http://localhost:9091/member/checkEmail.do?email=user1@user.com
    /**
     * Email 중복 체크, JSON 출력
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/member/checkEmail.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
    public String checkEmail(String email) {
        int cnt = this.memberProc.checkEmail(email);
 
        JSONObject json = new JSONObject();
        json.put("cnt", cnt);

        return json.toString();
    }

    // http://localhost:9091/member/checkID.do?id=user1
    /**
     * ID 중복 체크, JSON 출력
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/member/checkID.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
    public String checkID(String id) {
        int cnt = this.memberProc.checkID(id);

        JSONObject json = new JSONObject();
        json.put("cnt", cnt);

        return json.toString();
    }
    
    
    // http://localhost:9091/member/create.do
    /**
     * 등록 폼
     * 
     * @return
     */
    @RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
    public ModelAndView create() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/member/create"); // webapp/member/create.jsp

        return mav; // forward
    }
    
    /**
     * 등록 처리
     * @param memberVO
     * @return
     */
    @RequestMapping(value="/member/create.do", method=RequestMethod.POST)
    public ModelAndView create(MemberVO memberVO){
      ModelAndView mav = new ModelAndView();
      
      // System.out.println(memberVO.toString());
      // System.out.println("id: " + memberVO.getId());
      
      memberVO.setGrade(1); // 기본 회원 가입 등록 1 지정
      
      int cnt= memberProc.create(memberVO);
      
      if (cnt == 1) {
        mav.addObject("code", "create_success");
        mav.addObject("name", memberVO.getName());  // 홍길동님(user4) 회원 가입을 축하합니다.
        mav.addObject("id", memberVO.getId());
      } else {
        mav.addObject("code", "create_fail");
      }
      
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
      mav.addObject("url", "/member/msg");  // /member/msg -> /member/msg.jsp
      
      mav.setViewName("redirect:/member/msg.do");

      // mav.addObject("code", "create_fail"); // 가입 실패 test용
      // mav.addObject("cnt", 0);              // 가입 실패 test용
      
      return mav;
    }
    
    /**
     * 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/member/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward
      
      return mav; // forward
    }
    
//    /**
//     * 목록 출력 가능
//     * @param session
//     * @return
//     */
//     @RequestMapping(value="/member/list.do", method=RequestMethod.GET)
//     public ModelAndView list() {
//       ModelAndView mav = new ModelAndView();
//       
//       List<MemberVO> list = memberProc.list();
//       mav.addObject("list", list);
//
//       mav.setViewName("/member/list"); // /webapp/WEB-INF/views/member/list.jsp
//       
//       return mav;
//     } 
     
     /**
      * 회원 조회
      * @param memberid
      * @return
      */
     @RequestMapping(value="/member/read.do", method=RequestMethod.GET)
     public ModelAndView read(int memberid, HttpSession session){
       ModelAndView mav = new ModelAndView();
       boolean admin_flag = (boolean)session.getAttribute("admin_flag");
       //int grade = (int)session.getAttribute("grade");
       //System.out.println("-->"+grade);
       
       MemberVO memberVO = this.memberProc.read(memberid);
       mav.addObject("memberVO", memberVO);
       if (admin_flag) {
           mav.addObject("title", "회원정보");
           mav.addObject("admin_flag", true);
       } else{
           mav.addObject("title", "My Page");
           mav.addObject("admin_flag", false);
       }
       
       mav.setViewName("/member/read"); // /member/read.jsp
       
       return mav;
     }
     
     /**
      * 회원 정보 수정 처리
      * @param memberVO
      * @return
      */
     @RequestMapping(value="/member/update.do", method=RequestMethod.POST)
     public ModelAndView update(MemberVO memberVO){
       ModelAndView mav = new ModelAndView();
       
       int cnt= memberProc.update(memberVO);
       
       if (cnt == 1) {
         mav.addObject("code", "update_success");
         mav.addObject("name", memberVO.getName());  // 홍길동님(user4) 회원 정보를 변경했습니다.
         mav.addObject("id", memberVO.getId());
       } else {
         mav.addObject("code", "update_fail");
       }

       mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
       mav.addObject("url", "/member/msg");  // /member/msg.jsp
       
       mav.setViewName("redirect:/member/msg.do");
       
       return mav;
     }
     
     /**
      * 회원 삭제
      * @param memberid
      * @return
      */
     @RequestMapping(value="/member/delete.do", method=RequestMethod.GET)
     public ModelAndView delete(int memberid, HttpSession session){
       ModelAndView mav = new ModelAndView();
       boolean admin_flag = (boolean)session.getAttribute("admin_flag");
       
       if (admin_flag) {
           mav.addObject("title", "회원삭제");
       } else{
           mav.addObject("title", "회원탈퇴");
       }
       
       MemberVO memberVO = this.memberProc.read(memberid);
       mav.addObject("memberVO", memberVO);
       mav.setViewName("/member/delete"); // /member/delete.jsp
       
       return mav; // forward
     }
     
     /**
      * 회원 삭제 처리
      * @param memberVO
      * @return
      */
     @RequestMapping(value="/member/delete.do", method=RequestMethod.POST)
     public ModelAndView delete_proc(int memberid){
       ModelAndView mav = new ModelAndView();
       // System.out.println("id: " + memberVO.getId());
       MemberVO memberVO = this.memberProc.read(memberid);
       
       // int cnt= memberProc.delete(memberid); // 삭제
       int cnt= memberProc.delete_update(memberid); // grade 99로 변경
       
       if (cnt == 1) {
         mav.addObject("code", "delete_success");
         mav.addObject("name", memberVO.getName());  // 홍길동님(user4) 회원 정보를 변경했습니다.
         mav.addObject("id", memberVO.getId());
       } else {
         mav.addObject("code", "delete_fail");
       }

       mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
       mav.addObject("url", "/member/msg");  // /member/msg.jsp
       
       mav.setViewName("redirect:/member/msg.do");
       
       return mav;
       
     }
     
     /**
      * 패스워드 변경
      * @param memberid
      * @return
      */
     @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.GET)
     public ModelAndView passwd_update(int memberid){
       ModelAndView mav = new ModelAndView();
       
       MemberVO memberVO = this.memberProc.read(memberid);
       mav.addObject("name", memberVO.getName());
       mav.setViewName("/member/passwd_update"); // passwd_update.jsp
       
       return mav;
     }
     
     /**
      * 패스워드 변경 처리
      * @param memberid 회원 번호
      * @param current_passwd 현재 패스워드
      * @param new_passwd 새로운 패스워드
      * @return
      */
     @RequestMapping(value="/member/passwd_update.do", method=RequestMethod.POST)
     public ModelAndView passwd_update(int memberid, String current_passwd, String new_passwd){
       ModelAndView mav = new ModelAndView();
       
       MemberVO memberVO = this.memberProc.read(memberid);
       mav.addObject("name", memberVO.getName());  // 홍길동님(user4) 패스워드를 변경했습니다.
       mav.addObject("id", memberVO.getId());
       
       // 현재 패스워드 검사
       HashMap<Object, Object> map = new HashMap<Object, Object>();
       map.put("memberid", memberid);
       map.put("passwd", current_passwd);
       
       int cnt = memberProc.passwd_check(map);
       int update_cnt = 0; // 변경된 패스워드 수
       
       if (cnt == 1) { // 현재 패스워드가 일치하는 경우
         map.put("passwd", new_passwd); // 새로운 패스워드를 저장
         
         update_cnt = memberProc.passwd_update(map); // 패스워드 변경 처리
         
         if (update_cnt == 1) {
           mav.addObject("code", "passwd_update_success"); // 패스워드 변경 성공
         } else {
           cnt = 0;  // 패스워드는 일치했으나 변경하지는 못함.
           mav.addObject("code", "passwd_update_fail");       // 패스워드 변경 실패
         }
         
         mav.addObject("update_cnt", update_cnt);  // 변경된 패스워드의 갯수    
       } else {
         mav.addObject("code", "passwd_fail"); // 패스워드가 일치하지 않는 경우
       }

       mav.addObject("cnt", cnt); // 패스워드 일치 여부
       mav.addObject("url", "/member/msg");  // /member/msg -> /member/msg.jsp
       
       mav.setViewName("redirect:/member/msg.do");
       
       return mav;
     }
     
//     /**
//      * 로그인 폼
//      * @return
//      */
//     // http://localhost:9091/member/login.do 
//     @RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
//     public ModelAndView login() {
//       ModelAndView mav = new ModelAndView();
//     
//       mav.setViewName("/member/login_form");
//       return mav;
//     }
//     
//     /**
//      * 로그인 처리
//      * @return
//      */
//     // http://localhost:9091/member/login.do 
//     @RequestMapping(value = "/member/login.do", 
//                                method = RequestMethod.POST)
//     public ModelAndView login_proc(HttpSession session, String id, String passwd) {
//       ModelAndView mav = new ModelAndView();
//       Map<String, Object> map = new HashMap<String, Object>();
//       map.put("id", id);
//       map.put("passwd", passwd);
//       
//       int count = memberProc.login(map); // id, passwd 일치 여부 확인
//       if (count == 1) { // 로그인 성공
//         // System.out.println(id + " 로그인 성공");
//         MemberVO memberVO = memberProc.readById(id); // 로그인한 회원의 정보 조회
//         session.setAttribute("memberno", memberVO.getMemberid());
//         session.setAttribute("id", id);
//         session.setAttribute("name", memberVO.getName());
//         
//         mav.setViewName("redirect:/index.do"); // 시작 페이지로 이동  
//       } else {
//         mav.addObject("url", "/member/login_fail_msg"); // login_fail_msg.jsp, redirect parameter 적용
//        
//         mav.setViewName("redirect:/member/msg.do"); // 새로고침 방지
//       }
//           
//       return mav;
//     }
     
     /**
      * 로그인 폼
      * @return
      */
     // http://localhost:9091/member/login.do 
     @RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
     public ModelAndView login_cookie(HttpServletRequest request,
                                     @RequestParam(value="return_url", defaultValue="") String return_url) {
       ModelAndView mav = new ModelAndView();
       
       Cookie[] cookies = request.getCookies();
       Cookie cookie = null;

       String ck_id = ""; // id 저장
       String ck_passwd = ""; // passwd 저장
       String ck_id_passwd_save = ""; // id,passwd 저장 여부를 체크

       if (cookies != null) {
         for (int i=0; i < cookies.length; i++){
           cookie = cookies[i]; // 쿠키 객체 추출
           
           if (cookie.getName().equals("ck_id")){
             ck_id = cookie.getValue(); 
           }else if (cookie.getName().equals("ck_passwd")){
             ck_passwd = cookie.getValue();         // 1234
           }else if(cookie.getName().equals("ck_id_passwd_save")){
             ck_id_passwd_save = cookie.getValue();  // Y, N
           }
         }
       }
       
       mav.addObject("ck_id", ck_id); 
       mav.addObject("ck_passwd", ck_passwd);
       mav.addObject("ck_id_passwd_save", ck_id_passwd_save);
       
       mav.addObject("return_url", return_url);
       
       mav.setViewName("/member/login_ck_form");
       return mav;
     }
      
     
     /**
      * Cookie 기반 로그인 처리
      * @param request Cookie를 읽기위해 필요
      * @param response Cookie를 쓰기위해 필요
      * @param session 로그인 정보를 메모리에 기록
      * @param id  회원 아이디
      * @param passwd 회원 패스워드
      * @param id_passwd_save 회원 아이디/passwd Cookie에 저장 여부
      * @return
      */
     // http://localhost:9091/member/login.do 
     @RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
     public ModelAndView login_cookie_proc(
                                HttpServletRequest request,
                                HttpServletResponse response,
                                HttpSession session,
                                String id, 
                                String passwd,
                                @RequestParam(value="id_passwd_save", defaultValue="") String id_passwd_save, // 값이 전달되지 않았을때 400 에러 발생될 가능성↑
                                @RequestParam(value="return_url", defaultValue="") String return_url) {
       
       ModelAndView mav = new ModelAndView();
       Map<String, Object> map = new HashMap<String, Object>();
       map.put("id", id);
       map.put("passwd", passwd);
       
       int count = memberProc.login(map);
       if (count == 1) { // 로그인 성공
         // System.out.println(id + " 로그인 성공");
         MemberVO memberVO = memberProc.readById(id);
         session.setAttribute("admin_flag", false);
         session.setAttribute("memberid", memberVO.getMemberid()); // 서버의 메모리에 기록
         session.setAttribute("id", id);
         session.setAttribute("name", memberVO.getName());
         session.setAttribute("grade", memberVO.getGrade());
         // grade를 검사해서 등급이 맞는지 아닌지 확인하는 구문 추가가능!!
         
         // -------------------------------------------------------------------
         // id,passwd 관련 쿠기 저장
         // -------------------------------------------------------------------
         if (id_passwd_save.equals("Y")) { // id를 저장할 경우, Checkbox를 체크한 경우
           Cookie ck_id = new Cookie("ck_id", id);
           ck_id.setPath("/");  // root 폴더에 쿠키를 기록함으로 모든 경로에서 쿠기 접근 가능
           ck_id.setMaxAge(60 * 60 * 24 * 30); // 30 day, 초단위
           response.addCookie(ck_id); // id 저장
           
           Cookie ck_passwd = new Cookie("ck_passwd", passwd);
           ck_passwd.setPath("/");
           ck_passwd.setMaxAge(60 * 60 * 24 * 30); // 30 day
           response.addCookie(ck_passwd);
           
         } else { // N, id,passwd를 저장하지 않는 경우, Checkbox를 체크 해제한 경우
           Cookie ck_id = new Cookie("ck_id", "");
           ck_id.setPath("/");
           ck_id.setMaxAge(0);
           response.addCookie(ck_id); // id 저장
           
           Cookie ck_passwd = new Cookie("ck_passwd", "");
           ck_passwd.setPath("/");
           ck_passwd.setMaxAge(0);
           response.addCookie(ck_passwd);
         }
         
         // id,passwd를 저장할지 선택하는  CheckBox 체크 여부
         Cookie ck_id_passwd_save = new Cookie("ck_id_passwd_save", id_passwd_save);
         ck_id_passwd_save.setPath("/");
         ck_id_passwd_save.setMaxAge(60 * 60 * 24 * 30); // 30 day
         response.addCookie(ck_id_passwd_save);
         // -------------------------------------------------------------------
         
         // System.out.println("-> return_url: " + return_url);
         
         if (return_url.length() > 0) { // ★
           mav.setViewName("redirect:" + return_url);  
         } else {
           mav.setViewName("redirect:/index.do");
         }
           
       } else {
         mav.addObject("url", "/member/login_fail_msg");
         mav.setViewName("redirect:/member/msg.do"); 
       }
           
       return mav;
     }
     
     /**
      * 로그아웃 처리
      * @param session
      * @return
      */
     @RequestMapping(value="/member/logout.do", method=RequestMethod.GET)
     public ModelAndView logout(HttpSession session){
       ModelAndView mav = new ModelAndView();
       session.invalidate(); // 모든 session 변수 삭제
       
       mav.addObject("url", "/member/logout_msg"); // logout_msg.jsp, redirect parameter 적용
       
       mav.setViewName("redirect:/member/msg.do"); // 새로고침 방지
       
       return mav;
     }
     
     /**
      * 아이디찾기 폼
      */
     
     @RequestMapping(value="/member/find_id.do", method=RequestMethod.GET)
     public ModelAndView find_id(){
       ModelAndView mav = new ModelAndView();
       mav.setViewName("/member/find_id_form"); // /member/find_id_form.jsp
       
       return mav;
     }
     
     /**
      * 아이디찾기 처리
      */
     
     @RequestMapping(value="/member/find_id.do", method=RequestMethod.POST)
     public ModelAndView find_id(String email){
       ModelAndView mav = new ModelAndView();
       
       String id = this.memberProc.find_id(email);
       if (id != null ) { // 아이디찾기 성공
           mav.addObject("id", id);
           mav.setViewName("/member/find_id"); // /member/find_id.jsp
           
         } else {
           mav.addObject("code", "find_id_fail");
           mav.addObject("url", "/member/find_id_form"); // /member/find_id_form.jsp
          
           mav.setViewName("redirect:/member/find_id.do");
         }
       
       return mav;
     }
     
     
     /**
      * 비밀번호찾기 폼
      */
     
     @RequestMapping(value="/member/find_pw.do", method=RequestMethod.GET)
     public ModelAndView find_pw(){
       ModelAndView mav = new ModelAndView();
       mav.setViewName("/member/find_pw_form"); // /member/find_pw_form.jsp
     
       return mav;
     }
     
     
     /**
      * 비밀번호찾기 처리
     * @throws Exception 
      */
     @RequestMapping(value="/member/find_pw.do", method=RequestMethod.POST)
     public ModelAndView find_pw(MemberVO memberVO, HttpServletResponse response) throws Exception{      
         ModelAndView mav = new ModelAndView();
         
         MemberVO ck = memberProc.readById(memberVO.getId());
         
         // 가입된 아이디가 없으면
         if(memberProc.checkID(memberVO.getId()) == 0) {
             mav.addObject("code", "find_id_fail");
             mav.addObject("url", "/member/find_pw_form"); // /member/find_pw_form.jsp
             mav.setViewName("redirect:/member/find_pw.do");
         }
         // 가입된 이메일이 아니면
         else if(!memberVO.getEmail().equals(ck.getEmail())) {
             mav.addObject("code", "find_email_fail");
             mav.addObject("id", memberVO.getId());
             mav.addObject("url", "/member/find_pw_form"); // /member/find_pw_form.jsp
             mav.setViewName("redirect:/member/find_pw.do");
         }else {
             mav.addObject("email", ck.getEmail());  // 홍길동님(user4) 패스워드를 변경했습니다.
             mav.addObject("id", ck.getId());
             
             // 임시 비밀번호 생성
             String new_passwd = "";
             for (int i = 0; i < 12; i++) {
                 new_passwd += (char) ((Math.random() * 26) + 97);
             }
             //System.out.println(new_passwd);
             
             HashMap<Object, Object> map = new HashMap<Object, Object>();
             map.put("memberid", ck.getMemberid());
             map.put("passwd", new_passwd);
             memberVO.setPasswd(new_passwd);
             memberVO.setName(ck.getName());
             
             memberProc.passwd_update(map); // 패스워드 변경 처리
             mav.addObject("code", "find_pw_update_success"); // 패스워드 변경 성공
               
             // 비밀번호 변경 메일 발송
             memberProc.sendEmail(memberVO, "find_pw");
             mav.addObject("url", "/member/msg"); // /member/msg.jsp
             mav.setViewName("redirect:/member/msg.do");

         }
         
        return mav;
     }
     
     /**
      * 회원탈퇴 처리
      * @param memberid 회원 번호
      * @param passwd_ck 패스워드
      * @return
      */
     @RequestMapping(value="/member/withdrawal.do", method=RequestMethod.POST)
     public ModelAndView withdrawal(int memberid, String passwd_ck){
       ModelAndView mav = new ModelAndView();
          
       // 패스워드 검사
       HashMap<Object, Object> map = new HashMap<Object, Object>();
       map.put("memberid", memberid);
       map.put("passwd", passwd_ck);
       
       int cnt = memberProc.passwd_check(map);
      
       if (cnt == 1) { // 현재 패스워드가 일치하는 경우
           mav.addObject("code", "passwd_success");
           mav.addObject("memberid", memberid);          
           mav.setViewName("redirect:/member/read.do");
           //mav.setViewName("/member/delete");
         
       } else {
         mav.addObject("code", "passwd_fail"); // 패스워드가 일치하지 않는 경우
         mav.addObject("memberid", memberid);          
         mav.setViewName("redirect:/member/read.do");
       }

       return mav;
     }
     
     /**
      * Session test http://localhost:9091/member/session.do
      * 
      * @param session
      * @return
      */
     @RequestMapping(value = "/member/session.do", method = RequestMethod.GET)
     public ModelAndView session(HttpSession session) {
         ModelAndView mav = new ModelAndView();

         mav.addObject("url", "/member/session");
         mav.setViewName("redirect:/member/msg.do");

         return mav;
     }

}
