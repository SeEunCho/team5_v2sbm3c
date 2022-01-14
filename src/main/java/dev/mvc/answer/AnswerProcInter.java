package dev.mvc.answer;

public interface AnswerProcInter {
    
    /**
     * 
     * @param answerVO 객체
     * @return 생성된 행의 수(int)
     */
    public int createAns(AnswerVO answerVO);
    
    
    /**
     * 
     * @param qnano 외래 키
     * @return 외래키에 해당하는 VO객체 하나
     */
    public AnswerVO getOneByFk(int qnano);
    
    /**
     * 
     * @param answerno 기본 키
     * @return 기본키에 해당하는 VO 객체 하나.
     */
    public AnswerVO getOneByPk(int answerno);
    
    /**
     * 
     * @param answerVO
     * @return 갱신된 행의 수(int)
     */
    public int updateAns(AnswerVO answerVO);
    
    /**
     * 
     * @param answerno
     * @return 삭제된 행의 수(int)
     */
    public int deleteAns(int answerno);

}
