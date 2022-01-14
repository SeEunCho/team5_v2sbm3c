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

    initHiding();
    $('#btn_send').on('click', send);
    $('#btn_hideForm').on('click', hideAnswerForm);
    $('#btn_answer').on('click', showAnswerForm);
    $('#btn_check').on('click', showAnswer);
    $('#btn_hide').on('click', hideAnswer);
  });

function initHiding () {
  $('#frm').css("display", "none");
  $('#answer_content').css("display", "none")
}
  
function hideAnswerForm() {
  $('#frm').css("display", "none");  
}

function showAnswerForm() {
  $('#frm').css("display", "");
}


function showAnswer() {
   $('#answer_content').css("display", "");
}

function hideAnswer() {
   $('#answer_content').css("display", "none"); 
}


function send() {
  if(confirm("답글을 등록하시겠습니까?") == true) {
    $('#frm').submit();
  }
}

function updateAnswerByWindow (answerno) {
  //alert(answerno);
  var url = '/answer/' + answerno + '/update.do';
  var win = window.open(url, '답변 업데이트', 'width=800px, height=820px');

  var x = (screen.width - 800) / 2;
  var y = (screen.height - 820) / 2;

  win.moveTo(x, y); // 화면 중앙으로 이동
}

function deleteAnswerByWindow (answerno) {
  //alert(answerno);
  var url = '/answer/' + answerno + '/delete.do';
  var win = window.open(url, '답변 업데이트', 'width=800px, height=820px');

  var x = (screen.width - 800) / 2;
  var y = (screen.height - 820) / 2;

  win.moveTo(x, y); // 화면 중앙으로 이동
}



</script>
</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
 
     <DIV class='title_line'>My QnA 조회</DIV>

         <ASIDE class="aside_right">
          <A href="javascript:location.reload();">새로고침</A>
          <span class='menu_divide' >│</span> 
          <A href='./list.do'>목록</A>
          <!-- <span class='menu_divide' >│</span>
          <A href='./create.do'>탈퇴회원</A> -->
        </ASIDE> 

         <div class='menu_line'></div>
        <br>

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
              <div class="col-md-5">
                <label class="">생성일자: </label>
                ${qnaVO.qdate}
              </div>
              <div class="col-md-5">
                <label class="">비밀글 여부: </label>
                ${qnaVO.secret }
              </div>
            </div>
            <br>

            <div class="content_body_bottom">
              <button type="button" id="btn_check" class="btn btn-primary">답변확인</button>
              <button type="button" id="btn_hide" class="btn btn-primary">숨기기</button>
              <button type="button" onclick="history.back()" class="btn btn-primary">뒤로가기</button>
            <c:choose> <%-- 관리자 로그인 + 답변이 달리지 않은 QnA에 대해서만 답변등록 가능. (하나의 질문에 한개의 답변 1:1관계) --%>
              <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true && answerVO == null}">
                <button type="button" class="btn btn-danger" id="btn_answer">답변등록</button>  
              </c:when> 
              <c:otherwise>
              </c:otherwise>
            </c:choose>
            </div>


            <%-- 회원이 보게 될 답변 --%>
            

              <div id="answer_content" class="content_body">
                <label class="col-md-2">관리자 답변</label>
                  <div class="col-md-10">
                    <div class="textarea_basic">
                      <c:choose>
                        <c:when test="${answerVO != null}">
                          ${answerVO.answer}
                        </c:when>
                        <c:otherwise>
                          ** 아직 관리자의 답변이 달리지 않았습니다. **
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <c:choose>
                      <c:when test="${answerVO != null}"> 
                        <label class="control-label"><br>답변일자: </label>
                        ${answerVO.adate}
                      </c:when>
                    </c:choose>
                  </div><br>
                  <div class="content_body_bottom">
                    <c:choose> <%-- 관리자일 경우에만 답변등록 가능. --%>
                      <c:when test="${sessionScope.adminid != null && sessionScope.admin_flag == true && answerVO != null}">
                        <button type="button" onclick="updateAnswerByWindow(${answerVO.answerno})" class="btn btn-primary">답변수정</button>
                        <button type="button" onclick="deleteAnswerByWindow(${answerVO.answerno})" class="btn btn-primary">답변삭제</button>
                      </c:when>
                      <c:otherwise>

                      </c:otherwise>
                    </c:choose>
                  </div>                  
              </div>
             <br>

            <%-- 관리자 전용 답글 form --%>
            <FORM name='frm' id='frm' method='POST' action='/answer' class="form-horizontal">
              <input type="hidden" name="adminid" value="${sessionScope.adminid}"> <%-- 관리자일 경우에만 답변등록 가능. --%>
              <input type="hidden" name="qnano" value="${qnaVO.qnano}">

              <div class="form-group">
                 <label class="control-label col-md-2">답변</label>
                 <div class="col-md-10">
                   <textarea name='answer' required="required" class="form-control" rows="12" style='width: 90%;'>관리자 전용 답변란 입니다. 운영하시느라 수고가 많으십니다!</textarea>
                 </div>
              </div>
              
              <div class="content_body_bottom">
                <button type="button" id="btn_send" class="btn btn-primary">등록</button>
                <button type="button" id="btn_hideForm" class="btn btn-primary">숨기기</button>
              </div>
            </FORM>
 
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 