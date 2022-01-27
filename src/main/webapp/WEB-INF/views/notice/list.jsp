<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dev.mvc.notice.NoticeVO" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>구해줘! 홈즈</title>
<link rel="icon" href="/images/house_pavicon.png">
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>공지사항</DIV>

<DIV class='content_body'>
<ASIDE class="aside_right">
    <c:choose>
    <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
        <A href="./create.do">등록</A>
        <span class='menu_divide' >│</span>
        <A href="javascript:location.reload();">새로고침</A>
        <span class='menu_divide' >│</span>
    </c:when>
    </c:choose>
  </ASIDE> 

  <div class='menu_line'></div>
    
  <TABLE class='table table-hover'>
    <colgroup>
      <col style='width: 20%;'/>
      <col style='width: 40%;'/>
<%--       <col style='width: 40%;'/> --%>
      <col style='width: 20%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">번호</TH>
      <TH class="th_bs">제목</TH>
<!--       <TH class="th_bs">내용</TH> -->
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
   
    <c:forEach var="noticeVO" items="${list}">
      <c:set var="noticeno" value="${noticeVO.noticeno }" />
      <c:set var="adminid" value="${noticeVO.adminid }" />
      <c:set var="noticetitle" value="${noticeVO.noticetitle }" />
    <c:set var="noticecontent" value="${noticeVO.noticecontent }" />
      <c:set var="rdate" value="${noticeVO.rdate.substring(0, 10) }" />
      <TR>
        <TD class="td_bs">${noticeno }</TD>
        <TD class="td_bs_left"><A href="../notice/read.do?noticeno=${noticeno }">${noticetitle }</A></TD>
        <%-- <TD class="td_bs_left"><A href="../notice/read.do?noticeno=${noticeno }">${noticecontent }</A></TD> --%>
        <TD class="td_bs">${rdate}</TD>

        <c:choose>
         <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true}">
           <TD class="td_bs">
            <A href="./read_update.do?noticeno=${noticeno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
            <A href="./read_delete.do?noticeno=${noticeno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
          </TD> 
        </c:when> 
          <c:otherwise>
            <TD class="td_bs">--</TD>            
          </c:otherwise> 
        </c:choose> 
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

