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
 
     <DIV class='title_line'>자주묻는 질문(FAQ)</DIV><br><br>

            
         <DIV style="width: 60%; height: 260px; float: left; margin-right: 10px; margin-bottom: 30px;">
         <span style="font-size: 1.5em; font-weight: bold;">${faqVO.title }</span><br><br>
          <span style="font-size: 1.2em; font-weight: mideum;">${faqVO.text}</span><br>
         </DIV>
    
            <div class="content_body_bottom">
              <button type="button" onclick="location.href='/faqlist'" class="btn btn-primary">목록</button>
            </div>
 
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 