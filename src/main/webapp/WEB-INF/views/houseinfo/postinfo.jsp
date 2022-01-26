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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=587a4e98e5eb5e4d4a5dd25e7ddda665&libraries=services"></script>

<script src="/js/jquery.fn.gmap.js" type="text/javascript"></script>
<script src="/js/jquery.ui.map.extensions.js" type="text/javascript"></script>
<script type="text/javascript">

$(function () {
    // 사용자가 선택한 구의 구청 좌표로 초기 위/경도 값 넣기
    var container = document.getElementById('map');
    var options = {
        center : new kakao.maps.LatLng(37.5666805, 126.9784147),
        level: 7
    }; 

    var map = new kakao.maps.Map(container, options);

    var jsonList = ${jsonlist};

    for (var i in jsonList) {

      var name = jsonList[i].name;
      var contstYear = jsonList[i].cyear;
      var amount = jsonList[i].amount;
      var area = jsonList[i].area;
      var lat = eval(jsonList[i].lat);
      var lon = eval(jsonList[i].lon);

      var searchAddress = 'https://map.kakao.com/link/search/' + name;

      var iwContent = '<div style="text-align: center; font-size: xx-small;">' +
                        name.substr(0, 15) + 
      '                  </div>'  +                       
      '                    <div style="text-align: center; font-size: small;">금액: ' + 
                                 amount + 
      '                     (만원)</div>'  + 
      '                        <div style="text-align: center; font-size:small;"> 전용면적: ' +
                                   area + 
      '                             m²</div>';


      var markerPosition = new kakao.maps.LatLng(lon, lat);

      var marker = new kakao.maps.Marker({
          position: markerPosition,
          clickable: true
        });

      var infowindow = new kakao.maps.InfoWindow({
        //position : markerPosition,
        content: iwContent
      });

      // 클로저 함수를 for scope 밖에 선언하지 않으면 맨 마지막 마커에만 마우스 이벤트가 등록되는 오류가 발생. 
      kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
      kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
      kakao.maps.event.addListener(marker, 'click', makeClickListener(searchAddress));

      marker.setMap(map);

  }// end for statement

function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

function makeClickListener(searchAddress) {
    return function() {
         window.open(searchAddress, '다음지도 검색', 'width=1200px, height=820px');
    };
}


});
</script>

<style type="text/css">
  
  i { color: #f7570b; }
</style>

</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />

 <DIV class='title_line'> 서울시 아파트 실거래가 데이터</DIV><br>

   <ASIDE class="aside_right">
    <A href='/api/call_list.do?regionCode=${singleApiVO.regionCode}&year=${year}&month=${month}'>리스트로 보기</A>
  </ASIDE> 

   <div class='menu_line'></div>

  <c:choose>
   <c:when test="${singleApiVO != null && month != nll && year != null}">
     <div class="container" style="text-align: center;"> <h3>서울시 ${singleApiVO.name}의 ${year}년 ${month}월 아파트 실거래정보 입니다.</h3></div>
     <div class="container" style="text-align: center;"> <span style="font-size: xx-small;">지도 데이터 특성 상 동일아파트 거래의 경우 marker누락이 발생할 수 있습니다.</span></div>
     <div class="container" style="text-align: center;"> <span style="font-size: xx-small;">정확한 전체 데이터는 우측 상단의 "리스트로 보기" 를 사용해주세요.</span></div> <br>
   </c:when>
   <c:otherwise>
     
   </c:otherwise>
 </c:choose>

 <div id="panel_search" style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>

     <form id="frm_search" name="frm_search" method="POST" action="/api/call.do">
     <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }"> 

     <label>지역 선택</label>
      <select name='regionCode' id='select_region'>
       <c:forEach var="apiVO" items="${list }" varStatus="info">
        <option value="${apiVO.regionCode }">${apiVO.name }</option>
       </c:forEach>   
      </select>


      <label>년도 선택</label>
      <select name='year' id='select_year'>
        <option value='2020' selected="selected">2020</option>
        <option value='2021'>2021</option>        
      </select>


      <label>월 선택</label>
      <select name='month' id='select_month'>
        <option value='1' selected="selected">1월</option>
        <option value='2'>2월</option>
        <option value='3'>3월</option>
        <option value='4'>4월</option>
        <option value='5'>5월</option>
        <option value='6'>6월</option>
        <option value='7'>7월</option>
        <option value='8'>8월</option>
        <option value='9'>9월</option>
        <option value='10'>10월</option>
        <option value='11'>11월</option>
        <option value='12'>12월</option>
      </select>

      <button type="submit" id='search_submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">검색하기</button>
      <button type="button" onclick="location.href='/'"  class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">초기화</button>

      </form>
 </div>
 
   <div class="container" id="map" style="width: 100%; height: 600px;"></div>
   <br>
   <div class="container" style="text-align: center;"> <span style="font-size: small;"><b>공공데이터포털과의 통신이 원활하지 않은경우, 결과가 나오지 않을 수 있습니다.</b></span></div>
     <div class="container" style="text-align: center;"> <span style="font-size: small;"><b>결과가 나오지 않는 데이터<i>(지역, 거래년/월)</i>를 관리자에게 MyQnA 메뉴를 통해 알려주세요!</b></span></div><br>

  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 