package dev.mvc.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;

@Controller
public class AdminCont {
    @Autowired
    @Qualifier("dev.mvc.admin.AdminProc")
    private AdminProcInter adminProc;
    
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc;

    public AdminCont() {
        // System.out.println("-> AdminCont created.");
    }
    
    /**
     * 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/admin/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward
      
      return mav; // forward
    }

    /**
     * 로그인 폼
     * @return
     */
    // http://localhost:9091/admin/login.do
    @RequestMapping(value = "/admin/login.do", method = RequestMethod.GET)
    public ModelAndView login() {
        ModelAndView mav = new ModelAndView();

        mav.setViewName("/admin/login_form");
        return mav;
    }

    /**
     * 로그인 처리
     * @return
     */
    // http://localhost:9091/admin/login.do
    @RequestMapping(value = "/admin/login.do", method = RequestMethod.POST)
    public ModelAndView login_proc(HttpSession session, String id, String passwd) {
        ModelAndView mav = new ModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("id", id);
        map.put("passwd", passwd);

        int count = adminProc.login(map); // id, passwd 일치 여부 확인
        if (count == 1) { // 로그인 성공
            // System.out.println(id + " 로그인 성공");
            AdminVO adminVO = adminProc.readById(id); // 로그인한 회원의 정보 조회
            session.setAttribute("admin_flag", true);
            session.setAttribute("adminid", adminVO.getAdminid());
            session.setAttribute("id", id);
            // session.setAttribute("name", adminVO.getName());

            mav.setViewName("redirect:/index.do"); // 시작 페이지로 이동
        } else {
            mav.addObject("url", "/admin/login_fail_msg"); // login_fail_msg.jsp, redirect parameter 적용

            mav.setViewName("redirect:/admin/msg.do"); // 새로고침 방지
        }

        return mav;
    }
    
    /**
     * 목록 출력 가능
     * @param session
     * @return
     */
     @RequestMapping(value="/member/list.do", method=RequestMethod.GET)
     public ModelAndView list(HttpSession session) {
         ModelAndView mav = new ModelAndView();
         boolean admin_flag = (boolean)session.getAttribute("admin_flag");
         
         if (admin_flag) {
             List<MemberVO> list = memberProc.list();
             mav.addObject("list", list);
             mav.setViewName("/member/list"); // /webapp/WEB-INF/views/member/list.jsp
         } else {
             mav.addObject("url", "/admin/login_need"); // login_need.jsp, redirect parameter 적용
             mav.setViewName("redirect:/admin/msg.do");
         }
       
         return mav;
     } 
     
     
}
