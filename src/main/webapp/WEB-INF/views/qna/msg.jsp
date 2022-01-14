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
<jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <%-- QnA 결과 메시지 파일. (추후 개발 완료 이후 하나의 msg로 통합하기. --%>
        
        <%-- FaQ 삭제 --%>
         <c:when test="${code == 'qna_delete_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">QnA게시글 삭제에 성공하였습니다!</span><br>
            <button type='button' onclick="location.href='/qnalist'" class="btn btn-primary">목록</button>
          </LI>                                                                 
        </c:when>
        <c:when test="${code == 'qna_delete_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">QnA게시글 삭제에 실패하였습니다.</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span>
            <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
          </LI>                                                                      
        </c:when> 
        
        
        <%-- FaQ 등록 --%>
         <c:when test="${code == 'qna_create_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">QnA 등록 성공!</span><br>
            <button type='button' onclick="location.href='/qnalist'" class="btn btn-primary">목록</button>
          </LI>                                                                      
        </c:when> 
         <c:when test="${code == 'fqna_create_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">QnA 등록 실패</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span>
            <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
          </LI>                                                                      
        </c:when> 
        
        <%-- FaQ 수정 --%>
         <c:when test="${code == 'qna_update_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">QnA 수정 성공!</span><br>
            <button type='button' onclick="location.href='/qnalist'" class="btn btn-primary">목록</button>
          </LI>                                                                      
        </c:when> 
         <c:when test="${code == 'qna_update_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">QnA 수정 실패</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span>
            <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
          </LI>                                                                      
        </c:when> 

        <%-- Session 아이디 사라지는 문제가 있음.. 다시 로그인 유도. --%>
        <c:when test="${code == 'session_fail' && sessionScope.id != null}">
          <LI class='li_none'>
            <span class="span_fail">세션이 만료되었습니다.<br>다시 로그인해주세요</span><br></LI>  
            <%-- <c:if test="${sessionScope.id != null}"> 로그인 한 경우 --%>
            <button type='button' onclick="location.href='/member/logout.do'" class="btn btn-primary">Logout</button>          
        </c:when>


         <%-- 예외 메시지 --%>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">알 수 없는 에러로 작업에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
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
        
        <%-- <a href="./list_by_cateno.do?cateno=${param.cateno}" class="btn btn-primary">목록</a> --%>
        <%-- <button type='button' onclick="location.href='./list_by_cateno_search.do?cateno=${param.cateno}'" class="btn btn-primary">목록</button> --%>
        <%-- <button type='button' onclick="location.href='./list_by_cateno_search_paging.do?cateno=${param.cateno}'" class="btn btn-primary">목록</button> --%>

      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
</body>

</html>
 
