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

 <DIV class='title_line'> 서울시 아파트 실거래가 데이터</DIV><br>

     <ASIDE class="aside_right">
      <A href='/api/call.do'>Daum 지도로 다시검색</A>
    </ASIDE> 
   
    <div class='menu_line'></div><br>

  <c:choose>
   <c:when test="${singleApiVO != null && month != nll && year != null}">
     <div class="container" style="text-align: center;"> <h3>서울시 ${singleApiVO.name}의 ${year}년 ${month}월 아파트 실거래정보 입니다.</h3></div>
     <div class="container" style="text-align: center;"> <span style="font-size: xx-small;">다른 거래정보를 검색하시려면 우측 상단의 다시검색을 눌러주세요.</span></div><br>
   </c:when>
   <c:otherwise>
     
   </c:otherwise>
 </c:choose>

   <DIV class='content_body'>

    
    <table class="table table-hover" style='width: 100%;'>
      <colgroup>
        <col style='width: 10%;' />
        <col style='width: 30%;' />
        <col style='width: 10%;' />
        <col style='width: 20%;' />
        <col style='width: 10%;' />
        <col style='width: 10%;' />
        <col style='width: 10%;' />
      </colgroup>
      <thead>
        <tr>
          <TH scope="col" style="text-align:center">번호</TH>
          <TH scope="col" style="text-align:center">이름</TH>
          <TH scope="col" style="text-align:center">전용면적</TH>
          <TH scope="col" style="text-align:center">거래가격</TH>
          <TH scope="col" style="text-align:center">거래년도</TH>
          <TH scope="col" style="text-align:center">거래 월</TH>
          <TH scope="col" style="text-align:center">건축년도</TH>
        </tr>
      </thead>
      
    <c:forEach var="node" items="${houseList }" varStatus="status">
      <c:set var="houseno" value ="${node.houseno}" />
      <c:set var="name" value ="${node.name}" />
      <c:set var="area" value ="${node.area}" />
      <c:set var="amount" value ="${node.amount}" />
      <c:set var="year" value ="${node.year}" />
      <c:set var="month" value ="${node.month}" />
      <c:set var="cyear" value ="${node.cyear}" />
       
    <TR>
      <TD class=td_basic><A href="/api/${houseno}/read.do" target="_blank">${status.index + 1}</A></TD>
      <TD class='td_left'>
        <c:choose>
          <c:when test="${name.length() > 30 }"> <!-- 긴 주소 처리 -->
            <A href="/api/${houseno}/read.do" target="_blank">${name.substring(0, 30) }...</A>
          </c:when>
          <c:otherwise>
             <A href="/api/${houseno}/read.do" target="_blank">${name }</A>
          </c:otherwise>
        </c:choose>
      </TD>   
      <TD class=td_basic><A href="/api/${houseno}/read.do" target="_blank">${area} m²</A></TD>
      <TD class='td_basic'><A href="/api/${houseno}/read.do" target="_blank">${amount} (만원)</A></TD>
      <TD class='td_basic'><A href="/api/${houseno}/read.do" target="_blank">${year}</A></TD>
      <TD class='td_basic'><A href="/api/${houseno}/read.do" target="_blank">${month}</A></TD>
      <TD class='td_basic'><A href="/api/${houseno}/read.do" target="_blank">${cyear}</A></TD>
    </TR>
    </c:forEach>  
  </TABLE>
</div>

  <DIV class='bottom_menu'>
    <button type='button' onclick="location.href='/'" class="btn btn-primary btn-sm">메인페이지로</button>
  </DIV>
    
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 