package dev.mvc.qnacate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component(value = "dev.mvc.qnacate.QnacateProc")
public class QnacateProc implements QnacateProcInter {
    
    @Autowired
    private QnacateDAOInter qnacateDAO;

    @Override
    public int createQnacate(QnacateVO qnacateVO) {
        return qnacateDAO.createQnacate(qnacateVO);
    }

    @Override
    public List<QnacateVO> findCateList() {
        return qnacateDAO.findCateList();
    }

    @Override
    public QnacateVO findByQcateno(int qcateno) {
        return qnacateDAO.findByQcateno(qcateno);
    }

    @Override
    public int updateQcategory(QnacateVO qnacateVO) {
        return qnacateDAO.updateQcategory(qnacateVO);
    }

    @Override
    public int deleteQcategory(int qcateno) {
        return qnacateDAO.deleteQcategory(qcateno);
    }
    
}
