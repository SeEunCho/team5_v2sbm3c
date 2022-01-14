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

<style>
  .btn-primary {
    color: #fff;
    background-color: #2c3e50;
    border-color: #2c3e50;
    margin: 10px;
  }
  
  a {
  text-decoration: none;
  color: black;
  }

  .wrap {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    /* background: rgba(0, 0, 0, 0.1); */
  }

  .login {
    width: 50%;
    height: 500px;
    background: white;
    border-radius: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }

  .login_id {
    margin-top: 20px;
    width: 80%;
  }

  .login_id input {
    width: 100%;
    height: 50px;
    border-radius: 30px;
    margin-top: 10px;
    padding: 0px 20px;
    border: 1px solid lightgray;
    outline: none;
  }

  .login_pw {
    margin-top: 20px;
    width: 80%;
  }

  .login_pw input {
    width: 100%;
    height: 50px;
    border-radius: 30px;
    margin-top: 10px;
    padding: 0px 20px;
    border: 1px solid lightgray;
    outline: none;
  }

  .login_etc {
    padding: 10px 0px;
    width: 80%;
    font-size: 14px; 
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
  }

  .submit {
    margin-top: 40px;
    width: 80%;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .submit input {
  width: 100%;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: #2c3e50;
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
  cursor: pointer;
  } 

  .submit input:hover {
    background-color: #337ab7;
  }

</style>
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

  // 회원 가입  
  function create() {
    location.href="./create.do";
  }

  // 테스트용 기본값 로딩
  function loadDefault() {
    $('#id').val('user1');
    $('#passwd').val('1234');
  }
    
</script> 

</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>로그인</DIV>
  
  <DIV class='content_body'>
    <FORM name='frm' method='POST' action='./login.do' class="form-horizontal">
      <input type='hidden' name='param_id' id='param_id' value="${ param.id }">
      <div class="wrap">
        <div class="login">
          <div class="login_id">
            <h4>ID</h4>
            <input type="text" name='id' id='id' required="required" placeholder="ID" autofocus="autofocus">
          </div>
          <div class="login_pw">
            <h4>Password</h4>
            <input type="password" name='passwd' id='passwd' required="required" placeholder="Password"
              autofocus="autofocus">
          </div>
          <div class="login_etc">
            <div class="check">
              <input type="checkbox" name="" id="">
              Remember Me?
            </div>
            <div class="forgot">
              <IMG src='/member/images/lock.png' width = "18px" height="18px">
              <a href="./find_id.do" style="font-size: 14px;">아이디</a>
              <a style="font-size: 14px;">·</a>
              <a href="" style="font-size: 14px;">비밀번호 찾기</a>
            </div>
            
          </div>
          <div class="submit">
            <input type="submit" value="LOGIN">
          </div>

          <div class="submit login_etc">
            <div class="join">
              <a href="./create.do" style="font-size: 14px;">회원가입</a>
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
 