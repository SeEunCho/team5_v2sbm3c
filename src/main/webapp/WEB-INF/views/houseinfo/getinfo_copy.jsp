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
    $('#search_submit').on('click', getOpenApi());
    $('#panel_explain').css("display", "none");

    var container = document.getElementById('map');
    var options = {
        center : new kakao.maps.LatLng(37.5666805, 126.9784147),
        level: 6
    };    
    var map = new kakao.maps.Map(container, options);

})

function getOpenApi() {

    parameters = $('#frm_search').serialize();

    $.ajax(

    {
        url: '/api/call_do',
        cache: false,
        async: false,
        dataType: 'json',
        data: parameters,
        success: function(rdata) {

            var jsonList = JSON.parse(rdata.jsonList);
            var url = 'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyB9MXxWL1I2d22VVQj7FzVCelxfZWBDsc8&sensor=false';


                // 다음 api 지오코딩 
            for (var i in jsonList) {

              var fullAddress = jsonList[i].fullAddr;
              var partAddress = jsonList[i].partAddr;
              var contstYear = jsonList[i].cyear;
              var amount = jsonList[i].amount;
              var area = jsonList[i].area;

              // var fullAddress = JSON.parse(jsonList[i].fullAddr);
              // var partAddress = JSON.parsejsonList[i].partAddr ;
              // var contstYear = JSON.parse() jsonList[i].cyear;
              // var amount =  JSON.parse() jsonList[i].amount;
              // var area =  JSON.parse( jsonList[i].area;


              fullAddress = fullAddress.replace(/\(/gi, '&#40');
              fullAddress = fullAddress.replace(/\)/gi, '&#41');

              var searchAddress = 'https://map.kakao.com/link/search/' + partAddress;
              var params = '&address=' +fullAddress;
              var iwContent = '<div style="padding:5px;">금액: '+ amount + '(만원)<br><span> 전용면적: ' + area + '</span></div>'

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

                error: function(request, response, error) {
                  console.log(error);
                }

              }); // end ajax 
          }// end for statement

        }, // end outer Success

        error: function(request, response, error) {
            console.log(error);
        }

    }) // end outer ajax
} // end getOpenApi func()



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

      <button type="button" id='search_submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">검색하기</button>
      <button type="button" id='btn_update_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">초기화</button>

      </form>
 </div>

    <div id="panel_explain" class="container" style="width: 100%; height: 60px; text-align: center;" >서울시 ${singleApiVO.name }의  ${year }년 ${month }월의 아파트 거래정보입니다.</div>
 
   <div class="container" id="map" style="width: 100%; height: 600px;"></div>
 
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 