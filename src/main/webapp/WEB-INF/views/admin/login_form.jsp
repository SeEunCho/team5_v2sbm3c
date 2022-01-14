<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title></title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link href="/css/login_style.css" rel="Stylesheet" type="text/css">

<script type="text/javascript">
  $(function() {
    $('#btn_create').on('click', create);
    $('#btn_loadDefault').on('click', loadDefault);
    
    if ($('#param_id').val() != ''){
      var id = $('#param_id').val();
			$('#id').val(id);
      $('#passwd').focus();
		}
  });
    
</script> 

</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>관리자 로그인</DIV>
  
  <DIV class='content_body'>
    <FORM name='frm' method='POST' action='./login.do' class="form-horizontal">
      <input type="hidden" name="return_url" value="${return_url}">
      <input type='hidden' name='param_id' id='param_id' value="${ param.id }">
      
      <div class="wrap">
        <div class="login">
          <div class="login_id">
            <h4>ID</h4>
            <input type="text" name='id' id='id' value='${ck_id }' required="required" placeholder="ID" autofocus="autofocus">
          </div>
          <div class="login_pw">
            <h4>Password</h4>
            <input type="password" name='passwd' id='passwd' value='${ck_passwd }' required="required" placeholder="Password"
              autofocus="autofocus">
          </div>
          <div class="login_etc">
            <div class="check">
              <%-- <input type="checkbox" name='id_passwd_save' value='Y' ${ck_id_passwd_save == 'Y' ? "checked='checked'" : "" }>
              Remember Me? --%>
            </div>
            <div class="forgot">
              <!-- <IMG src='/member/images/lock.png' width = "18px" height="18px">
              <a href="./find_id.do" style="font-size: 14px;">아이디</a>
              <a style="font-size: 14px;">·</a>
              <a href="./find_pw.do" style="font-size: 14px;">비밀번호 찾기</a> -->
            </div>
            
          </div>
          <div class="submit">
            <input type="submit" value="LOGIN">
          </div>

          <div class="submit login_etc">
            <div class="join">
              <!-- <a href="./create.do" style="font-size: 14px;">회원가입</a> -->
            </div>
          </div>
          


          
        </div>
      </div>
    </FORM>
  
    <!-- <button type='button' id='btn_create' class="btn btn-primary btn-md">회원가입</button>
    <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button> -->
  </DIV>
  <%-- <DIV class='content_body'> END --%>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 