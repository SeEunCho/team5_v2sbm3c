<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top_img'>
    <DIV class='top_menu_label'>주택 매물시스템</DIV>
    <NAV class='top_menu'>
      <span style='padding-left: 0.5%;'></span>
      <span class='menu_link'>개인 팝업 창</span> 
      
    </NAV>
  </DIV>
     
  <%-- 내용 --%> 
  <DIV class='content'>


<!-- isadmin check Form -->

<!--   
                <c:choose>
               <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
                
              </c:when> 
              <c:otherwise>
              </c:otherwise>
            </c:choose> -->