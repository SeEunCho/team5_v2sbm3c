<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>http://localhost:9091/</title>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
 
 <DIV class='title_line'>질문 등록하기</DIV>
        
      <FORM name='frm' method='POST' action='/qna' class="form-horizontal">
        <input type="hidden" name="adminnid" value="1"> <%-- 관리자 개발후 변경 필요 --%>
        
        <div class="form-group">
           <label class="control-label col-md-2">제목</label>
           <div class="col-md-10">
             <input type='text' name='title' value='제목 작성란' required="required" 
                       autofocus="autofocus" class="form-control" style='width: 90%;'>
           </div>
        </div>
       
       
      <div class="form-group">
           <label class="control-label col-md-2">질문 카테고리 선택</label>
           <div class="col-md-10">
               <select name="qcateno"> <%-- db에서 동적으로 카테고리 선택 --%>
                   <c:forEach var="qnacateVO" items="${list }" varStatus="info">
                    <option value="${qnacateVO.qcateno }" ${qnacateVO.name=='상품' ? "selected='selected'" : "" } >${qnacateVO.name }</option>
                   </c:forEach>   
              </select>
           </div>
        </div>  

        <div class="form-group">
           <label class="control-label col-md-2">본문</label>
           <div class="col-md-10">
             <textarea name='text' required="required" class="form-control" rows="12" style='width: 90%;'>본문 작성란</textarea>
           </div>
        </div>
        
         <div class="form-group"> 
           <label class="control-label col-md-2">비밀글 </label>
           <div class="col-md-10">
           <IMG src='/member/images/lock.png' width = "18px" height="18px">
            <input type="radio" name="secret" value="N" checked="checked">NO
            <input type="radio" name="secret" value="Y">YES
           </div>
        </div>
        
        <div class="content_body_bottom">
          <button type="submit" class="btn btn-primary">등록</button>
          <button type="button" onclick="history.back()" class="btn btn-primary">뒤로가기</button>
        </div>
      </FORM>
      
      <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
</body>
</html>