<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
  }
  
  .btn-info {
    color: #fff;
    background-color: #3498db;
    border-color: #3498db;
  }
</style>

<script type="text/javascript">
  var code ="";
  $(function () { // 자동 실행
      
      $('#btn_checkEmail').on('click', checkEmail);
      $('#btn_checkID').on('click', checkID);

      $('#btn_DaumPostcode').on('click', DaumPostcode); // 다음 우편 번호
      $('#btn_auth').on('click', code_auth); // 인증메일 발송
      $('#btn_close').on('click', setFocus); // Dialog창을 닫은후의 focus 이동
      $('#btn_send').on('click', send);
      
      $(document).on("click", "#btn_authEmail", function(){ // 이메일 인증 버튼
	      //alert($(this).attr("value"));
        //alert(email_duplicate);
        var frm = $('#frm'); // id가 frm인 태그 검색
        var email = $('#email', frm).val(); // frm 폼에서 id가 'email'인 태그 검색
        
        $.ajax({
          type: "GET",
          url: "./mail_auth.do?sm_email="+email,
          cache: false,
          success: function (data) {
            // console.log(data);
            msg = '· '+email+'로 인증메일이 전송되었습니다.<br>· 인증코드를 입력해주세요.<br>';
            code = data;

            $('#modal_content').attr('class', 'alert alert-info'); // Bootstrap CSS 변경
            $('#modal_title').html('Email 인증'); // 제목 
            $('#modal_content').html(msg);      // 내용
            $('#modal_input').html('<input type="text" class="form-control" placeholder="Code" id="auth_code">');
            $('#modal_input').show();
            $('#btn_auth').show();
            $('#btn_close').attr("data-focus", "email");  // 닫기 버튼 클릭시 email 입력으로 focus 이동
            $('#modal_panel').modal();               // 다이얼로그 출력
          }
        });

        
      });

      $('#phone').keyup(function (event) { // 전화번호 자동 하이픈(-)
        event = event || window.event;
        var _val = this.value.trim();
        this.value = autoHypenPhone(_val);
      });

      $('#passwd').keyup(function () { 
        $('#chkNotice').html('');
      });

      $('#passwd2').keyup(function () { // 패스워드 일치여부 확인
        if ($('#passwd').val() != '' && $('#passwd2').val() == '') {
          null;
          $('#passwd2_div').attr('class', 'col-md-10');
        } else if ($('#passwd').val() != '' && $('#passwd2').val() != '') {
          if ($('#passwd').val() != $('#passwd2').val()) {
            $('#chkNotice').html('패스워드가 일치하지 않습니다.<br>');
            $('#chkNotice').attr('style', 'color: #ff4114; font-size: 13px;');
            $('#passwd2_div').attr('class', 'col-md-10 has-error');
          } else {
            $('#chkNotice').html('패스워드가 일치합니다<br>');
            $('#chkNotice').attr('style', 'color: #126E82; font-size: 13px;');
            $('#passwd2_div').attr('class', 'col-md-10 has-success');
          }
        }
      });

    });
  
  var email_duplicate = false;
  function checkEmail() { // 이메일 중복확인

      var frm = $('#frm'); // id가 frm인 태그 검색
      var email = $('#email', frm).val(); // frm 폼에서 id가 'email'인 태그 검색
      var params = '';
      var msg = '';
      
      if ($.trim(email).length == 0) { // email를 입력받지 않은 경우
      msg = '· Email을 입력하세요.<br>· Email 입력은 필수 입니다.<br>';

      $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
      $('#modal_title').html('Email 중복 확인'); // 제목 
      $('#modal_content').html(msg);        // 내용
      $('#btn_close').attr("data-focus", "email");  // 닫기 버튼 클릭시 email 입력으로 focus 이동
      $('#modal_panel').modal();               // 다이얼로그 출력
      $('#modal_input').hide();
      $('#btn_auth').hide();
      return false;
    } else {  // when Email is entered
      params = 'email=' + email;

      $.ajax({
        url: './checkEmail.do', // spring execute
        type: 'get',  // post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function (rdata) { // 서버로부터 성공적으로 응답이 온경우
          var msg = "";

          if (rdata.cnt > 0) {
            $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
            msg = "이미 사용중인 Email 입니다.";
            $('#btn_close').attr("data-focus", "email");  // email 입력으로 focus 이동
            $('#btn_authEmail').hide();
            email_duplicate = false;
          } else {
            $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap CSS 변경
            msg = "사용 가능한 Email 입니다.";
            $('#btn_close').attr("data-focus", "id");  // id 입력으로 focus 이동
            email_duplicate = true;
            // $.cookie('checkId', 'TRUE'); // Cookie 기록
            $("#btn_authEmail").show();
          }
          $('#modal_title').html('Email 중복 확인'); // 제목 
          $('#modal_content').html(msg);        // 내용
          $('#modal_panel').modal();              // 다이얼로그 출력
          $('#modal_input').hide();
          $('#btn_auth').hide();
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function (request, status, error) { // callback 함수
          console.log(error);
        }
      });
    }
      

    }
  
  function checkID() { // ID 중복확인

      var frm = $('#frm'); // id가 frm인 태그 검색
      var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
      var params = '';
      var msg = '';

      if ($.trim(id).length == 0) { // id를 입력받지 않은 경우
        msg = '· ID를 입력하세요.<br>· ID 입력은 필수 입니다.<br>· ID는 3자이상 권장합니다.';

        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('ID 중복 확인'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "id");  // 닫기 버튼 클릭시 id 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        $('#btn_auth').hide();
        return false;
      } else {  // when ID is entered
        params = 'id=' + id;

        $.ajax({
          url: './checkID.do', // spring execute
          type: 'get',  // post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function (rdata) { // 서버로부터 성공적으로 응답이 온경우
            var msg = "";

            if (rdata.cnt > 0) {
              $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
              msg = "이미 사용중인 ID 입니다.";
              $('#btn_close').attr("data-focus", "id");  // id 입력으로 focus 이동
              $("#idDoubleChk").val("false");
            } else {
              $('#modal_content').attr('class', 'alert alert-success'); // Bootstrap CSS 변경
              msg = "사용 가능한 ID 입니다.";
              $('#btn_close').attr("data-focus", "passwd");  // passwd 입력으로 focus 이동
              $("#idDoubleChk").val("true");
              // $.cookie('checkId', 'TRUE'); // Cookie 기록
            }

            $('#modal_title').html('ID 중복 확인'); // 제목 
            $('#modal_content').html(msg);        // 내용
            $('#modal_panel').modal();              // 다이얼로그 출력
            $('#modal_input').hide();
            $('#btn_auth').hide();
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function (request, status, error) { // callback 함수
            console.log(error);
          }
        });
      }
    }

  
	function autoHypenPhone(str) { // 전화번호 자동 하이픈(-)
		//console.log(str);
		str = str.replace(/[^0-9]/g, '');
		var tmp = '';
		if (str.length < 4) {
			return str;
		} else if (str.length < 7) {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3);
			return tmp;
		} else if (str.length < 11) {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 3);
			tmp += '-';
			tmp += str.substr(6);
			return tmp;
		} else {
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 4);
			tmp += '-';
			tmp += str.substr(7);
			return tmp;
		}
		return str;
	}
    

	function setFocus() { // focus 이동
		// console.log('btn_close click!');

		var tag = $('#btn_close').attr('data-focus'); // data-focus 속성에 선언된 값을 읽음 
		// console.log('tag: ' + tag);

		$('#' + tag).focus(); // data-focus 속성에 선언된 태그를 찾아서 포커스 이동
	}

    
	function send(){ // 회원 가입 처리
    console.log(">>>"+$("#emailDoubleChk").val());
    if ($('#email').val() == "" | $('#id').val() == "" | $('#name').val() == "" | $('#phone').val() == "" ) {
      msg = ' * 필수 항목을 입력하세요.<br>';
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('필수항목 입력 확인'); // 제목 
      $('#modal_content').html(msg); // 내용
      $('#modal_panel').modal(); // 다이얼로그 출력
      $('#modal_input').hide();
      $('#btn_auth').hide();
      // $('#btn_send').attr('data-focus', 'email');
      return false; // submit 중지

    } else if ($('#passwd').val() != $('#passwd2').val()) { // 패스워드를 정상적으로 2번 입력했는지 확인
      msg = '입력된 패스워드가 일치하지 않습니다.<br>';
      msg += "패스워드를 다시 입력해주세요.<br>";

      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('패스워드 일치 여부 확인'); // 제목 
      $('#modal_content').html(msg); // 내용
      $('#modal_panel').modal(); // 다이얼로그 출력
      $('#modal_input').hide();
      $('#btn_send').attr('data-focus', 'passwd');
      $('#btn_auth').hide();
      return false; // submit 중지
      
    } else if($("#emailDoubleChk").val() != 'true'){
      msg = ' 이메일 인증을 완료해주세요.<br>';
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('이메일인증 확인'); // 제목 
      $('#modal_content').html(msg); // 내용
      $('#modal_panel').modal(); // 다이얼로그 출력
      $('#modal_input').hide();
      $('#btn_auth').hide();
      return false; 

    } else if($("#idDoubleChk").val() != 'true'){
      msg = '이미 사용중인 ID 입니다..<br>';
      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('ID 중복 확인'); // 제목 
      $('#modal_content').html(msg); // 내용
      $('#modal_panel').modal(); // 다이얼로그 출력
      $('#modal_input').hide();
      $('#btn_auth').hide();
      return false; 
    }

    
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address = address1 + " " + address2;
    $('input[name=address]').attr('value', address);
    $('#frm').submit();
    
  }

  function code_auth(){ // 인증 이메일 발송
    var input_code = $('#auth_code').val();
    if ($.trim(input_code).length == 0) { // email를 입력받지 않은 경우
      alert('인증번호를 입력하세요!');
      return false;
    } else{
      if(input_code == code){
        // alert("인증번호가 일치합니다.");
        // $(".successEmailChk").text("인증번호가 일치합니다.");
        // $(".successEmailChk").css("color","green");
        $("#emailDoubleChk").val("true");
        $("#email").attr("readonly",true);
        //$("#sm_email").attr("disabled",true);
        $('#email_chkNotice').html('');
        $('#email_chkNotice').html('&nbsp;&nbsp;이메일 인증 완료<br>');
        $('#email_chkNotice').attr('style', 'color: #126E82; font-size: 13px;');
      }else{
        alert('인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.');
        // $(".successEmailChk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
        // $(".successEmailChk").css("color","red");
        $("#emailDoubleChk").val("false");
        $("#auth_code").attr("autofocus",true);
        return false;
      }
    }
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
          <p id='modal_input'></p> <!-- input -->
        </div>
        
        <div class="modal-footer">
          <button type="button" id="btn_auth" data-focus="" class="btn btn-primary" 
                      data-dismiss="modal" style="display: none;">인증</button>
          <button type="button" id="btn_close" data-focus="" class="btn btn-primary" 
                      data-dismiss="modal">닫기</button>
                  
        </div>
      </div>
    </div>
  </div>
  <!-- ******************** Modal 알림창 종료 ******************** -->

  <DIV class='title_line'>
    회원가입
  </DIV>

  <DIV class='content_body'>

  <!-- <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 

  <div class='menu_line'></div> -->
  
  <FORM name='frm' id='frm' method='POST' action='./create.do' class="form-horizontal">
    <input type="hidden" name="address" value="">
    
    <div class="form-group">
      <label for="email" class="col-md-2 control-label" style='font-size: 0.9em;'>이메일*</label>    
      <div class="col-md-10">
        <div class="input-group col-md-9">
          <input type='text' class="form-control" name='email' id='email' value='' required="required" style='width: 30%;' placeholder="abc@mail.com" autofocus="autofocus">
          <button type='button' id="btn_checkEmail" class="btn btn-info btn-md">중복확인</button>
          <button type='button' id='btn_authEmail' class='btn btn-danger btn-md' style="display: none;">이메일인증</button>
          <font id="email_chkNotice" size="2"></font>
          <input type="hidden" id="emailDoubleChk"/>
        </div>
        <SPAN id='email_span'></SPAN> <!-- Email 중복 관련 메시지 -->        
      </div>
    </div> 

    <div class="form-group">
      <label for="id" class="col-md-2 control-label" style='font-size: 0.9em;'>아이디*</label>    
      <div class="col-md-10">
        <div class="input-group col-md-9">
          <input type='text' class="form-control" name='id' id='id' value='' required="required" style='width: 30%;' placeholder="아이디" autofocus="autofocus">
          <button type='button' id="btn_checkID" class="btn btn-info btn-md">중복확인</button>
          <input type="hidden" id="idDoubleChk"/>
        </div>
        <SPAN id='id_span'></SPAN> <!-- ID 중복 관련 메시지 -->        
      </div>
    </div>   
                
    <div class="form-group">
      <label for="passwd" class="col-md-2 control-label" style='font-size: 0.9em;'>패스워드*</label>    
      <div class="col-md-10">
        <input type='password' class="form-control" name='passwd' id='passwd' value='' required="required" style='width: 30%; 
        font-family: Tahoma; font-weight: bold;' placeholder="패스워드">
      </div>
    </div>   

    <div class="form-group">
      <label for="passwd2" class="col-md-2 control-label" style='font-size: 0.9em;'>패스워드 확인*</label>    
      <div class="col-md-10" id="passwd2_div">
        <input type='password' class="form-control" name='passwd2' id='passwd2' value='' required="required" style='width: 30%; 
        font-family: Tahoma; font-weight: bold;' placeholder="패스워드">
        <font id="chkNotice" size="2"></font>
      </div>
    </div>

    <div class="form-group">
      <label for="name" class="col-md-2 control-label" style='font-size: 0.9em;'>성명*</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='name' id='name' 
                   value='' required="required" style='width: 30%;' placeholder="성명">
      </div>
    </div>   

    <div class="form-group">
      <label for="phone" class="col-md-2 control-label" style='font-size: 0.9em;'>휴대전화*</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='phone' id='phone' 
                   value='' required="required" style='width: 30%;' placeholder="010-0000-0000" maxlength="13">
      </div>
    </div>   

    <div class="form-group">
      <label for="zipcode" class="col-md-2 control-label" style='font-size: 0.9em;'>우편번호</label>    
      <div class="col-md-10">
        <div class="input-group">
          <input type='text' class="form-control" name='zipcode' id='zipcode' 
                   value='' style='width: 50%;' placeholder="우편번호">
          <button type="button" id="btn_DaumPostcode" class="btn btn-info btn-md">우편번호 찾기</button>
        </div>
      </div>
    </div>  

    <div class="form-group">
      <label for="address1" class="col-md-2 control-label" style='font-size: 0.9em;'>주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='address1' id='address1' 
                   value='' style='width: 80%;' placeholder="주소">
      </div>
    </div>   

    <div class="form-group">
      <label for="address2" class="col-md-2 control-label" style='font-size: 0.9em;'>상세 주소</label>    
      <div class="col-md-10">
        <input type='text' class="form-control" name='address2' id='address2' 
                   value='' style='width: 80%;' placeholder="상세 주소">
      </div>
    </div>   

    <div class="form-group">
      <div class="col-md-12">

<!-- ------------------------------ DAUM 우편번호 API 시작 ------------------------------ -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#zipcode').val(data.zonecode); // 5자리 새우편번호 사용 ★
                $('#address1').val(fullAddr);  // 주소 ★

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#address2').focus(); //  ★
            },
            
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);
        
        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ------------------------------ DAUM 우편번호 API 종료 ------------------------------ -->

      </div>
    </div>
    
    
    <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="button" id='btn_send' class="btn btn-primary btn-md">가입</button>
        <button type="button" onclick="history.back()" class="btn btn-primary btn-md">취소</button>

      </div>
    </div>
       
  </FORM>
  </DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>