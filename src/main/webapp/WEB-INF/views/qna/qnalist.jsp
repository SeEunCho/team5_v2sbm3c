<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>구해줘! 홈즈</title>
<link rel="icon" href="/images/house_pavicon.png">

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head>
<body>

<jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />

    <!-- 이것 하나 하려고 Join을 써야할까??  -->
    <%-- <DIV class='title_line'> <i>${memberVO.name }</i> 님 QnA 조회 </DIV> --%>
     <DIV class='title_line'>My QnA 조회 </DIV>

        <ASIDE class="aside_right">
          <A href="javascript:location.reload();">새로고침</A> 
        </ASIDE> 

        <div class='menu_line'></div>
        <br>
    
    <DIV class='content_body'>
      <TABLE class='table table-striped'>
        <colgroup>
          <col style='width: 10%;'/>
          <col style='width: 10%;'/>
          <col style='width: 35%;'/>
          <col style='width: 15%;'/>    
          <col style='width: 10%;'/>
          <col style='width: 20%;'/>
        </colgroup>
       
        <thead>  
        <TR>
          <TH class="th_bs">QnA<br> 이름 </TH>
          <TH class="th_bs">본문</TH>
          <TH class="th_bs">문의 날짜</TH>
          <TH class="th_bs">회원 PK</TH>
          <TH class="th_bs">공개 글<br> 여부</TH>
          <TH class="th_bs">수정 / 삭제</TH>
        </TR>
        </thead>
        
       <tbody> 
        <c:forEach var="qna" items="${lists }">
          <c:set var="qnano" value="${qna.qnano }"></c:set>
          <c:set var="title" value="${qna.title }" />
          <c:set var="text" value="${qna.text }" />
          <c:set var="qdate" value="${qna.qdate }" />
          <c:set var="memberid" value="${qna.memberid }"/>
          <c:set var="secret" value="${qna.secret }"></c:set>
          
          <TR>
            <TD class="td_bs"><a href="/qna/${qnano }/read.do">${title }</a></TD>
            <TD class="td_bs"><a href="/qna/${qnano }/read.do">${text }</a></TD>
            <TD class="td_bs"><a href="/qna/${qnano }/read.do">${qdate }</a></TD>
            <TD class="td_bs"><a href="/qna/${qnano }/read.do">${memberid }</a></TD>
            <TD class="td_bs"><a href="/qna/${qnano }/read.do">${secret }</a></TD>
            <TD class="td_bs">
                <input type='hidden' value='${qnano }'>
                <a href="/qna/${qnano }/update.do"><IMG src='/qna/images/update.png' width = "20px" height="20px" title='수정'></a>
                <a href= "/qna/${qnano }/delete.do"><IMG src='/qna/images/delete.png'  width = "20px" height="20px" title='삭제'></a>
            </TD>         
          </TR>   
        </c:forEach>
        </tbody>       
      </TABLE>
    </DIV>
    <hr>
    
     <div class="content_body_bottom">
        <button class="btn btn-primary btn-sm" onclick="location.href='/'">메인페이지</button>
        <button class="btn btn-primary btn-sm" onclick="location.href='/qna'">QnA 등록</button>
    </div>
    
<jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
 
</body>
</html>

