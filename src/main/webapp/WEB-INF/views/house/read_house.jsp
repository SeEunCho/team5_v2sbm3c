 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="hname" value="${houseVO.hname }" />
<c:set var="nomination" value="${houseVO.nomination }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>심슨네 가족</title>
<style type="text/css">
  *{ font-family: Malgun Gothic; font-size: 26px;}
</style>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
 
     <DIV class='title_line'>주택 정보</DIV>
            <input type="hidden" name="adminnid" value="1">
            
            <div class="form-group">
               <label class="control-label col-md-2">주택 명</label>
               <div class="col-md-10">
                ${houseVO.hname}
               </div>
            <div class="form-group">
               <label class="control-label col-md-2">사진</label>
               <div class="col-md-10">
                ${houseVO.himage}
               </div>
       
            <div class="form-group">
                <label class="control-label col-md-4">가격</label>
                <div class="col-md-8">
                ${houseVO.price}
                </div>
       
    <div class="form-group">
       <label class="control-label col-md-4">지목</label>
       <div class="col-md-8">
       ${houseVO.nomination}
        </div>
    
    <div class="form-group">
       <label class="control-label col-md-4">크기</label>
       <div class="col-md-8">
       ${houseVO.area}
       </div>
    
     <div class="form-group">
       <label class="control-label col-md-4">위치</label>
       <div class="col-md-8">
       ${houseVO.loca}
       </div>
                 </div>
               </div>
            </div>
    
            <div class="content_body_bottom">
              <button type="button" onclick="location.href='/list.do'" class="btn btn-primary">목록</button>
            </div>
       <input type="hidden" name="memberid" value="1">
                <div class="form-group">
       <label class="control-label col-md-4">평점</label>
       <div class="col-md-8">
          <select name='likes' class="form-control" style='width: 20%;'>
            <option value='1' selected="selected">1</option>
            <option value='2' selected="selected">2</option>
            <option value='3' selected="selected">3</option>
            <option value='4' selected="selected">4</option>
            <option value='5' selected="selected">5</option>
            </select>
        <button type="button"  class="btn btn-primary">등록</button>
        </div>
 
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 