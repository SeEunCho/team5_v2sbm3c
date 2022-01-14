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
      
         <%-- FaQ 삭제 --%>
         <c:when test="${code == 'faq_delete_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">FaQ게시글 삭제에 성공하였습니다!</span><br>
            <button type='button' onclick="location.href='/faqlist'" class="btn btn-primary">목록</button>
          </LI>                                                                 
        </c:when>
        <c:when test="${code == 'faq_delete_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">FaQ게시글 삭제에 실패하였습니다.</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span>
            <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
          </LI>                                                                      
        </c:when> 
        
          <%-- FaQ 수정 --%>
          <c:when test="${code == 'faq_update_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">faq 업데이트 성공</span><br>
            <button type='button' onclick="location.href='/faqlist'" class="btn btn-primary">목록</button>
          </LI>                                                                 
        </c:when>
        <c:when test="${code == 'faq_update_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">faq 업데이트 실패</span>
            <span class="span_fail">다시 시도해 주십시오.</span>
            <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
          </LI>                                                                             
        </c:when> 
        
        <%-- FaQ 등록 --%>
         <c:when test="${code == 'faq_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">FaQ 등록 성공</span><br>
            <button type='button' onclick="location.href='/faqlist'" class="btn btn-primary">목록</button>
          </LI>                                                                      
        </c:when> 
         <c:when test="${code == 'faq_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">FaQ 등록 실패</span><br>
            <span class="span_fail">다시 시도해 주십시오.</span>
            <button type='button' onclick="location.href='/'" class="btn btn-primary">홈으로</button>
          </LI>                                                                      
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
 
