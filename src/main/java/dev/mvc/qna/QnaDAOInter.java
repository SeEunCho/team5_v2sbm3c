package dev.mvc.qna;

import java.util.List;

public interface QnaDAOInter {
    
    
    /**
     * 
     * @param qnaVO
     * @return
     */
    public int createQna(QnaVO qnaVO);
    
    /**
     * 
     * @param memberid
     * @return
     */
    public List<QnaVO> getListWithMemberid(int memberid) ;
    
 
    /**
     * 
     * @param qnano
     * @return
     */
    public QnaVO getOneWithPK(int qnano);
    
    
    /**
     * 
     * @param qnaVO
     * @return
     */
    public int updateQna(QnaVO qnaVO);
    
    /**
     * 
     * @param qnano
     * @return
     */
    public int deleteQna(int qnano);
    
    
    /**
     * 
     * @param qcateno 외래 키
     * @return 삭제된 카테고리에 해당하는 Qna개수 (동시삭제)
     */
    public int deleteQnaByQcateno(int qcateno);
    
    
    /**
     * 
     * @param qcateno 기본키
     * @return 해당 카테고리에 속한 QnA 개수
     */
    public int countByQnacateno(int qcateno);
    
    /**
     * 
     * @return 외래 키 (카테고리번호)에 해당하는  QnA 집합 리턴.
     */
    public List<QnaVO> joinQnaAndQcate(int qcateno);


}
