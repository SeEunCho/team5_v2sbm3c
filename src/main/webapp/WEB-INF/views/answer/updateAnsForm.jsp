 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>http://localhost:9091/</title>
<style type="text/css">
  *{ font-family: Malgun Gothic; font-size: 26px;}
</style>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script type="text/javascript">
  $(function () {

    $('#btn_send').on('click', send);
  });
  

  function send() {
    if(confirm('수정하시겠습니까?') == true) {
      $('#frm').submit();
    }
  }


</script>

</head>
<body>

 <jsp:include page="/WEB-INF/views/answer/mock_top.jsp" flush='false' />


    <%-- 관리자 전용 답글 form --%>
    <FORM name='frm' id='frm' method='POST' action='/answer/${answerVO.answerno}/update.do' class="form-horizontal">
      <input type="hidden" name="adminid" value="${sessionScope.adminid}"> <%-- 관리자일 경우에만 답변등록 가능. --%>

      <div class="form-group">
         <label class="control-label col-md-2">답변</label>
         <div class="col-md-10">
           <textarea name='answer' required="required" class="form-control" rows="12" style='width: 90%;'>${answerVO.answer}</textarea>
         </div>
      </div>
      
      <div class="content_body_bottom">
        <button type="button" id="btn_send" class="btn btn-primary">수정</button>
        <button type="button" onclick="window.close()" class="btn btn-primary">창 닫기</button>
      </div>
    </FORM>
 
 

    
  <jsp:include page="/WEB-INF/views/answer/mock_bottom.jsp" flush='false' />
  
</body>
</html>

 