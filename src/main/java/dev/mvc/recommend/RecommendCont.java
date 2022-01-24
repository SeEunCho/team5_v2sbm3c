package dev.mvc.recommend;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RecommendCont {

    public RecommendCont() {
    }
    
    // http://localhost:9091/recommend/start.do
    @RequestMapping(value = {"/recommend/start.do"}, method = RequestMethod.GET)
    public ModelAndView start() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/recommend/start");
      
      return mav;
    }

    // http://localhost:9091/recommend/form1.do
    @RequestMapping(value = {"/recommend/form1"}, method = RequestMethod.GET)
    public ModelAndView form1() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/recommend/form1");  // /WEB-INF/views/recommend/recommend_house/form1.jsp
      
      return mav;
    }

    // http://localhost:9091/recommend/form2.do
    @RequestMapping(value = {"/recommend/form2.do"}, method = RequestMethod.GET)
    public ModelAndView form2() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/recommend/form2");  // /WEB-INF/views/recommend/recommend_house/form2.jsp
      
      return mav;
    }

    // http://localhost:9091/recommend/form3.do
    @RequestMapping(value = {"/recommend/form3.do"}, method = RequestMethod.GET)
    public ModelAndView form3() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/recommend/form3");  // /WEB-INF/views/recommend/recommend_house/form3.jsp
      
      return mav;
    }
    
    // http://localhost:9091/recommend/form4.do
    @RequestMapping(value = {"/recommend/form4.do"}, method = RequestMethod.GET)
    public ModelAndView form4() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/recommend/form4");  // /WEB-INF/views/recommend/recommend_house/form4.jsp
      
      return mav;
    }
    
    // http://localhost:9091/recommend/form3.do
    @RequestMapping(value = {"/recommend/form5.do"}, method = RequestMethod.GET)
    public ModelAndView form5() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/recommend/form5");  // /WEB-INF/views/recommend/recommend_house/form5.jsp
      
      return mav;
    }
    
    
    // http://localhost:9091/recommend/end.do
    @RequestMapping(value = {"/recommend/end.do"}, method = RequestMethod.GET)
    public ModelAndView end() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/recommend/end");  // /WEB-INF/views/recommend/recommend_house/end.jsp
      
      return mav;
    }
    
}
