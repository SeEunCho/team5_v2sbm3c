<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="noticeno" value="${noticeVO.noticeno }" />
<c:set var="adminid" value="${noticeVO.adminid }" />
<c:set var="noticetitle" value="${noticeVO.noticetitle }" />
<c:set var="noticecontent" value="${noticeVO.noticecontent }" />
<c:set var="rdate" value="${noticeVO.rdate.substring(0, 10) }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>공지사항 삭제</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script type="text/javascript">
	
</script>

</head>

<body>
	<jsp:include page="../menu/top.jsp" />

 <DIV class='title_line'>
  <A href="../notice/list.do" class='title_link'>공지사항</A> > 
  <A href="../notice/list_by_noticeno.do?noticeno=${noticeVO.noticeno }" class='title_link'>${noticeVO.noticetitle }</A> >
  ${noticeVO.noticetitle } 삭제
  </DIV>

	<DIV class='content_body'>
		<DIV id='panel_delete'
			style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
			<div class="msg_warning">공지사항을 삭제하면 복구 할 수 없습니다.</div>
			<FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
             <input type='hidden' name='noticeno' id='noticeno' value="${noticeVO.noticeno }">
				

                <div class="content_body_bottom" style="padding-right: 20%;">
				<button type="submit" class="btn btn-primary">삭제</button>
				<button type="button" onclick="location.href='./list.do'" class="btn">삭제 취소</button>
				</div>
			</FORM>
		</DIV>

		
	</DIV>

	<jsp:include page="../menu/bottom.jsp" />
</body>

</html>

