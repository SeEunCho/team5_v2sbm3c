package dev.mvc.answer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("MyAnswerProc") // 패키지 명을 명시해야하는지, 임의 이름이 부여 가능한지 테스트
public class AnswerProc implements AnswerProcInter{
    
    
    /**
     * 기존에 Java에서는 인터페이스 인스턴스가 불가능하나
     * 스프링 컨테이너가 의존(interface 구현클래스)관계를 주입하면서
     * 변수 생성이 되고, 메소드 호출이 가능한 '것' 처럼 보인다. 
     * 실제로는 객체를 생성하여 대입해주는 코드가 있지만 프레임워크 레벨에서 추상화가 됨.
     */
    @Autowired
    private AnswerDAOInter answerDAO;  

    
    @Override
    public int createAns(AnswerVO answerVO) {
        return answerDAO.createAns(answerVO);
    }


    @Override
    public AnswerVO getOneByFk(int qnano) {
        return answerDAO.getOneByFk(qnano);
    }


    @Override
    public AnswerVO getOneByPk(int answerno) {
        return answerDAO.getOneByPk(answerno);
    }


    @Override
    public int updateAns(AnswerVO answerVO) {
        return answerDAO.updateAns(answerVO);
    }


    @Override
    public int deleteAns(int answerno) {
        return answerDAO.deleteAns(answerno);
    }
    
    
    
}
