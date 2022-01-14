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
  $(function() {
    $('#findBtn').on('click', find);
    $('#CancelBtn').on('click', cancel);

    if($('#code').val() == "find_id_fail"){
      msg = '가입된 아이디가 없습니다.<br>';

      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('아이디찾기 결과'); // 제목 
      $('#modal_content').html(msg); // 내용
      $('#modal_panel').modal(); // 다이얼로그 출력
      
    }
  });

  function find(){
      var email = $('#email').val();
      var msg = '';

      if (email == ""){
        // alert("Email을 입력해주세요.");
        msg = 'Email을 입력해주세요.<br>';

        $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
        $('#modal_title').html('아이디 찾기'); // 제목 
        $('#modal_content').html(msg); // 내용
        $('#modal_panel').modal(); // 다이얼로그 출력
        $('#email').focus();

        return false; // submit 중지
		  }

      $('#frm').submit();
  }

  function cancel(){
    location.href='./login.do';
  }

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
  <DIV class='title_line'>아이디찾기</DIV>
  <input type='hidden' name='code' id='code' value="${param.code}">
  
  <DIV class='content_body'>
    <form name='frm' id='frm' method='POST' action="./find_id.do" class="form-horizontal">
      <div class="wrap">
        <div class="login">
          <div class="login_id">
            <h4>Email</h4>
            <input type="text" name='email' id='email' required="required" placeholder="abc@mail.com" autofocus="autofocus">
          </div>
          
          <div class="submit">
            <input type="button" id="findBtn" value="Find">
            <input type="button" id="CancelBtn" value="Cancel">
          </div>
          
          <div class="submit login_etc">
            <div class="join">
              <a style="font-size: 14px;"></a>
            </div>
          </div>
          
        </div>
      </div>
    </FORM>
  
  </DIV>
  <%-- <DIV class='content_body'> END --%>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 