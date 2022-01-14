package dev.mvc.answer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AnswerCont {
    
    @Autowired
    @Qualifier("MyAnswerProc")
    private AnswerProcInter answerProc;
    
    // code에서 Answer A대문자로 할 것.
    
    /**
     * 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/answer/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url, String code){
      ModelAndView mav = new ModelAndView();
      
      mav.addObject("code", code);
      mav.setViewName(url); 
      
      return mav; // forward
    }
    
    /**
     *  answer에서는 js를 이용하여 답변 폼을 띄우고 submit하는 형식으로 진행.
     *  따라서 Proc 컨트롤러만 존재
     * @param answerVO
     * @return
     */
    @RequestMapping(value = "/answer", method = RequestMethod.POST)
    public ModelAndView createAnsProc(AnswerVO answerVO) {
        
        ModelAndView mav = new ModelAndView();
        
        int result = answerProc.createAns(answerVO);
        int qnano = answerVO.getQnano();
        
        if(result < 1) {
            mav.addObject("code", "Answer_create_fail");
        } else {
            mav.addObject("code", "Answer_create_success");
        }
        mav.addObject("qnano", qnano);
        mav.addObject("url", "/answer/msg");
        mav.setViewName("redirect:/answer/msg.do");
        return mav;
    }
    
    @RequestMapping(value = "/answer/{answerno}/update.do", method=RequestMethod.GET)
    public ModelAndView readAnsForUpdate(@PathVariable String answerno) {
        
        ModelAndView mav = new ModelAndView();
        
        int pk = Integer.parseInt(answerno);
        AnswerVO answerVO = null;
        answerVO = answerProc.getOneByPk(pk);
        
        if (answerVO != null) {
            mav.addObject("answerVO", answerVO);
            mav.setViewName("/answer/updateAnsForm");
        } else {
            mav.addObject("code", "ObjNotFoundException");
            mav.addObject("url", "/answer/msg");
            mav.setViewName("redirect:/answer/msg.do");
        }
        
        
        return mav;
    }
    
    @RequestMapping(value = "/answer/{answerno}/update.do", method=RequestMethod.POST)
    public ModelAndView updateAns(AnswerVO answerVO) {
        
        ModelAndView mav = new ModelAndView();
        
        int result = answerProc.updateAns(answerVO);
        
        if(result < 1) {
            mav.addObject("code", "Answer_update_fail");
        } else {
            mav.addObject("code", "Answer_update_success");
        }
        mav.addObject("url", "/answer/msg");
        mav.setViewName("redirect:/answer/msg.do");
        return mav;
    }
    
    
    
    @RequestMapping(value = "/answer/{answerno}/delete.do", method=RequestMethod.GET)
    public ModelAndView readAnsForDelete(@PathVariable String answerno) {
        
        ModelAndView mav = new ModelAndView();
        
        int pk = Integer.parseInt(answerno);
        AnswerVO answerVO = null;
        answerVO = answerProc.getOneByPk(pk);
        
        if (answerVO != null) {
            mav.addObject("answerVO", answerVO);
            mav.setViewName("/answer/deleteAnsForm");
        } else {
            mav.addObject("code", "ObjNotFoundException");
            mav.addObject("url", "/answer/msg");
            mav.setViewName("redirect:/answer/msg.do");
        }
        
        
        
        return mav;
    }
    
    @RequestMapping(value = "/answer/{answerno}/delete.do", method=RequestMethod.POST)
    public ModelAndView deleteAns(@PathVariable String answerno) {
        
        ModelAndView mav = new ModelAndView();
        
        int pk = Integer.parseInt(answerno);
        
        int result = answerProc.deleteAns(pk);
        
        if(result < 1) {
            mav.addObject("code", "Answer_delete_fail");
        } else {
            mav.addObject("code", "Answer_delete_success");
        }
        mav.addObject("url", "/answer/msg");
        mav.setViewName("redirect:/answer/msg.do");
        return mav;
    }
    
    /**
     * 
     *  컨트롤러 구조는 그대로 하는데, view JS에서 새로운 윈도우 띄워서 하는 식으로
     *  해보자.
     */

}
