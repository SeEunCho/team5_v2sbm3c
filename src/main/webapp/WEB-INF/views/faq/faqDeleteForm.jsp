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
   
  <DIV class='menu_line'></DIV>
      <h1>FaQ 삭제 확인 창</h1>   
      <FORM name='frm' method='POST' action='/faq/${faqVO.faqno }/delete.do' class="form-horizontal">
        <input type="hidden" name="adminnid" value="1"> <%-- 관리자 개발후 변경 필요 --%>
        
        <div class="form-group">
           <label class="control-label col-md-2">제목</label>
           <div class="col-md-10">
             <input type='text' name='title' value='${faqVO.title }' required="required" 
                       autofocus="autofocus" class="form-control" style='width: 90%;'>
           </div>
        </div>
        <div class="form-group">
           <label class="control-label col-md-2">본문</label>
           <div class="col-md-10">
             <textarea name='text' required="required" class="form-control" rows="12" style='width: 90%;'>${faqVO.text }</textarea>
           </div>
        </div>

        <div class="content_body_bottom">
          <button type="submit" class="btn btn-primary">삭제</button>
          <button type="button" onclick="location='/'" class="btn btn-primary">취소</button>
        </div>
      
      <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
</body>
</html>

