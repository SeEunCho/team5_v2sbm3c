<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>구해줘! 홈즈</title>
<link rel="icon" href="/images/house_pavicon.png">
 
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
 
<DIV class='title_line'>공지사항  > 등록</DIV>
 
<DIV class='content_body'>
  <!-- 
  http://localhost:9091/notice/create.do
  action='./create.do' -> ./: http://localhost:9091/notice 현재 폴더
  -->
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
   <div class="form-group">
       <label class="control-label col-md-2">관리자번호</label>
       <div class="col-md-10">
         <input type='text' name='adminid' value='${adminid}' required="required" placeholder="관리자번호"
                    autofocus="autofocus" class="form-control" style='width: 50%;' readonly="readonly">
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
         <textarea name='noticecontent' required="required" placeholder="내용을 입력하세요" class="form-control" rows="12" style='width: 100%;'></textarea>
       </div>
    </div>  
  
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn">등록</button>
      <button type="button" onclick="location.href='./list.do'" class="btn">목록</button>
    </div>
  
  </FORM>
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
 
 