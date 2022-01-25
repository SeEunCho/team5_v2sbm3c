<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style type="text/css">
* {
	font-family: Malgun Gothic;
	font-size: 26px;
}
</style>

<link href="/css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head>
<body>

	<jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />

	<DIV class='title_line'>공지사항</DIV>
	<input type="hidden" name="adminnid" value="1">

	<DIV style="width: 47%; height: 260px; float: left; margin-right: 10px; margin-bottom: 30px;">
          <span style="font-size: 1.5em; font-weight: bold;">${noticeVO.noticetitle }</span><br><br>
          <span style="font-size: 1.5em; font-weight: mideum;">${noticeVO.noticecontent }</span><br>
    </DIV>
	

	<div class="content_body_bottom">
		<button type="button" onclick="location.href='./list.do'" class="btn">목록</button>
	</div>

	<jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />

</body>
</html>
