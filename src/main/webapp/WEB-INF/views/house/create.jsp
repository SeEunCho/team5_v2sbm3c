<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
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
 
<DIV class='title_line'> 주택  > 등록</DIV>
 
<DIV class='content_body'>

  <FORM name='frm' method='POST' action='./create.do'>
    <div class="form-group">
       <label class="control-label col-md-4">주택 이름</label>
       <div class="col-md-8">
      <input type='text' name='hname' value='' required="required" style='width: 60%;'
                class="form-control" autofocus="autofocus">
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-4">가격</label>
       <div class="col-md-8">
      <input type='text' name='price' value='' required="required" style='width: 60%;'
                class="form-control" autofocus="autofocus">
       </div>
       
    <div class="form-group">
       <label class="control-label col-md-4">지목</label>
       <div class="col-md-8">
      <input type='text' name='nomination' value='nomi' required="required" style='width: 60%;'
                class="form-control" autofocus="autofocus">
        </div>
    
    <div class="form-group">
       <label class="control-label col-md-4">크기</label>
       <div class="col-md-8">
      <input type='text' name='area' value='' required="required" style='width: 60%;'
                class="form-control" autofocus="autofocus">
       </div>
    
     <div class="form-group">
       <label class="control-label col-md-4">위치</label>
       <div class="col-md-8">
      <input type='text' name='loca' value='' required="required" style='width: 60%;'
                class="form-control" autofocus="autofocus">
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
 
 
 