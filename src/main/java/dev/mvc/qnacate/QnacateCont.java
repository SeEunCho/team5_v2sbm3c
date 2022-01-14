package dev.mvc.qnacate;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.qna.QnaProcInter;
import dev.mvc.qna.QnaVO;

@Controller
public class QnacateCont {
    
    @Autowired
    @Qualifier("dev.mvc.qnacate.QnacateProc")
    private QnacateProcInter qnacateProc;
    
    // 의존관계 발생. QnacateCont -> qnaProc 
    @Autowired
    @Qualifier("dev.mvc.qna.QnaProc")
    private QnaProcInter qnaProc;
    
    
    /**
     * 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/qnacate/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url, String code){
      ModelAndView mav = new ModelAndView();
      
      mav.addObject("code", code);
      mav.setViewName(url); // forward
      
      return mav; // forward
    }
    
    
    @RequestMapping(value = "/qnacatelist", method=RequestMethod.GET)
    public ModelAndView showQnacateList() {
        
        ModelAndView mav =  new ModelAndView();
        
        List<QnacateVO> list = qnacateProc.findCateList();
        
        // for test about that the query works or not
       //  System.out.println("list사이즈는???" + list.size());
        
        mav.addObject("list", list);
        mav.setViewName("/qnacate/qnacatelist");
        
        return mav;
    }
    
    /**
     *  특정 카테고리 read 시 연관 QnA가 나오도록 개발
     *  
     * @param qcateno
     * @return
     */
    @RequestMapping(value = "/qnacate/read_one.do", method = RequestMethod.GET)
    public ModelAndView readQcate(int qcateno, String name) {
        ModelAndView mav =  new ModelAndView();
        
        List<QnaVO> list = qnaProc.joinQnaAndQcate(qcateno);
        
        mav.addObject("list", list);
        mav.addObject("qcatename", name);
        mav.setViewName("/qnacate/qnacateRead");
        return mav;
    }
    
    /**
     * insert a category into DB
     * @param qnacateVO
     * @return 내부 처리 이후 qnacatelist 페이지 이동
     */
    @RequestMapping(value = "/qnacate", method=RequestMethod.POST)
    public ModelAndView qcateCreateProc(QnacateVO qnacateVO) {
        
        ModelAndView mav =  new ModelAndView();
        
        int result = qnacateProc.createQnacate(qnacateVO);
        
        if(result < 1) {
            mav.addObject("code", "qnacate_create_fail");
        } else {
            mav.addObject("code", "qnacate_create_success");
        }
        
        mav.addObject("url", "/qnacate/msg");
        mav.setViewName("redirect:/qnacate/msg.do");
        return mav;
    }

    /**
     * 
     * @param qcateno (PK값을 경로 변수형식으로 전달.)
     * @return 해당 PK값으로 읽어온 VO객체의 json값 
     */
    @ResponseBody
    @RequestMapping(value = "/qnacate/{qcateno}/read.do", method=RequestMethod.GET)
    public String readForUpdate(@PathVariable String qcateno) {
        
        int pk = Integer.parseInt(qcateno);
        QnacateVO qnacateVO = qnacateProc.findByQcateno(pk);
        
        JSONObject json = new JSONObject();
        
        json.put("qcateno", qnacateVO.getQcateno());
        json.put("name", qnacateVO.getName());
        json.put("adminid", qnacateVO.getAdminid());
        
        return json.toString();
    }
    
    
    @RequestMapping(value = "/qnacate/update.do", method=RequestMethod.POST)
    public ModelAndView qcateUpdateProc(QnacateVO qnacateVO) {
        
        ModelAndView mav =  new ModelAndView();
        
        int result = qnacateProc.updateQcategory(qnacateVO);
        
        if(result < 1) {
            mav.addObject("code", "qnacate_update_fail");
        } else {
            mav.addObject("code", "qnacate_update_success");
        }
        mav.addObject("url", "/qnacate/msg");
        mav.setViewName("redirect:/qnacate/msg.do");
        return mav;
    }
    
    /**
     * 
     * @param qcateno (PK값을 경로 변수형식으로 전달.)
     * @return 해당 PK값으로 읽어온 VO객체의 json값 
     */
    @ResponseBody
    @RequestMapping(value = "/qnacate/read_delete", method=RequestMethod.GET)
    public String readForDelete(int qcateno) {
        
        
        QnacateVO qnacateVO = qnacateProc.findByQcateno(qcateno);
        int cnt = qnaProc.countByQnacateno(qcateno);
       
        JSONObject json = new JSONObject();
        
        json.put("qcateno", qnacateVO.getQcateno());
        json.put("name", qnacateVO.getName());
        json.put("adminid", qnacateVO.getAdminid());
        json.put("cnt", cnt);
        return json.toString();
    }
    
    @RequestMapping(value = "/qnacate/delete.do", method=RequestMethod.POST)
    public ModelAndView qcateDeleteProc(int qcateno) {
        
        ModelAndView mav =  new ModelAndView();
        
        try {
            
            int result = qnacateProc.deleteQcategory(qcateno);
            
            if(result < 1) {
                mav.addObject("code", "qnacate_delete_fail");
            } else {
                mav.addObject("code", "qnacate_delete_success");
            }
            
        } catch (Exception e) { // 관리자가 QnA 테이블을 비우지 않고 삭제 form submit 시 예외처리.
            mav.addObject("qcateno", qcateno);
            mav.addObject("code", "ChildRecordFoundException");
        }

        mav.addObject("url", "/qnacate/msg");
        mav.setViewName("redirect:/qnacate/msg.do");
        return mav;
    }   
    
}
