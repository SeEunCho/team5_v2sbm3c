<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>http://localhost:9091/</title>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script src="https://maps.google.com/maps/api/js?key=AIzaSyB9MXxWL1I2d22VVQj7FzVCelxfZWBDsc8&sensor=flase" type="text/javascript"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=587a4e98e5eb5e4d4a5dd25e7ddda665&libraries=services"></script>

<script src="/js/jquery.fn.gmap.js" type="text/javascript"></script>
<script src="/js/jquery.ui.map.extensions.js" type="text/javascript"></script>
<script type="text/javascript">
$(function () {
  
    var StartLatLng = new google.maps.LatLng(35.307281, 127.510466);       
    $("#map_canvas").gmap({"center": StartLatLng, "zoom":16});
})
</script>

<style type="text/css">
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}

</style>

</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />

 <DIV class='title_line'> 서울시 아파트 실거래가 데이터 (Open Api) ${length } </DIV><br><br>

 <c:choose>
   <c:when test="${singleApiVO != null && month != nll && year != null}">
     <div class="container" style="text-align: center;"> 서울시 ${singleApiVO.name}의 ${year}년 ${month}월의 아파트 실거래정보 입니다.</div>
   </c:when>
   <c:otherwise>
     
   </c:otherwise>
 </c:choose>

 <div id="panel_search" style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>

     <form id="frm_search" name="frm_search" method="POST" action="/api/call_do">
     <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }"> 

     <label>지역 선택</label>
      <select name='regionCode' id='select_region'>
       <c:forEach var="apiVO" items="${list }" varStatus="info">
        <option value="${apiVO.regionCode }">${apiVO.name }</option>
       </c:forEach>   
      </select>


      <label>년도 선택</label>
      <select name='year' id='select_year'>
        <option value='2017' selected="selected">2017</option>
        <option value='2018'>2018</option>
        <option value='2019'>2019</option>
        <option value='2020'>2020</option>
        <option value='2021'>2021</option>        
      </select>


      <label>월 선택</label>
      <select name='month' id='select_month'>
        <option value='01' selected="selected">1월</option>
        <option value='02'>2월</option>
        <option value='03'>3월</option>
        <option value='04'>4월</option>
        <option value='05'>5월</option>
        <option value='06'>6월</option>
        <option value='07'>7월</option>
        <option value='08'>8월</option>
        <option value='09'>9월</option>
        <option value='10'>10월</option>
        <option value='11'>11월</option>
        <option value='12'>12월</option>
      </select>

      <button type="submit" id='search_submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">검색하기</button>
      <button type="button" id='btn_update_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">초기화</button>

      </form>
 </div>
   <div class="container" id="map_canvas" style="width: 100%; height: 600px;"></div>
 
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 