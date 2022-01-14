<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
<link href="/css/login_style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function () {
      $("#findpwBtn").click(function () {
        var id = $('#id').val();
        location.href = './find_pw.do?id=' + id;
      })

      $("#loginBtn").click(function () {
        var id = $('#id').val();
        location.href = './login.do?id=' + id;
      })

    });

</script> 

</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
  <!-- ******************** Modal 알림창 시작 ******************** -->
  <div id="modal_panel" class="modal fade"  role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
        </div>
        <div class="modal-footer">
          <button type="button" id="btn_close" data-focus="" class="btn btn-default" 
                      data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  <!-- ******************** Modal 알림창 종료 ******************** -->

  <DIV class='title_line'>아이디찾기 검색결과</DIV>
  
  <DIV class='content_body'>
    <input type='hidden' name='id' id='id' value="${ id }">
    <!-- <form name='frm' id='frm' method='POST' action="./find_id.do" class="form-horizontal"> -->
      <div class="wrap">
        <div class="login">
          <div class="login_id">
            <h4>고객님의 정보와 일치하는 아이디입니다.</h4>
            <input type="text" name='id' id='id' value="${ id }" readonly>
          </div>
          
          <div class="submit">
            <input type="button" id="loginBtn" value="LOGIN">
            <input type="button" id="findpwBtn" value="비밀번호찾기">
          </div>
          
          <div class="submit login_etc">
            <div class="join">
              <a style="font-size: 14px;"></a>
            </div>
          </div>
          
        </div>
      </div>
    <!-- </FORM> -->
  
  </DIV>
  <%-- <DIV class='content_body'> END --%>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 