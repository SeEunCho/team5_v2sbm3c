package dev.mvc.faq;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.faq.FaqProc")
public class FaqProc implements FaqProcInter {
    
    @Autowired
    private FaqDAOInter faqDAOInter;

    @Override
    public int createFaq(FaqVO faqVO) { return faqDAOInter.createFaq(faqVO); }

    @Override
    public List<FaqVO> getListWithFK(int adminid) { return faqDAOInter.getListWithFK(adminid); }
    
    @Override
    public FaqVO getOneWithPK(int faqno) { return faqDAOInter.getOneWithPK(faqno); }

    @Override
    public List<FaqVO> getAll() { return faqDAOInter.getAll(); }

    @Override
    public int updateFaq(FaqVO faqVO) { return faqDAOInter.updateFaq(faqVO); }

    @Override
    public int deleteFaq(int faqno) { return faqDAOInter.deleteFaq(faqno); }

}
