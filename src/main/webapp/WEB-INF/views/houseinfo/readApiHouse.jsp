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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=587a4e98e5eb5e4d4a5dd25e7ddda665&libraries=services"></script>

<script type="text/javascript">

$(function () {

  // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 zzz
  function closeOverlay() {
      overlay.setMap(null);     
   }

    var lat = eval(${apihouseVO.lat});
    var lon = eval(${apihouseVO.lon});

    console.log(lat);
    console.log(lon);

    var name = '${apihouseVO.name}'; // jstl이 먼저 컴파일되는걸 생각해보면 해결! 

    var container = document.getElementById('map');
    var options = {
        center : new kakao.maps.LatLng(lon, lat),
        level: 4
    };    


    var content = '<div class="wrap">' + 
      '    <div class="info">' + 
      '        <div class="title">' + name + 
      '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
      '        </div>' + 
      '        <div class="body">' + 
      '            <div class="img">' +
      '                <img src="/images/house_pavicon.ico" width="73" height="70">' +
      '           </div>' + 
      '            <div class="desc">' + 
      '                <div class="ellipsis">아파트</div>' + 
      '                <div class="jibun ellipsis">건축년도: 2002년</div>' + 
      '            </div>' + 
      '        </div>' + 
      '    </div>' +    
      '</div>';

    var map = new kakao.maps.Map(container, options);

    var markerPosition = new kakao.maps.LatLng(lon, lat);

    var marker = new kakao.maps.Marker({
        map: map,
        position: markerPosition
      });

    marker.setMap(map);


  var overlay = new kakao.maps.CustomOverlay({
      content: content,
      map: map,
      position: marker.getPosition()       
    });

         // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
  kakao.maps.event.addListener(marker, 'click', function() {
    overlay.setMap(map);
  });


})



</script>


</head>
<body>

 <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />

 <DIV class='title_line'> 아파트 거래정보 상세 페이지  </DIV>

    <div class="container" id="map" style="width: 100%; height: 600px;"></div>

    <div>
      이름 = ${apihouseVO.name}<br>
      전용면적 = ${apihouseVO.area}
    </div>

  <DIV class='bottom_menu'>
    <!-- <a href="${nUrl}" class="btn btn-primary btn-sm" >네이버 부동산<br> 검색하기</a> -->
    <%-- <button type='button' onclick="location.href='${nUrl}'" class="btn btn-primary btn-sm">네이버 부동산<br> 검색하기</button> --%>
    <button type='button' onclick="location.href='https://map.kakao.com/link/search/${apihouseVO.name}'" class="btn btn-primary btn-sm">다음 맵으로<br>검색하기</button>
  </DIV>
 

  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
  
</body>
</html>

 