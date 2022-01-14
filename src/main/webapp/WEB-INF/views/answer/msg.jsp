<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
<%-- /static/css/style.css --%> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
 <jsp:include page="/WEB-INF/views/answer/mock_top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
      
         <%-- FaQ 삭제 --%>
         <c:when test="${code == 'Answer_delete_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">Answer 삭제에 성공하였습니다!</span><br><br><br>
            <button type='button' onclick="window.close()" class="btn btn-primary">창 닫기</button>
          </LI>                                                                 
        </c:when>
        <c:when test="${code == 'Answer_delete_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">Answer 삭제에 실패하였습니다.</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span><br><br>
            <button type='button' onclick="window.close()" class="btn btn-primary">창 닫기</button>
          </LI>                                                                      
        </c:when> 
        
          <%-- FaQ 수정 --%>
          <c:when test="${code == 'Answer_update_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">Answer 업데이트 성공</span><br>
            <button type='button' onclick="window.close()" class="btn btn-primary">창 닫기</button>
          </LI>                                                                 
        </c:when>
        <c:when test="${code == 'Answer_update_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">Answer 업데이트 실패</span>
            <span class="span_fail">다시 시도해 주십시오.</span><br><br>
           <button type='button' onclick="window.close()" class="btn btn-primary">창 닫기</button>
          </LI>                                                                             
        </c:when> 
        
        <%-- Answer 등록 --%>
         <c:when test="${code == 'Answer_create_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">Answer 등록 성공</span><br><br>${param.qnano}
            <button type='button'class="btn btn-primary"><a href="/qna/${param.qnano}/read.do">목록</a></button>
          </LI>                                                                      
        </c:when> 
         <c:when test="${code == 'Answer_create_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">Answer 등록 실패</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span><br><br>
            <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
          </LI>                                                                      
        </c:when>

         <c:when test="${code == 'ObjNotFoundException'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">해당 답변글이 조회되지 않았습니다.</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span><br><br>
            <button type='button' onclick="window.close()" class="btn btn-primary">창 닫기</button>
          </LI>                                                                      
        </c:when>

         <%-- 예외 메시지 --%>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">알 수 없는 에러로 작업에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI><br><br>
          <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
        </c:otherwise>
        
        <%-- choose end (start line ->26 )  --%>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:choose>
            <c:when test="${param.cnt == 0 }">
                <button type='button' onclick="history.back()" class="btn btn-primary">다시 시도</button>    
            </c:when>
        </c:choose>
      </LI>
    </UL>
  </fieldset>

</DIV>
 <jsp:include page="/WEB-INF/views/answer/mock_bottom.jsp" flush='false' />
</body>

</html>
 
