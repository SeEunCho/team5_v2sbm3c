 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>심슨네 가족</title>
<style type="text/css">
  *{ font-family: Malgun Gothic; font-size: 26px;}
</style>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
 
     <DIV class='title_line'>자주묻는 질문(FAQ)</DIV>
            <input type="hidden" name="adminnid" value="1"> <%-- 관리자 개발후 변경 필요 --%>
            
            <div class="form-group">
               <label class="control-label col-md-2">제목</label>
               <div class="col-md-10">
                ${faqVO.title}
               </div>
            </div>
            <div class="form-group">
               <label class="control-label col-md-2">본문</label>
               <div class="col-md-10">
                  <div class="textarea_basic">
                   ${faqVO.text}
                 </div>
               </div>
            </div>
    
            <div class="content_body_bottom">
              <button type="button" onclick="location.href='/faqlist'" class="btn btn-primary">목록</button>
            </div>
 
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 