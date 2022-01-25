package dev.mvc.notice;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeCont {
    @Autowired
    @Qualifier("dev.mvc.notice.NoticeProc")
    private NoticeProcInter noticeProc;

    public NoticeCont() {
        System.out.println("-> NoticeCont created.");
    }

    // http://localhost:9091/notice/create.do
    /**
     * 등록 폼
     * 
     * @return
     */
    @RequestMapping(value = "/notice/create.do", method = RequestMethod.GET)
    public ModelAndView create() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/notice/create"); // webapp/WEB-INF/views/notice/create.jsp

        return mav; // forward
    }

    // http://localhost:9091/notice/create.do
    /**
     * 등록 처리
     * 
     * @param noticeVO
     * @return
     */
    @RequestMapping(value = "/notice/create.do", method = RequestMethod.POST)
    public ModelAndView create(NoticeVO noticeVO) { // noticeVO 자동 생성, Form -> VO
        // NoticeVO noticeVO <FORM> 태그의 값으로 자동 생성됨.
        // request.setAttribute("noticeVO", noticeVO); 자동 실행

        ModelAndView mav = new ModelAndView();

        int cnt = this.noticeProc.create(noticeVO); // 등록 처리
        // cnt = 0; // error test

        mav.addObject("cnt", cnt);

        if (cnt == 1) {
            // System.out.println("등록 성공");

            // mav.addObject("code", "create_success"); // request에 저장,
            // request.setAttribute("code", "create_success")
            // mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp

            // response.sendRedirect("/notice/list.do");
            mav.setViewName("redirect:/notice/list.do");
        } else {
            mav.addObject("code", "create_fail"); // request에 저장, request.setAttribute("code", "create_fail")
            mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp
        }

        return mav; // forward
    }

    // http://localhost:9091/notice/list.do
    @RequestMapping(value = "/notice/list.do", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView();

        // 등록 순서별 출력
        List<NoticeVO> list = this.noticeProc.list();
        mav.addObject("list", list);
        mav.setViewName("/notice/list"); // /webapp/WEB-INF/views/notice/list.jsp
        return mav;
    }

    // http://localhost:9091/notice/read_update.do?noticeno=1
    /**
     * 조회 + 수정폼
     * 
     * @param noticeno 조회할 공지사항 번호
     * @return
     */
    @RequestMapping(value = "/notice/read_update.do", method = RequestMethod.GET)
    public ModelAndView read_update(int noticeno,  HttpSession session) {
        // request.setAttribute("noticeno", int noticeno) 작동 안됨.
        boolean admin_flag = false;
        
        ModelAndView mav = new ModelAndView();
        
        try {
            admin_flag = (boolean)session.getAttribute("admin_flag");
        } catch(NullPointerException e) {
            admin_flag = false;
        } 
        
        if (admin_flag) {
            NoticeVO noticeVO = this.noticeProc.read(noticeno);
            mav.addObject("noticeVO", noticeVO); // request 객체에 저장

            List<NoticeVO> list = this.noticeProc.list();
            mav.addObject("list", list); // request 객체에 저장

            mav.setViewName("/notice/read_update"); // /WEB-INF/views/notice/read_update.jsp
        } else{
            mav.addObject("code", "update_admin_fail"); // request에 저장, request.setAttribute("code", "login_fail_msg")
            mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp
        }
        
        
        return mav; // forward
    }

    // http://localhost:9091/notice/update.do
    /**
     * 수정 처리
     * 
     * @param noticeVO
     * @return
     */
    @RequestMapping(value = "/notice/update.do", method = RequestMethod.POST)
    public ModelAndView update(NoticeVO noticeVO) {
        // NoticeVO noticeVO <FORM> 태그의 값으로 자동 생성됨.
        // request.setAttribute("noticeVO", noticeVO); 자동 실행

        ModelAndView mav = new ModelAndView();

        int cnt = this.noticeProc.update(noticeVO);
        mav.addObject("cnt", cnt); // request에 저장

        // cnt = 0; // error test
        if (cnt == 1) {
            // System.out.println("수정 성공");
            // response.sendRedirect("/notice/list.do");
            mav.setViewName("redirect:/notice/list.do");
        } else {
            mav.addObject("code", "update"); // request에 저장, request.setAttribute("code", "update")
            mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp
        }

        return mav;
    }

    // http://localhost:9091/notice/read_delete.do?noticeno=1
    /**
     * 조회 + 삭제폼
     * 
     * @param noticeno 조회할 공지사항 번호
     * @return
     */
    @RequestMapping(value = "/notice/read_delete.do", method = RequestMethod.GET)
    public ModelAndView read_delete(int noticeno, HttpSession session) {
        boolean admin_flag = false;
        ModelAndView mav = new ModelAndView();
        
        try {
            admin_flag = (boolean)session.getAttribute("admin_flag");
        } catch(NullPointerException e) {
            admin_flag = false;
        } 
        
        if (admin_flag) {
            NoticeVO noticeVO = this.noticeProc.read(noticeno); // 삭제할 자료 읽기
            mav.addObject("noticeVO", noticeVO); // request 객체에 저장

            List<NoticeVO> list = this.noticeProc.list();
            mav.addObject("list", list); // request 객체에 저장

            mav.setViewName("/notice/read_delete"); // read_delete.jsp
        }else{
            mav.addObject("code", "delete_admin_fail"); // request에 저장, request.setAttribute("code", "login_fail_msg")
            mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp
        }
        
        return mav;
    }

    // http://localhost:9091/notice/delete.do
    /**
     * 삭제
     * 
     * @param noticeno 조회할 공지사항 번호
     * @return 삭제된 레코드 갯수
     */
    @RequestMapping(value = "/notice/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(int noticeno) {
        ModelAndView mav = new ModelAndView();

        NoticeVO noticeVO = this.noticeProc.read(noticeno); // 삭제 정보
        mav.addObject("noticeVO", noticeVO); // request 객체에 저장

        int cnt = this.noticeProc.delete(noticeno); // 삭제 처리

        // cnt = 0; // error test
        mav.addObject("cnt", cnt); // request 객체에 저장

        if (cnt == 1) {
            mav.addObject("code", "delete_success"); // request에 저장, request.setAttribute("code", "delete_success")
        } else {
            mav.addObject("code", "delete_fail"); // request에 저장, request.setAttribute("code", "delete_fail")
        }
        mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp

        return mav;
    }

    // http://localhost:9091/notice/read.do
    /**
     * 조회
     * 
     * @return
     */
    @RequestMapping(value = "/notice/read.do", method = RequestMethod.GET)
    public ModelAndView read(int noticeno) {
        ModelAndView mav = new ModelAndView();

        NoticeVO noticeVO = this.noticeProc.read(noticeno);
        mav.addObject("noticeVO", noticeVO); // request.setAttribute("noticeVO", noticeVO);

        mav.setViewName("/notice/read"); // /WEB-INF/views/notice/read.jsp

        return mav;
    }

}
