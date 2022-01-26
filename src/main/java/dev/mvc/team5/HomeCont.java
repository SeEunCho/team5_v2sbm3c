package dev.mvc.team5;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.api.ApiProc;
import dev.mvc.api.ApiVO;

@Controller
public class HomeCont {
    
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }

  @Autowired
  @Qualifier("dev.mvc.api.ApiProc")
  private ApiProc apiProc;
  
  
  // http://localhost:9091, http://localhost:9091/index.do
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home() {
    ModelAndView mav = new ModelAndView();
    
    List<ApiVO> list = null;
    list = apiProc.getAllRegion();
    
    if(list == null) {
        System.out.println("값이 들어오지 않습니다 APIVo LIST");
    } else {
        mav.setViewName("/index");  // /WEB-INF/views/index.jsp
        mav.addObject("list", list);
    }
    
    return mav;
  }
}