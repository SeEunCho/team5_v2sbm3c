package dev.mvc.notice;

import java.util.List;

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
    public ModelAndView read_update(int noticeno) {
        // request.setAttribute("noticeno", int noticeno) 작동 안됨.

        ModelAndView mav = new ModelAndView();

        NoticeVO noticeVO = this.noticeProc.read(noticeno);
        mav.addObject("noticeVO", noticeVO); // request 객체에 저장

        List<NoticeVO> list = this.noticeProc.list();
        mav.addObject("list", list); // request 객체에 저장

        mav.setViewName("/notice/read_update"); // /WEB-INF/views/notice/read_update.jsp
        return mav; // forward
    }

}
