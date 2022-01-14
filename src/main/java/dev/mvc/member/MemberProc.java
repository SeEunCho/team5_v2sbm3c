package dev.mvc.member;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {
    @Autowired
    private MemberDAOInter memberDAO;

    public MemberProc() {
        // System.out.println("-> MemberProc created.");
    }

    @Override
    public int checkID(String id) {
        int cnt = this.memberDAO.checkID(id);
        return cnt;
    }

    @Override
    public int checkEmail(String email) {
        int cnt = this.memberDAO.checkEmail(email);
        return cnt;
    }

    @Override
    public int create(MemberVO memberVO) {
        int cnt = this.memberDAO.create(memberVO);
        return cnt;
    }

    @Override
    public List<MemberVO> list() {
        List<MemberVO> list = this.memberDAO.list();
        return list;
    }

    @Override
    public MemberVO read(int memberid) {
        MemberVO memberVO = this.memberDAO.read(memberid);
        return memberVO;
    }

    @Override
    public MemberVO readById(String id) {
        MemberVO memberVO = this.memberDAO.readById(id);
        return memberVO;
    }

    @Override
    public int update(MemberVO memberVO) {
        int cnt = this.memberDAO.update(memberVO);
        return cnt;
    }

    @Override
    public int delete(int memberid) {
        int cnt = this.memberDAO.delete(memberid);
        return cnt;
    }
    
    @Override
    public int delete_update(int memberid) {
        int cnt = this.memberDAO.delete_update(memberid);
        return cnt;
    }

    @Override
    public int passwd_check(HashMap<Object, Object> map) {
        int cnt = this.memberDAO.passwd_check(map);
        return cnt;
    }

    @Override
    public int passwd_update(HashMap<Object, Object> map) {
        int cnt = this.memberDAO.passwd_update(map);
        return cnt;
    }

    @Override
    public int login(Map<String, Object> map) {
        int cnt = this.memberDAO.login(map);
        return cnt;
    }

    @Override
    public String find_id(String email) {
        String id = this.memberDAO.find_id(email);
        return id;
    }
    
    
    //비밀번호 찾기 이메일발송
    @Override
    public void sendEmail(MemberVO memberVO, String div) throws Exception {
        // Mail Server 설정
        String charSet = "utf-8";
        String hostSMTP = "smtp.gmail.com"; 
        String hostSMTPid = "team5manager0@gmail.com";
        String hostSMTPpwd = "admin54321!";

        // 보내는 사람 EMail, 제목, 내용
        String fromEmail = "team5manager0@gmail.com";
        String fromName = "team5";
        String subject = "";
        String msg = "";

        if(div.equals("find_pw")) {
            subject = "주택 매물시스템 임시 비밀번호 입니다.";
            msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
            msg += "<h3 style='color: blue;'>";
            msg += memberVO.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
            msg += "<p>임시 비밀번호 : ";
            msg += memberVO.getPasswd() + "</p></div>";
        }

        // 받는 사람 E-Mail 주소
        String mail = memberVO.getEmail();
        String name = memberVO.getName();
        try {
            HtmlEmail email = new HtmlEmail();
            email.setDebug(true);
            email.setCharset(charSet);
            email.setSSL(true);
            email.setHostName(hostSMTP);
            email.setSmtpPort(465); 

            email.setAuthentication(hostSMTPid, hostSMTPpwd);
            email.setTLS(true);
            email.addTo(mail, name);
            email.setFrom(fromEmail, fromName, charSet);
            email.setSubject(subject);
            email.setHtmlMsg(msg);
            email.send();
        } catch (Exception e) {
            System.out.println("메일발송 실패 : " + e);
        }
    }

    

    
}
