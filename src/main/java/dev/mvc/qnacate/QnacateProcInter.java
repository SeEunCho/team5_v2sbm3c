package dev.mvc.qnacate;

import java.util.List;

public interface QnacateProcInter {
    
    /**
     * 
     * @param qnacateVO
     * @return
     */
    public int createQnacate (QnacateVO qnacateVO);
    
    /**
     * 
     * @return
     */
    public List<QnacateVO> findCateList();
    
    /**
     * 
     * @param qcateno
     * @return
     */
    public QnacateVO findByQcateno(int qcateno);
    
    /**
     * 
     * @param qnacateVO
     * @return
     */
    public int updateQcategory(QnacateVO qnacateVO);
    
    /**
     * @param 기본 키 int
     * @return 삭제된 행의 수
     */
    public int deleteQcategory(int qcateno);

}
