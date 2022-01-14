<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="noticeno" value="${noticeVO.noticeno }" />
<c:set var="adminid" value="${noticeVO.adminid }" />
<c:set var="noticetitle" value="${noticeVO.noticetitle }" />
<c:set var="noticecontent" value="${noticeVO.noticecontent }" />
<c:set var="rdate" value="${noticeVO.rdate.substring(0, 10) }" />

       
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>공지사항 > ${noticetitle } 조회(수정)</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='noticeno' id='noticeno' value='${noticeno }'>
        
      <div class="form-group">
       <label class="control-label col-md-2">관리자번호</label>
       <div class="col-md-10">
         <input type='text' name='adminid' value='' required="required" placeholder="1"
                    autofocus="autofocus" class="form-control" style='width: 50%;'>
       </div>
    </div>
 
      <div class="form-group">
       <label class="control-label col-md-2">제목</label>
       <div class="col-md-10">
         <input type='text' name='noticetitle' value='' required="required" placeholder="제목을 입력하세요"
                    autofocus="autofocus" class="form-control" style='width: 80%;'>
       </div>
    </div>
  
      <div class="form-group">
       <label class="control-label col-md-2">내용</label>
       <div class="col-md-10">
         <textarea name='noticecontent' required="required" placeholder="내용을 입력하세요"
           class="form-control" rows="12" style='width: 100%;'></textarea>
       </div>
    </div>  
       
      <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn">수정</button>
      <button type="button" onclick="location.href='./list.do'" class="btn">수정 취소</button>
    </div>

    </FORM>
  </DIV>
   
</DIV>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
 
 
 