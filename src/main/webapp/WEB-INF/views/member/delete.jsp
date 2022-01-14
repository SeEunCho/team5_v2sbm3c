<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title></title>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style>
  .btn-primary {
    color: #fff;
    background-color: #2c3e50;
    border-color: #2c3e50;
  }
  
  .btn-info {
    color: #fff;
    background-color: #3498db;
    border-color: #3498db;
  }
</style>

<script type="text/javascript">
  $(function () {
      $('#member_withdrawal').on('click', member_send);
      $('#admin_withdrawal').on('click', admin_send);
    });

    function member_send() {
      location.href = '/member/logout.do';
      $('#frm').submit();
    }

    function admin_send() {
      $('#frm').submit();
    }

</script> 

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
    ${title}
    ${memberVO.memberid}
  </DIV>

  <DIV class='content_body'>
    <!-- <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./list.do'>목록</A>
    </ASIDE> 
   
    <div class='menu_line'></div> -->
   
    <DIV class='message'>
      <FORM name='frm' id='frm' method='POST' action='./delete.do'>
        <input type='hidden' name='memberid' id='memberid' value='${memberVO.memberid}'>
        <c:choose>
          <c:when test="${sessionScope.id != null}"><%-- 로그인 한 경우 --%>
              <c:choose>
                <c:when test="${sessionScope.admin_flag == true}"><%-- 관리자 로그인 --%>
                    '${memberVO.name }(${memberVO.id })' 회원을 삭제하시겠습니까?<br><br>
                    <button type="button" id='admin_withdrawal' class="btn btn-primary">삭제</button>
                    <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">취소(목록)</button>
                </c:when>
                <c:otherwise><%-- 회원 로그인 --%>
                    '${memberVO.name }(${memberVO.id })' 회원님 탈퇴하시겠습니까?<br><br>
                    <button type="button" id='member_withdrawal' class="btn btn-primary">탈퇴</button>
                    <button type="button" onclick="location.href='/'" class="btn btn-primary">취소</button>
    
                </c:otherwise>
              </c:choose>
          </c:when>
        </c:choose>
    
      </FORM>
    </DIV>
  </DIV> <%--  <DIV class='content_body'> END --%>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>