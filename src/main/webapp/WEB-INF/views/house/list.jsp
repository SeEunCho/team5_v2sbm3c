<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="dev.mvc.house.HouseVO" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>주택 정보</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>        
       <A href="./create.do?houseno=${houseno }" title="등록"><span class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록하기</button></span></A>
    </FORM>
  </DIV>
    
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">주택명</TH>
      <TH class="th_bs">가격</TH>
      <TH class="th_bs">지목</TH>
      <TH class="th_bs">크기</TH>
      <TH class="th_bs">생성일</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <%
    %>
    <c:forEach var="houseVO" items="${list}">
      <c:set var="houseno" value="${houseVO.houseno }" />
      <c:set var="hname" value="${houseVO.hname }" />
      <c:set var="hdate" value="${houseVO.hdate.substring(0, 10) }" />
      <c:set var="price" value="${houseVO.price }" />
      <c:set var="area" value="${houseVO.area }" />
      <c:set var="nomination" value="${houseVO.nomination }" />
      <TR>
        <TD class="td_bs_left"><A href="/house/${houseno }/read.do">${hname }</A></TD>        
        <TD class="td_bs">${price }</TD>
        <TD class="td_bs">${nomination }</TD>
        <TD class="td_bs">${area }</TD>
        <TD class="td_bs">${hdate}</TD>
        
        <TD class="td_bs">
          <A href="./read_update.do?houseno=${houseno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?houseno=${houseno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
          <A href="./update_likes_up.do?likes=${likes }" title="좋아요"><span class="glyphicon glyphicon-arrow-up"></span></A>       
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

