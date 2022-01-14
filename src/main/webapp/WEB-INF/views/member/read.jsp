<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
  $(function(){
    $('#btn_withdrawal').on('click', withdrawal);
    $('#btn_cancel').on('click', cancel);
    

    $('#phone').keyup(function (event) { // 전화번호 자동 하이픈(-)
        event = event || window.event;
        var _val = this.value.trim();
        this.value = autoHypenPhone(_val);
      });
    

    function autoHypenPhone(str) { // 전화번호 자동 하이픈(-)
      console.log(str);
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
    
    if($('#code').val() == "passwd_fail"){
      msg = '입력된 패스워드가 일치하지 않습니다.<br>';
      msg += "패스워드를 다시 입력해주세요.<br>"; 

      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('회원탈퇴'); // 제목 
      $('#modal_content').html(msg); // 내용
      $('#modal_panel').modal(); // 다이얼로그 출력
      $('#btn_send').attr('data-focus', 'passwd_ck');

    }else if($('#code').val() == "passwd_success"){
      var memverid = $('#memberid').val();
      location.href = '/member/delete.do?memberid='+memverid;
    }
  });

  function withdrawal() {
    var msg = '';

    if($('#passwd_ck').val() ==""){
      msg = '패스워드를 입력해주세요.<br>';

      $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
      $('#modal_title').html('회원탈퇴'); // 제목 
      $('#modal_content').html(msg); // 내용
      $('#modal_panel').modal(); // 다이얼로그 출력

      $('#passwd_ck').attr('data-focus', 'passwd_ck');
      return false;
    } else{

      $('#frm2').submit();
    }    
  }

  function cancel() {
    //alert(session.getAttribute("admin_flag"));
    var admin_flag = '<%=session.getAttribute("admin_flag")%>';
    if(admin_flag=="true"){
      location.href = '/member/list.do';
    }else{
      location.href = '/';
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
        </div>
        <div class="modal-footer">
          <button type="button" id="btn_close" data-focus="" class="btn btn-default" 
                      data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  <!-- ******************** Modal 알림창 종료 ******************** -->

  <DIV class='title_line'>
    ${title}
  </DIV>

  <DIV class='content_body'>    
    <!--<ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span> 
      <A href='./create.do'>회원 가입</A>
      <span class='menu_divide' >│</span> 
      <A href='./list.do'>목록</A>
    </ASIDE>  
   
    <div class='menu_line'></div>-->
    
    <DIV id='main_panel'></DIV>
    
    <input type='hidden' name='name' id='name' value='${memberVO.name }'>
    <input type='hidden' name='code' id='code' value='${param.code}'>

    <FORM name='frm' id='frm' method='POST' action='./update.do' class="form-horizontal">
      <input type='hidden' name='memberid' id='memberid' value='${memberVO.memberid }'>          
      <input type='hidden' name='id' id='id' value='${memberVO.id }'>

      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>이메일</label>    
        <div class="col-md-10">        
          ${memberVO.email }      
        </div>
      </div>   

      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>아이디</label>    
        <div class="col-md-10">        
          ${memberVO.id } 
        </div>
      </div>   
                  
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>성명</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='name' id='name' value='${memberVO.name }' 
                  required="required" autofocus="autofocus" style='width: 30%;' placeholder="성명">
        </div>
      </div>

      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>패스워드</label>    
        <div class="col-md-10">
          <button type="button" onclick="location.href='./passwd_update.do?memberid=${memberVO.memberid}'" class="btn btn-info btn-md">패스워드 변경</button>
        </div>
      </div>   
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>휴대전화</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='phone' id='phone' value='${memberVO.phone }' 
                  required="required" style='width: 30%;' placeholder="010-0000-0000" maxlength="13">
        </div>
      </div>   
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>우편번호</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='zipcode' id='zipcode' style='width: 30%;' placeholder="우편번호">
          <input type="button" onclick="DaumPostcode()" value="우편번호 찾기" class="btn btn-info btn-md">
        </div>
      </div>
   
      <div class="form-group">
        <label class="col-md-2 control-label" style='font-size: 0.9em;'>주소</label>    
        <div class="col-md-10">
          <input type='text' class="form-control" name='address' id='address' value='${memberVO.address }' style='width: 80%;' placeholder="주소">
        </div>
      </div>   
   
      <div class="form-group">
        <div class="col-md-12">
   
  <!-- ----- DAUM 우편번호 API 시작 ----- -->
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
                  document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                  document.getElementById('address').value = fullAddr;
   
                  // iframe을 넣은 element를 안보이게 한다.
                  // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                  element_wrap.style.display = 'none';
   
                  // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                  document.body.scrollTop = currentScroll;
                  
                  //$('#address2').focus();
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
  <!-- ----- DAUM 우편번호 API 종료----- -->
   
        </div>
      </div>  
      
      <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
          <button type="submit" class="btn btn-primary btn-md">회원정보 변경</button>
          <button type="button" id='btn_cancel' class="btn btn-primary btn-md">취소</button>
   
        </div>
      </div> 
      
    </FORM>
  
  </DIV>
  <c:choose>
    <c:when test="${memberVO.grade != 99}">
      <c:choose>
        <c:when test="${admin_flag == true}">
          <hr>
          <DIV class='content_body'>
            <DIV id='main_panel'></DIV>
            <div class="form-horizontal">
              <div class="form-group ">
                <div class="col-md-offset-2 col-md-10">
                  <button type="button" onclick="location.href='./delete.do?memberid=${memberVO.memberid }'"
                    class="btn btn-danger btn-md">회원삭제</button>
                </div>
              </div>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <hr>
          <DIV class='content_body'>
            <DIV id='main_panel'></DIV>
            <FORM name='frm2' id='frm2' method='POST' action='./withdrawal.do' class="form-horizontal">
              <input type='hidden' name='memberid' id='memberid' value='${memberVO.memberid }'>
  
              <div class="form-group">
                <label class="col-md-2 control-label" style='font-size: 0.9em;'>패스워드 확인</label>
                <div class="col-md-10">
                  <input type='text' class="form-control" name='passwd_ck' id='passwd_ck' autofocus="autofocus"
                    style='width: 30%;' placeholder="패스워드 확인">
                </div>
              </div>
              <div class="form-group">
                <div class="col-md-12">
                </div>
              </div>
  
              <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                  <button type="button" id='btn_withdrawal' class="btn btn-danger btn-md">회원탈퇴</button>
  
                </div>
              </div>
            </FORM>
          </div>
        </c:otherwise>
      </c:choose>
    </c:when>
  </c:choose>
  
  

  

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 