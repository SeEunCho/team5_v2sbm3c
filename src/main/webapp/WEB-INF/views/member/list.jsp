<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title></title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- <script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<script type="text/javascript" src="https://www.google-analytics.com/analytics.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" integrity="sha384-7ynz3n3tAGNUYFZD3cWe5PDcE36xj85vyFkawcF6tIwxvIecqKvfwLiaFdizhPpN" crossorigin="anonymous">

<style>
  
</style>
<script type="text/javascript">
  $(function(){
 
  });
</script>
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
        회원목록
  </DIV>

  <DIV class='content_body'>

    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./list.do'>목록</A>
      <!-- <span class='menu_divide' >│</span>
      <A href='./create.do'>탈퇴회원</A> -->
    </ASIDE> 
   
    <div class='menu_line'></div>
    
    <table class="table table-hover" style='width: 100%;'>
      <colgroup>
        <col style='width: 5%;' />
        <col style='width: 10%;' />
        <col style='width: 10%;' />
        <col style='width: 10%;' />
        <col style='width: 15%;' />
        <col style='width: 30%;' />
        <col style='width: 10%;' />
        <col style='width: 10%;' />
      </colgroup>
      <thead>
        <tr>
          <TH scope="col" style="text-align:center">번호</TH>
          <TH scope="col" style="text-align:center">ID</TH>
          <TH scope="col" style="text-align:center">성명</TH>
          <TH scope="col" style="text-align:center">이메일</TH>
          <TH scope="col" style="text-align:center">전화번호</TH>
          <TH scope="col" style="text-align:center">주소</TH>
          <TH scope="col" style="text-align:center">탈퇴여부</TH>
          <TH scope="col" style="text-align:center">기타</TH>
        </tr>
      </thead>
      
    <c:forEach var="memberVO" items="${list }">
      <c:set var="memberid" value ="${memberVO.memberid}" />
      <c:set var="id" value ="${memberVO.id}" />
      <c:set var="name" value ="${memberVO.name}" />
      <c:set var="email" value ="${memberVO.email}" />
      <c:set var="phone" value ="${memberVO.phone}" />
      <c:set var="address" value ="${memberVO.address}" />
      <c:set var="grade" value ="${memberVO.grade}" />
       
    <TR>
      <TD class=td_basic>${memberid}</TD>
      <TD class='td_left'><A href="./read.do?memberid=${memberid}">${id}</A></TD>
      <TD class='td_basic'>${name}</TD>
      <TD class='td_basic'>${email}</TD>
      <TD class='td_basic'>${phone}</TD>
      <TD class='td_left'>
        <c:choose>
          <c:when test="${address.length() > 18 }"> <!-- 긴 주소 처리 -->
            ${address.substring(0, 18) }...
          </c:when>
          <c:otherwise>
            ${address}
          </c:otherwise>
        </c:choose>
      </TD>
      <TD class='td_basic'>
        <c:choose>
          <c:when test="${grade == 99}"> <!-- 탈퇴회원 -->
            Y
          </c:when>
          <c:otherwise>
            N
          </c:otherwise>
        </c:choose>
      </TD>
      <TD class='td_basic' style="margin: 0px;">
          <A href="./passwd_update.do?memberid=${memberid}"><IMG src='/member/images/passwd.png' width = "20px" height="20px" title='패스워드 변경'></A>
          <A href="./read.do?memberid=${memberid}"><IMG src='/member/images/update.png' width = "20px" height="20px" title='수정'></A>
          <c:choose>
          <c:when test="${grade == 99}"> <!-- 탈퇴회원 -->
          </c:when>
          <c:otherwise>
            <A href="./delete.do?memberid=${memberid}"><IMG src='/member/images/delete.png' width = "20px" height="20px" title='삭제'></A>
          </c:otherwise>
        </c:choose>
          
      </TD>
      
    </TR>
    </c:forEach>
    
  </TABLE>
</div>

  <DIV class='bottom_menu'>
    <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-sm">등록</button>
    <button type='button' onclick="location.reload();" class="btn btn-primary btn-sm">새로 고침</button>
  </DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>