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
    if (confirm("수정하시겠습니까?") == true) {
        $('#frm').submit();
    } else {
        return;
    }
}

/*  db에서 값 읽어오고, jstl로 검사하면 해당 로직이 불필요. 
function setDropdown() {
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

</script>

</head>
<body>

  <c:set var="qnano" value="${qnaVO.qnano }"></c:set>
  <c:set var="title" value="${qnaVO.title }" />
  <c:set var="text" value="${qnaVO.text }" />
  <c:set var="qdate" value="${qnaVO.qdate }" />
  <c:set var="secret" value="${qnaVO.secret }"></c:set>
  <c:set var="qcateno" value="${qnaVO.qcateno}"></c:set>


 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
        
 <DIV class='title_line'>질문 수정하기</DIV>
      <FORM name='frm' id='frm' method='POST' action='/qna/${qnano }/update.do' class="form-horizontal">
        <input type="hidden" name="adminnid" value="1"> <%-- 관리자 개발후 변경 필요 --%>
       
        
        <div class="form-group">
           <label class="control-label col-md-2">제목</label>
           <div class="col-md-10">
             <input type='text' name='title' value='${title }' required="required" 
                       autofocus="autofocus" class="form-control" style='width: 90%;'>
           </div>
        </div>
       
       
      <div class="form-group">
           <label class="control-label col-md-2">질문 카테고리 선택</label>
           <div class="col-md-10">
               <select name="qcateno"> <%-- db에서 동적으로 카테고리 선택 --%>
                   <c:forEach var="qnacateVO" items="${list }" varStatus="info">
                    <option value="${qnacateVO.qcateno }" ${qnacateVO.qcateno==qnaVO.qcateno ? "selected='selected'" : "" } >${qnacateVO.name }</option>
                   </c:forEach>   
              </select>
           </div>
        </div>  


        <div class="form-group">
           <label class="control-label col-md-2">본문</label>
           <div class="col-md-10">
             <textarea name='text' required="required" class="form-control" rows="12" style='width: 90%;'>${text }</textarea>
           </div>
        </div>
        
         <div class="form-group">
           <label class="control-label col-md-2">비밀글 </label>
           <div class="col-md-10">
           <IMG src='/member/images/lock.png' width = "18px" height="18px">
            <input type="radio" name="secret" id="secretN" value="N">NO
            <input type="radio" name="secret" id="secretY" value="Y">YES
           </div>
        </div>
        
        <div class="content_body_bottom">
          <button type="button" id="btn_send" class="btn btn-primary">수정하기</button>
          <button type="button" onclick="history.back()" class="btn btn-primary">뒤로가기</button>
        </div>
      
      </FORM>
      <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
</body>
</html>

