<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script type="text/javascript">
        window.onload = function() {
            
        }
        
        function chatting(){
          var url = 'http://3.129.18.217:8000/ais/chatbot/chatting/';
          var win = window.open(url, '챗봇', 'width=700px, height=630px');
          
          var x = (screen.width - 700) / 2;
          var y = (screen.height - 630) / 2;
          
          win.moveTo(x, y); // 화면 중앙으로 이동
        }

        function recommend(){
            var url = 'http://3.129.18.217:8000/recommend_house/start/';
            var win = window.open(url, 'AI 서비스', 'width=1000px, height=800px');
            
            var x = (screen.width - 1000) / 2;
            var y = (screen.height - 800) / 2;
            
            win.moveTo(x, y); // 화면 중앙으로 이동
        }
</script>
<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top_img'>
    <DIV class='top_menu_label'><A  href='/' style="color: white;"><img src="/images/logo.PNG" width="200px" height="100px"></A></DIV>
    <div style="text-align:center; color: white;" ><h1 style="font-size: 36px; color: white; margin-top: 20px; margin-bottom: 10px;">당신의 집, 우리가 구해드립니다!</h1></div>
    <NAV class='top_menu'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link'  href='/'>HOME</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/notice/list.do'>공지사항</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/trend/chart.do'>공공데이터 통계</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='javascript: recommend()'>주택 추천</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='javascript: chatting()'>챗봇 서비스</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/trend/news.do'>트렌드 분석</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/faqlist'>자주묻는 질문(FAQ)</A><span class='top_menu_sep'> </span>

      <c:choose>
        <c:when test="${sessionScope.id != null && !sessionScope.admin_flag == true}"> <%-- "회원" 로그인 한 경우 --%>
            <A class='menu_link'  href='/qnalist'>My Q/A</A><span class='top_menu_sep'> </span>
        </c:when>
        <c:otherwise> <%-- 로그인 하지 않은경우 표시 x --%>
            <span></span>
        </c:otherwise>
      </c:choose>
      
       <c:choose>
        <c:when test="${sessionScope.id != null}"> <%-- 로그인 한 경우 --%>
           <c:choose>
                <c:when test="${sessionScope.admin_flag == true}">  <%-- 관리자 로그인 --%>
                  <A class='menu_link'  href='/member/list_by_search_paging.do' >회원관리</A><span class='top_menu_sep'> </span>
                                 관리자 [ ${sessionScope.id } ] <A class='menu_link'  href='/member/logout.do' >Logout</A><span class='top_menu_sep'> </span> 
                </c:when>
                
                <c:otherwise> <%-- 회원 로그인 --%>
                  <A class='menu_link'  href='/member/read.do' onclick="location.href=this.href+'?memberid='+${sessionScope.memberid };return false;" >My Page</A><span class='top_menu_sep'> </span>
                  [ ${sessionScope.id } ] <A class='menu_link'  href='/member/logout.do' >Logout</A><span class='top_menu_sep'> </span> 
                </c:otherwise>
           </c:choose>
        </c:when>
        
        <c:otherwise>
          <A class='menu_link'  href='/admin/login.do'>관리자 로그인</A><span class='top_menu_sep'> </span>
          <A class='menu_link'  href='/member/login.do' >Login</A><span class='top_menu_sep'> </span>   
        </c:otherwise>
      </c:choose>
        
      <c:choose> 
        <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
            <div id="menu">
              <ul>
                <li><a href="/" class='link_menu_top'>홈페이지 관리</a>
                      <ul>
                          <li><a href='/member/list_by_search_paging.do' class='link_menu_sub'>회원관리</a></li>
                          <li><a href='/notice/list.do' class='link_menu_sub'>공지사항 관리</a></li>
                          <li><a href='/qnacatelist' class='link_menu_sub'>QnA 관리</a></li>
                          <li><a href='/house/list.do' class='link_menu_sub'>주택매물 관리</a></li>
                      </ul>
                  </li>
              </ul>
            </div>
        </c:when>
        <c:otherwise> <%-- 관리자로 로그인 하지 않은경우 표시 x --%>
          <span></span>
        </c:otherwise>
      </c:choose>
      
    </NAV>
  </DIV>
     
  <%-- 내용 --%> 
  <DIV class='content'>


<!-- isadmin check Form -->

<%--
        <c:choose>
       <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
        
      </c:when> 
      <c:otherwise>
      </c:otherwise>  
              --%>


