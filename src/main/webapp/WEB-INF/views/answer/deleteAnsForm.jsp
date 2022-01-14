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

      <FORM name='frm' id='frm' method='POST' action='/answer/${answerVO.answerno}/delete.do' class="form-horizontal">
         <div class="content_body">
            <label class="col-md-2">관리자 답변</label>
              <div class="col-md-10">
                <div class="textarea_basic">
                      ${answerVO.answer}
                </div>
                    <label class="control-label"><br>답변일자: </label>
                      ${answerVO.adate}
              </div>
              <div class="content_body_bottom">
                    <button type="button" id="btn_send" class="btn btn-primary">답변삭제</button>
                    <button type="button" onclick="window.close()" class="btn btn-primary">창 닫기</button>
              </div>                  
          </div>
      </FORM>

    <jsp:include page="/WEB-INF/views/answer/mock_bottom.jsp" flush='false' />
    
  </body>
</html>
