<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>심슨네 가족</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script>
  // onLoad functions auto config 
  $(function () {
    
  });

/*   function openUpdateForm(faqno) {
   
      var url = '/faq/' + faqno + '/update.do';
      var win = window.open(url, 'FaA 게시글 업데이트', 'width=800px, height=820px');

      var x = (screen.width - 800) / 2;
      var y = (screen.height - 820) / 2;

      win.moveTo(x, y); // 화면 중앙으로 이동

      
      }

  function deleteFaq(faqno) {

      var url = '/faq/' + faqno + '/delete.do';
      var win = window.open(url, 'FaA 게시글 업데이트', 'width=500px, height=520px');

      var x = (screen.width - 500) / 2;
      var y = (screen.height - 520) / 2;

      win.moveTo(x, y); // 화면 중앙으로 이동

      } */


</script>
</head>

<body>
    
    <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
    <DIV class='title_line'> 자주묻는 질문(FAQ) </DIV>
    
    <DIV class='content_body'>
      <TABLE class='table table-striped'>
        <colgroup>
          <col style='width: 20%;'/>
          <col style='width: 20%;'/>
          <col style='width: 30%;'/>
          <col style='width: 15%;'/>
          <col style='width: 15%;'/>
        </colgroup>
       
        <thead>  
        <TR>
          <TH class="th_bs">제목</TH>
          <TH class="th_bs">본문</TH>
          <TH class="th_bs">생성(수정) 일자</TH>
          <TH class="th_bs">담당 관리자 번호</TH>
        <c:choose>
          <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
             <th class="th_bs">수정/삭제</th>       
          </c:when> 
            <c:otherwise>
              <th class="th_bs">비고</th>
             </c:otherwise>
        </c:choose> 
        </TR>
        </thead>
        
        <tbody> 
        <c:forEach var="faq" items="${lists }">
          <c:set var="title" value="${faq.title }" />
          <c:set var="text" value="${faq.text }" />
          <c:set var="cdate" value="${faq.cdate }" />
          <c:set var="adminid" value="${faq.adminid }"/>
          <c:set var="faqno" value="${faq.faqno }"></c:set>
          
          <TR>
            <TD class="td_bs"><a href="/faq/${faqno }/read.do">${title }</a></TD>
            <TD class="td_bs"><a href="/faq/${faqno }/read.do">${text }</a></TD>
            <TD class="td_bs"><a href="/faq/${faqno }/read.do">${cdate }</a></TD>
            <TD class="td_bs"><a href="/faq/${faqno }/read.do">${adminid }</a></TD>
            <c:choose><%-- 관리자만 수정 / 삭제 가능 --%>
               <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
                  <TD class="td_bs">
                <input type='hidden' value='${faqno }'>
                <a href="/faq/${faqno }/update.do"><IMG src='/faq/images/update.png' width = "20px" height="20px" title='수정'></a>
                <a href= "/faq/${faqno }/delete.do"><IMG src='/faq/images/delete.png'  width = "20px" height="20px" title='삭제'></a>
                  </TD>     
              </c:when> 
              <c:otherwise>
                <TD class="td_bs"><a href="/faq/${faqno }/read.do">-</a></TD>
              </c:otherwise>
            </c:choose>

          </TR>   
        </c:forEach>

        </tbody>
       
      </TABLE>
    </DIV>
    <hr>
    
     <div class="content_body_bottom">
        <button class="btn btn-primary btn-sm" onclick="location.href='/'">메인페이지</button>
            <c:choose>
               <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
                       <button class="btn btn-primary btn-sm" onclick="location.href='/faq'">FAQ 등록</button>
              </c:when> 
              <c:otherwise>
              </c:otherwise>
        </c:choose>
    </div><%-- 관리자만 등록 가능 --%>
    
     <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
</body>
</html>