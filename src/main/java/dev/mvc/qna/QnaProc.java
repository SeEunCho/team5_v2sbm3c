package dev.mvc.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter{
    
    @Autowired
    private QnaDAOInter qnaDAO;

    @Override
    public int createQna(QnaVO qnaVO) {
        return qnaDAO.createQna(qnaVO);
    }

    @Override
    public List<QnaVO> getListWithMemberid(int memberid) {
        return qnaDAO.getListWithMemberid(memberid);
    }

    @Override
    public QnaVO getOneWithPK(int qnano) {
        return qnaDAO.getOneWithPK(qnano);
    }

    @Override
    public int updateQna(QnaVO qnaVO) {
        return qnaDAO.updateQna(qnaVO);
    }

    @Override
    public int deleteQna(int qnano) {
        return qnaDAO.deleteQna(qnano);
    }
    
    //zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
    @Override
    public int deleteQnaByQcateno(int qcateno) {
        return qnaDAO.deleteQnaByQcateno(qcateno);
    }

    @Override
    public int countByQnacateno(int qcateno) {
        return qnaDAO.countByQnacateno(qcateno);
    }

    @Override
    public List<QnaVO> joinQnaAndQcate(int qcateno) {
        return qnaDAO.joinQnaAndQcate(qcateno);
    }
}
