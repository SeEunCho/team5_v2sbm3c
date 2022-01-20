<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>심슨네 가족</title>
<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="icon" href="/images/house_pavicon.png">

<!-- Fotorama -->
<link href="/fotorama/fotorama.css" rel="stylesheet">
<script src="/fotorama/fotorama.js"></script>

</head>
<body>
<jsp:include page="./menu/top.jsp" flush='false' />
  
  <DIV class="container">
        <div class="fotorama"data-autoplay="5000" data-nav="thumbs" data-ratio="800/520">
            <img src="/fotorama/images/winter01.jpg">     
            <img src="/fotorama/images/winter02.jpg">
            <img src="/fotorama/images/winter03.jpg">
            <img src="/fotorama/images/winter04.jpg">
            <img src="/fotorama/images/winter05.jpg">
            <img src="/fotorama/images/winter06.jpg">
            <img src="/fotorama/images/winter07.jpg">
            <img src="/fotorama/images/winter08.jpg">
            <img src="/fotorama/images/winter09.jpg">        
      </div>
  </DIV>

  
  <DIV style='margin: 0px auto; width: 90%;'>
    <DIV style='float: left; width: 50%;'>
     </DIV>
     <DIV style='float: left; width: 50%;'>
    </DIV>  
  </DIV>
 
  <DIV style='width: 94.8%; margin: 0px auto;'>
  </DIV>  
 
<jsp:include page="./menu/bottom.jsp" flush='false' />
 
</body>
</html>

