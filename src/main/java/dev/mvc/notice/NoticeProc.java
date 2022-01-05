package dev.mvc.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


//Autowired 기능에의해 자동 할당될 때 사용되는 이름
@Component("dev.mvc.notice.NoticeProc")
public class NoticeProc implements NoticeProcInter{
    // DI: 객체가 필요한 곳에 객체를 자동으로 생성하여 할당
    // Autowired: DI 사용 선언
    // Spring이 자동으로 CategrpDAOInter를 구현하여 DAO class 생성후 객체를 만들어 할당
    @Autowired 
    private NoticeDAOInter noticeDAO;
   
    public NoticeProc() {
        System.out.println("-> NoticeProc created.");
    }
    
    @Override
    public int create(NoticeVO noticeVO) {
        int cnt = noticeDAO.create(noticeVO);

        return cnt;
    }
    
    @Override
    public List<NoticeVO> list() {
      List<NoticeVO> list = this.noticeDAO.list();
      return list;
    }
    
    @Override
    public NoticeVO read(int noticeno) {
        NoticeVO noticeVO = this.noticeDAO.read(noticeno);
        return noticeVO;
    }
    
    @Override
    public int update(NoticeVO noticeVO) {
        int cnt = this.noticeDAO.update(noticeVO);
        return cnt;
    }
    
    @Override
    public int delete(int noticeno) {
        int cnt = this.noticeDAO.delete(noticeno);
        return cnt;
    }




}
