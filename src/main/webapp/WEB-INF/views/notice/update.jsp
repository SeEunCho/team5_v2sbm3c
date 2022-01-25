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
<title>공지사항 수정</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>
  <A href="../notice/list.do" class='title_link'>공지사항</A> > 
  <A href="../notice/list_by_noticeno.do?noticeno=${noticeVO.noticeno }" class='title_link'>${noticeVO.noticetitle }</A> >
  ${title } 수정
  </DIV>

 
<DIV class='content_body'>
  <!-- 
  http://localhost:9091/notice/update.do
  action='./update.do' -> ./: http://localhost:9091/notice 현재 폴더
  -->
  
  <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
   <div class="form-group">
       <label class="control-label col-md-2">관리자번호</label>
       <div class="col-md-10">
         <input type='text' name='adminid' value='' required="required" placeholder="관리자번호"
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
      <button type="button" onclick="location.href='./list.do'" class="btn">목록</button>
    </div>
  
  </FORM>
  
</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />

</body>
 
</html>
 
 
 