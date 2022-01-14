package dev.mvc.faq;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.yaml.snakeyaml.parser.ParserImpl;

@Controller
public class FaqCont {
    
    @Autowired
    @Qualifier("dev.mvc.faq.FaqProc") // dependency injection interface implement for this name
    private FaqProcInter faqProc;
       
    /**
     * 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/faq/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url, String code){
      ModelAndView mav = new ModelAndView();
      
      // msg 메서드의 매개변수 이름과, rediect로 보낸 Proc메서드의 변수 binding
//      System.out.println(code);
//      System.out.println(url);
      mav.addObject("code", code);
      mav.setViewName(url); // forward
      
      return mav; // forward
    }
    
    
    @RequestMapping(value = "/faqlist", method = RequestMethod.GET)
    public ModelAndView showFaqList() {
        ModelAndView mav = new ModelAndView();
        
        List<FaqVO> list = faqProc.getAll();
        
        // for test about that the query works or not
        // System.out.println("list사이즈는???" + list.size());
        
        mav.addObject("lists", list);
        mav.setViewName("faq/faqlist");
        
        return mav;
    }
    
    /**
     * 
     * @param faqno
     * @return 단일 페이지에 뿌려질 객체 + faqRead.jsp forward
     */
    @RequestMapping(value = "/faq/{faqno}/read.do", method = RequestMethod.GET)
    public ModelAndView readFaq(@PathVariable String faqno) {
        
        ModelAndView mav = new ModelAndView();      
        int pk = Integer.parseInt(faqno);
        
         FaqVO faqVO = null;
         faqVO = faqProc.getOneWithPK(pk);
         
         if (faqVO != null) { // 조회된 객체가 있으면 read, 없다면 에러 페이지.
             mav.addObject("faqVO", faqVO);
             mav.setViewName("/faq/faqRead");
         } else {
             mav.addObject("code", "ObjNotFoundException");
             mav.setViewName("/faq/msg");
         }
        return mav;
    }
    
    @RequestMapping(value = "/faq", method = RequestMethod.GET)
    public ModelAndView createForm() {
        ModelAndView mav = new ModelAndView();
        
        mav.setViewName("faq/createform");
        return mav;     
    }
    
    @RequestMapping(value = "/faq", method = RequestMethod.POST)
    public ModelAndView createFaq(FaqVO faqVO) {
        ModelAndView mav = new ModelAndView();
        
        int result = faqProc.createFaq(faqVO);
        
        if(result == 1) mav.addObject("code", "faq_success");
        else mav.addObject("code", "faq_fail");
        
        // forward to msg method (for avoiding press F5 key)
        mav.addObject("url", "faq/msg");
        mav.setViewName("redirect:/faq/msg.do");
        return mav;     
    }
    
    
    /**
     * using pathVariable
     * @param faqno
     * @return
     */
    @RequestMapping(value = "/faq/{faqno}/update.do", method=RequestMethod.GET)
    public ModelAndView readForUpdate(@PathVariable String faqno) {
        
        ModelAndView mav = new ModelAndView();
        int pk = Integer.parseInt(faqno);
        
        // test for path var.
        //System.out.println("입력받은 fqno" + faqno);
        
        // forward an FaqVO from DB
       
        FaqVO faqVO = faqProc.getOneWithPK(pk);
        mav.addObject("faqno", pk);
        mav.addObject("faqVO", faqVO);
        mav.setViewName("faq/faqUpdateForm");
        return mav;
    }
    
    /**
     * using pathVariable
     * @param faqno
     * @return
     */
    @RequestMapping(value = "/faq/{faqno}/update.do", method=RequestMethod.POST)
    public ModelAndView updateProc(FaqVO faqVO, @PathVariable String faqno) {
       
        ModelAndView mav = new ModelAndView();
        
        int pk = Integer.parseInt(faqno);
        int result = faqProc.updateFaq(faqVO);
        
        //System.out.println("result : " + result);
        
        if (result < 1) {
           mav.addObject("code", "faq_update_fail");
        } else {
            mav.addObject("code", "faq_update_success");
        }
        
        // forward to msg method (for avoiding press F5 key)
        mav.addObject("url", "/faq/msg");
        mav.setViewName("redirect:/faq/msg.do");
        return mav;
    }
    
    
    /**
     * 
     * @param faqno
     * @return
     */
    @RequestMapping(value = "/faq/{faqno}/delete.do", method=RequestMethod.GET)
    public ModelAndView readForDelete(@PathVariable String faqno) {
        ModelAndView mav = new ModelAndView();
        
        int pk = Integer.parseInt(faqno);
        
        FaqVO faqVO =  faqProc.getOneWithPK(pk);
        
        mav.addObject("faqVO", faqVO);
        mav.setViewName("/faq/faqDeleteForm");
        
        return mav;
    }
    
    
    @RequestMapping(value = "/faq/{faqno}/delete.do")
    public ModelAndView deleteProc(@PathVariable String faqno) {
        ModelAndView mav = new ModelAndView();
        
        int pk = Integer.parseInt(faqno);
        
        int result = faqProc.deleteFaq(pk);
        
        if (result < 1) mav.addObject("code", "faq_delete_fail");
        else mav.addObject("code", "faq_delete_success");
        
        mav.addObject("url", "/faq/msg");
        mav.setViewName("redirect:/faq/msg.do");
        
        return mav;
    }
}
