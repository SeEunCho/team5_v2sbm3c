$(document).ready(function() {

	var container = document.getElementById('map');
    var options = {
        center : new kakao.maps.LatLng(37.5666805, 126.9784147),
        level: 6
    };

    

    var map = new kakao.maps.Map(container, options);

    var geocoder = new kakao.maps.services.Geocoder();

    //alert(typeof(${jsonlist }));

    var jsonList = ${jsonlist};

    var url = 'https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyB9MXxWL1I2d22VVQj7FzVCelxfZWBDsc8&sensor=false';

    // 다음 api 지오코딩 
    for (var i in jsonList) {

      var fullAddress = jsonList[i].fullAddr;
      var partAddress = jsonList[i].partAddr;
      var contstYear = jsonList[i].cyear;
      var amount = jsonList[i].amount;
      var area = jsonList[i].area;

      fullAddress = fullAddress.replace(/\(/gi, '&#40');
      fullAddress = fullAddress.replace(/\)/gi, '&#41');

      var searchAddress = 'https://map.kakao.com/link/search/' + partAddress;
      console.log(searchAddress);
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

        error: function(request, response, error){
          console.log(error);
        }

      }

    ); // end ajax 
  }// end for statement

} );