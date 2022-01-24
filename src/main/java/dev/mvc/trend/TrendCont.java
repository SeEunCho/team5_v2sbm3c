package dev.mvc.trend;

import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TrendCont {

    public TrendCont() {
        //System.out.println("-> TrendCont created.");
    }
    
    // http://localhost:9091/trend/news.do
    @RequestMapping(value = { "/trend/news.do" }, method = RequestMethod.GET)
    public ModelAndView news() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/trend/news"); // /WEB-INF/views/trend/news.jsp
        return mav;
    }
    
 // http://localhost:9091/trend/chart.do
    @RequestMapping(value = { "/trend/chart.do" }, method = RequestMethod.GET)
    public ModelAndView chart() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/trend/chart"); // /WEB-INF/views/trend/news.jsp
        return mav;
    }
    
}
