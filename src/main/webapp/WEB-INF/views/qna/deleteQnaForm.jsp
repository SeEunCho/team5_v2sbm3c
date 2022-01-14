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


<script type="text/javascript">

$(function () {
  $('#btn_send').on('click', send);
  setRadioVal();
  //setDropdown();
}); 
    
// DB에 저장된 값에 따라 radio, select tag 값 세팅.
 function setRadioVal() {
     var radio_ck = '${qnaVO.secret}';
     //alert(radio_ck);
     
        if (radio_ck == "Y") {
            $("#secretY").prop("checked", true);
        } else {
            $("#secretN").prop("checked",true);
        }

     }

function send() {
    if (confirm("정말로 삭제하시겠습니까?\n삭제이후 복구할 수 없습니다.") == true) {
        $('#frm').submit();
    } else {
        return;
    }
}

/*function setDropdown() {
  var dropdown_ck = '${qnaVO.qcateno}';
  //alert(dropdown_ck); 
  
  if (dropdown_ck == 5) {
    $("#fk1").prop("selected", true);
  } else if (dropdown_ck == 6) {
    $("#fk2").prop("selected", true);
  } else if (dropdown_ck == 7) {
    $("#fk3").prop("selected", true);
  } else {
    $("#fk1").prop("selected", true);
  }
}*/

/* To-Do 
 *  정말로 삭제하시겠습까? 복구 안됩니다 확인하는 함수 만들어서 연결
          ㅇㄹㄴㅇㄹㄴㄹ
          
 
 */


</script>

</head>
<body>

    <!--써도 되는지 체크 -->
  <c:set var="qnano" value="${qnaVO.qnano }"></c:set>
  <c:set var="title" value="${qnaVO.title }" />
  <c:set var="text" value="${qnaVO.text }" />
  <c:set var="qdate" value="${qnaVO.qdate }" />
  <c:set var="secret" value="${qnaVO.secret }"></c:set>
  <c:set var="qcateno" value="${qnaVO.qcateno}"></c:set>


 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
        
 <DIV class='title_line'>삭제 확인창</DIV>
      <FORM name='frm' id='frm' method='POST' action='/qna/${qnano }/delete.do' class="form-horizontal">
        <input type="hidden" name="adminnid" value="1"> <%-- 관리자 개발후 변경 필요 --%>

            <div class="content_body">
              <label class="col-md-2">알림!!</label>
              <div class="col-md-10">지나친 폭언과 욕설 및 정치적인 내용의 QnA인 경우, <b><i>관리자에 의해 삭제조치</i></b> 될 수 있습니다.</div>
            </div>

            <hr><br>
            
            <div class="content_body">
               <label class="col-md-2">제목</label>
               <div class="col-md-10">
                ${qnaVO.title}
               </div>
            </div>
            <br>

            <div class="content_body">
               <label class="col-md-2">본문</label>
               <div class="col-md-10">
                  <div class="textarea_basic">
                   ${qnaVO.text}
                 </div>
               </div>
            </div>
            <br>

            <div class="content_body_bottom">
              <div class="col-md-6">
                <label class="">생성일자: </label>
                ${qnaVO.qdate}
              </div>
              <div class="col-md-6">
                <label class="">비밀글 여부: </label>
                ${qnaVO.secret }
              </div>
            </div>
            <br>
        
        <div class="content_body_bottom">
          <button type="button" id="btn_send" class="btn btn-primary">삭제하기</button>
          <button type="button" onclick="history.back()" class="btn btn-primary">뒤로가기</button>
        </div>
      
      </FORM>
      <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
</body>
</html>

