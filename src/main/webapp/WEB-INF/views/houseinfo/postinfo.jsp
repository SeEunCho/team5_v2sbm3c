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

<script src="https://maps.google.com/maps/api/js?key=이곳에API지도키넣기!!&sensor=flase" type="text/javascript"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=이곳에API지도키넣기!!&libraries=services"></script>

<script src="/js/jquery.fn.gmap.js" type="text/javascript"></script>
<script src="/js/jquery.ui.map.extensions.js" type="text/javascript"></script>
<script type="text/javascript">
$(function () {

    var container = document.getElementById('map');
    var options = {
        center : new kakao.maps.LatLng(37.5666805, 126.9784147),
        level: 7
    };    
    var map = new kakao.maps.Map(container, options);

    //alert(typeof(${jsonlist }));

    var jsonList = ${jsonlist};

    var url = 'https://maps.googleapis.com/maps/api/geocode/json?key=이곳에API지도키넣기!!&sensor=false';

    // 다음 api 지오코딩 
    for (var i in jsonList) {

      var fullAddress = jsonList[i].fullAddr;
      var partAddress = jsonList[i].partAddr;
      var contstYear = jsonList[i].cyear;
      var amount = jsonList[i].amount;
      var area = jsonList[i].area;

      fullAddress = fullAddress.replace(/\(/gi, '&#40;');
      fullAddress = fullAddress.replace(/\)/gi, '&#41;');

      var searchAddress = 'https://map.kakao.com/link/search/' + partAddress;
      console.log(searchAddress);
      var params = '&address=' +fullAddress;
      var iwContent = '<div style="text-align: center; font-size: xx-small;">' +
                        partAddress + 
      '                  </div>'  +                       
      '                    <div style="text-align: center; font-size: small;">금액: ' + 
                                 amount + 
      '                     (만원)</div>'  + 
      '                        <div style="text-align: center; font-size:small;"> 전용면적: ' +
                                   area + 
      '                             m²</div>';

      $.ajax(
      {
        url: url,
        type: 'get',
        cache: false,
        async: false,
        dataType: 'json',
        data: params,
        success: function(data) {
        if (data != null) {

          var searchAddress = 'https://map.kakao.com/link/search/' + partAddress;
          var markerPosition = new kakao.maps.LatLng(data.results[0].geometry.location.lat, data.results[0].geometry.location.lng);
          var marker = new kakao.maps.Marker({
              position: markerPosition,
              clickable: true
            } );

          marker.setMap(map);

          var infowindow = new kakao.maps.InfoWindow({
            //position : markerPosition,
            content: iwContent
          } );

          kakao.maps.event.addListener(marker, 'mouseover', function() {
            infowindow.open(map, marker);
          } );

          kakao.maps.event.addListener(marker, 'mouseout', function() {
            infowindow.close();
          } );

          kakao.maps.event.addListener(marker, 'click', function() {
            window.open(searchAddress, '다음지도 검색', 'width=1200px, height=820px');
          } );

              
        } else {
          alert("값이 뭔가 이상합니다.");
        }
      }, // end success

        error: function(request, response, error){
          console.log(error);
        }

      }

    ); // end ajax 
  }// end for statement
} )
</script>

</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />

 <DIV class='title_line'> 서울시 아파트 실거래가 데이터 (Open Api) </DIV><br>

  <c:choose>
   <c:when test="${singleApiVO != null && month != nll && year != null}">
     <div class="container" style="text-align: center;"> <h3>서울시 ${singleApiVO.name}의 ${year}년 ${month}월 아파트 실거래정보 입니다.</h3> <b>(${length }건 검색됨.)</b></div><br>
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
 
   <div class="container" id="map" style="width: 100%; height: 600px;"></div>
 
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 