<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title></title>

<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<script type="text/javascript" src="https://www.google-analytics.com/analytics.js"></script>

<style>
  .btn-primary {
    color: #fff;
    background-color: #2c3e50;
    border-color: #2c3e50;
  }

  .btn-info {
    color: #fff;
    background-color: #3498db;
    border-color: #3498db;
  }
  .menu_line{
    margin: 20px 0px 20px 0px;
    padding: 5px;
  }
  
  .panel1{
    margin: 5px;
  }
  /* .input-group mb-3{
    margin: 10px;
    font-size: 12px;
  }

  .content {
    height: 75%;
  }

  .messageDiv {
    margin-top: 20px;
    margin-bottom: 50px;
  }

  .custom-btn {
    font-size: 10px;
  }

  .panel-footer {
    height: 10%;
    color: gray;
  } */

  .cropping {
    max-height: 800px;
    overflow: hidden;
  }

  .cropping img {
    max-height: initial;
    margin-top: -15%;
    margin-bottom: -10%;
  }
</style>

<script type="text/javascript">
  $(function () {
    $('#btn_cycle_start').on('click', cycle_start);  // 반복 실행을 등록하는 함수
    $('#btn_cycle_stop').on('click', cycle_stop);    // 반복 실행을 중지 시키는 함수
    $('#btn_cycle_refresh').on('click', cycle_refresh);  // 이벤트 처리 함수 등록
    $('#btn_cycle_delete_all').on('click', cycle_delete_all);  // 모든 수집된 자료 삭제 등록
    $('#btn_trend').on('click', btn_trend_analysis);  // 워드 클라우드 분석 실행
    $('#btn_trend_result').on('click', btn_trend_analysis_result);  // 분석 결과 조회

    today = new Date();
      //console.log("today.toISOString() >>>" + today.toISOString());
      today = today.toISOString().slice(0, 10);
      //console.log("today >>>> " + today);

      start_dt = document.getElementById("start_dt");
      start_dt.value = today;
      start_dt.max = today;

      last_dt = document.getElementById("last_dt");
      last_dt.value = today;
      last_dt.max = today;

    $.ajax({
        url: 'http://127.0.0.1:8000/news/get_item',
        type: 'get',  // form method, get
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        //data: params,      // 데이터
        success: function (rdata) { // 응답이 온경우
          
          var jsonData = JSON.parse(rdata);

          var str = '';
          for (var i = 0; i < jsonData.length; i++) {
            var data = jsonData[i];
            result_set = data;
            // console.log('-> ' + data.pk);
            str += '<form name="frm" id="frm" method="GET" onsubmit="delete_ajax('+data.pk+');">';
            str += '<input type="hidden" id="newsno" name="newsno" value="'+data.pk+'"></input>'
            str += '<div class="input-group mb-3">';
            str += '<div class="input-group-prepend">';
            str += '<span class="input-group-text">' + data.fields.ymd + '</span>';
            str += '</div>';
            str += '<A href="'+ data.fields.link + '" class="form-control">'+data.fields.article+'</A>';

            str += '<div class="input-group-append">';
            str += '<button type="submit" id="btn_delete" class="btn btn-warning">삭제</button>';
            str += '</div></div></form>';
          }
          $('div.toDoDiv').append(str);

        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function (request, status, error) { // callback 함수
          console.log(error);
        }
      });
  });
  
  var xhr = null;

  function getDatesStartToLast(startDate, lastDate) {
      var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
      if (!(regex.test(startDate) && regex.test(lastDate))) return "Not Date Format";
      var result = [];
      var curDate = new Date(startDate);
      while (curDate <= new Date(lastDate)) {
        result.push(curDate.toISOString().split("T")[0]);
        curDate.setDate(curDate.getDate() + 1);
      }
      return result;
    }

  var cycle_start_ajax_id = 0; // 순환 함수의 참조값 저장

  function cycle_start() { // 수집시작
      // console.log('-> cycle_start');
      // cycle_start_ajax_id = setInterval(cycle_start_ajax, 5000);  // 1000 * 5, 1000이 1초,
      // console.log('-> cycle_start_ajax_id: ' + cycle_start_ajax_id); // 3

      var startDate = $("#start_dt").val();
      var startDateArr = startDate.split('-');

      var lastDate = $("#last_dt").val();
      var lastDateArr = lastDate.split('-');

      var startDateCompare = new Date(startDateArr[0], parseInt(startDateArr[1]) - 1, startDateArr[2]);
      var lastDateCompare = new Date(lastDateArr[0], parseInt(lastDateArr[1]) - 1, lastDateArr[2]);

      var date_array = [];
      if (startDateCompare.getTime() > lastDateCompare.getTime()) { // Date값 검사
        alert("시작날짜와 종료날짜를 확인해주세요.");
        return;

      } else {
        var date_STL = getDatesStartToLast(startDate, lastDate);

        if (date_STL.length > 100) {
          alert("최대 수집기간은 100일입니다.");
          return;
        } else {
          for (i = 0; i < date_STL.length; i++) {
            date_array.push(date_STL[i].replace(/\-/g, ''));
          }
        }

        //console.log(date_array);
        $('#panel1').html("News 수집중입니다. <img src='/trend/images/bar05.gif' style='width: 50%;'>"); // static
        $('#panel1').css("display", "");
        $('#panel2').show();

        async function log(number) {
          return await
            $.ajax({
              url: 'http://127.0.0.1:8000/news/crawling', //★ Spring Boot 9091 -> Ajax -> Django 8000 호출
              type: 'POST',  // form method, get, post
              cache: false, // 응답 결과 임시 저장 취소
              async: true,  // true: 비동기 통신
              dataType: 'json', // 응답 형식: json, html, xml...
              data: { 'arr': number }     // 데이터
              , success: function (rdata) { // 응답이 온경우
                //result += rdata.cnt;
                //console.log(result);
                console.log(rdata.ymd + ' >>> ' + rdata.cnt + '건 처리됨.');
                // console.log('>>> total->' + total + '건 처리됨.');
                $('#panel2').html(rdata.ymd + ' → ' + rdata.cnt + '건 처리됨.');  // 보통 DIV, SPAN등에 출력
                $('#panel2').css("color", "blue");
                $('#panel2').show(); // 숨겨진 태그의 출력
              }, error: function (request, status, error) { // callback 함수
                console.log(error);
              }
            })
              .then(function (result) {
                console.log(result);
              });
        }

        async function run() {
          for (var i = 0; i < date_array.length; i++) {
            await log(date_array[i]);
            xhr = true;
          }
          $('#panel1').html('News 수집완료. <br>');
        }
        run();
      }
    }

  function cycle_stop() {  // 반복 실행을 중지 시키는 함수
    console.log(xhr);
    if(xhr == true){
      $('#panel1').html('News 수집을 중지했습니다.');
      $('#panel2').html('2초후 자동으로 새로 고침 됩니다');
      setTimeout(cycle_refresh, 2000);
    }
    return
  }

  function cycle_refresh() {
    location.reload(); // 현재 페이지 다시 읽기
  }

  // function cycle_start_ajax() {
  //   var params = '';
  //   console.log('-> cycle_start_ajax executed.');
  //   // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  //   // alert('params: ' + params);
  //   // return;

  //   $.ajax({
  //     url: 'http://127.0.0.1:8000/news/crawling', //★ Spring Boot 9091 -> Ajax -> Django 8000 호출
  //     type: 'get',  // form method, get
  //     cache: false, // 응답 결과 임시 저장 취소
  //     async: true,  // true: 비동기 통신
  //     dataType: 'json', // 응답 형식: json, html, xml...
  //     data: params,      // 데이터
  //     success: function (rdata) { // 응답이 온경우
  //       $('#panel1').html(rdata.cnt + '건 처리됨.');  // 보통 DIV, SPAN등에 출력
  //     },
  //     // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
  //     error: function (request, status, error) { // callback 함수
  //       console.log(error);
  //     }
  //   });

  //   console.log('-> Django json 수신 대기중');
  //   // $('#panel').html("Test");
  //   $('#panel1').html("News 수집중입니다. <img src='/trend/images/bar05.gif' style='width: 50%;'>"); // static
  //   $('#panel1').show(); // 숨겨진 태그의 출력
  //   $('#panel2').hide();
  // }

  function delete_ajax(newsno) {
    //alert(newsno);
    var params = '';
    params ='newsno=' + newsno;
    //alert('newsno: ' + newsno);

    $.ajax({
        url: 'http://127.0.0.1:8000/news/delete',
        type: 'POST',  // form method, get
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function (rdata) { // 응답이 온경우
          console.log('-> ' + rdata.msg);  // 보통 DIV, SPAN등에 출력
          // cycle_refresh();
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function (request, status, error) { // callback 함수
          console.log(error);
        }
      });

  }

  function cycle_delete_all() {
    var sw = confirm('수집된 자료를 모두 삭제 하시겠습니까?');
    if (sw == true) {
      var params = '';
      console.log('-> cycle_delete_all executed.');
      // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
      // alert('params: ' + params);
      // return;

      $.ajax({
        url: 'http://127.0.0.1:8000/news/delete_all',
        type: 'get',  // form method, get
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function (rdata) { // 응답이 온경우
          console.log('-> ' + rdata.msg);  // 보통 DIV, SPAN등에 출력
          $('#panel1').html(rdata.msg + ' 3초후 자동으로 새로 고침 됩니다.');
          setTimeout(cycle_refresh, 3000); // 3초후 자동으로 새로 고침
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function (request, status, error) { // callback 함수
          console.log(error);
        }
      });

      $('#panel1').html("모든 News 삭제중입니다. <img src='/trend/images/bar05.gif' style='width: 50%;'>"); // static
      $('#panel1').show(); // 숨겨진 태그의 출력
      $('#panel2').hide();
    }
  }

  // 워드 클라우드 분석 실행
  function btn_trend_analysis() {
    // alert('데이터분석 시작');

    var params = '';
    console.log('-> btn_trend_analysis executed.');
    // var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // alert('params: ' + params);
    // return;
    var code;
    $.ajax({
      url: 'http://127.0.0.1:8000/news/trend_analysis',
      type: 'get',  // form method, get
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function (rdata) { // 응답이 온경우
        console.log('-> ' + rdata.msg);
        code = rdata.code;
        console.log('-> ' + code);
        if(code != 0){
          var tags1 = rdata.msg;
          var tags2 = "<img src='/trend/images/news-wordcloud.png' style='width: 100%;'>";
          $('#panel1').html(tags1);
          $('#panel2').html(tags2);
          $('#panel2').show(); // 숨겨진 태그의 출력
        } else{
          var tags1 = rdata.msg;
          $('#panel1').html(tags1);
          $('#panel2').hide(); 
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
      error: function (request, status, error) { // callback 함수
        console.log(error);
      }
    });
    
    console.log('-> ' + code);
    $('#panel1').html("모든 News 분석입니다. <img src='/trend/images/bar05.gif' style='width: 50%;'>"); // static
    $('#panel1').show(); // 숨겨진 태그의 출력
    
  }

  // 분석 결과 조회
  function btn_trend_analysis_result() {
    var tags = '';
    tags += "<img src='/trend/images/news-wordcloud.png' style='width: 100%;'>";
    $('#panel2').html(tags);
    $('#panel2').show(); // 숨겨진 태그의 출력
    $('#panel1').hide(); 
  }
</script>
</head> 
<body>
  <jsp:include page="../menu/top.jsp" flush='false' />

  <DIV class='title_line'>
  <button type="button" class="btn btn-link" style='color: #2c3e50;' onclick="location.href='./news.do' ">News분석</button>
  <button type="button" class="btn btn-link" style='color: #2c3e50;' onclick="location.href='./chart.do' ">통계분석</button>
  </DIV>

  <DIV class='content_body'>
    
    <!-- <A href="http://127.0.0.1:8000/news">news</A> -->
    <div class='menu_line'></div>
  
    <div class="page-header" style="text-align: center;">
      <form name="date_send">
        <div style="padding:10px; ">
          <span style="font-weight:bold; font-size: 1.1em; margin:0px 10px 0px 0px;">Data 수집기간</span>
          <input type='date' id='start_dt' name='start_dt' min="2021-01-01" /> ~
          <input type='date' id='last_dt' name='last_dt' min="2021-01-01" />
          <!-- <button type="button" id='btn_date' class="custom-btn btn btn-warning">전달</button> -->
        </div>
      </form>
      <DIV class='content_body'>
        <button id='btn_cycle_start' class='btn btn-primary'>Data 수집 시작</button>
        <button id='btn_cycle_stop' class='btn btn-primary'>Data 수집 중지</button>
        <button id='btn_cycle_refresh' class='btn btn-primary'>수집된 내용 확인</button>
        <button id='btn_cycle_delete_all' class='btn btn-danger'>수집된 내용 모두 삭제</button>
        <button id='btn_trend' class='btn btn-success'>트렌드 분석</button>
        <button id='btn_trend_result' class='btn btn-warning'>분석 결과 조회</button>
        <DIV id='panel1'
          style='display: none; position: relative; margin: 10px auto; text-align: center; width: 60%; padding: 5px;'>
        </DIV>
        <DIV id='panel2' class="cropping" style='display: none; margin: 10px auto; text-align: center; width: 60%;'>
        </DIV>
      </DIV>
    </div>
  <div class='menu_line'></div>
  <div class="toDoDiv">
  
  
  </div>
  </DIV>
  <jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>