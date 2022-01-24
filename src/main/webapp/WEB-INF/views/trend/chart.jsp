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


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

<script type="text/javascript" src="https://www.google-analytics.com/analytics.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/4.1.0/echarts-en.common.min.js"></script>
   
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
	  $('#chart1').on('click', pyechart1);
      $('#chart2').on('click', pyechart2);
      $('#chart3').on('click', pyechart3);

      pyechart1();
      
  });

  function pyechart1() { 
      $.ajax({
        url: 'http://127.0.0.1:8000/property/chart1',
        type: 'post',  // form method, get
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        //data: params,      // 데이터
        success: function (rdata) { // 응답이 온경우
          //console.log('-> ' + rdata.myechart);  // 보통 DIV, SPAN등에 출력
          //console.log('-> ' + rdata.host);  // 보통 DIV, SPAN등에 출력
          //console.log('-> ' + rdata.script_list);  // 보통 DIV, SPAN등에 출력
          myechart = rdata.myechart;
          host = rdata.host;
          script_list = rdata.script_list;
          for (i = 0; i < script_list.length; i++) {
            //console.log(host+'/'+script_list[i]+'.js');
            $.getScript(host+'/'+script_list[i]+'.js');
          }
          
          $('.tab-content #chart1_cont').html(myechart);
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function (request, status, error) { // callback 함수
          console.log(error);
        }
      });

    }
   

    function pyechart2() { 
      $.ajax({
        url: 'http://127.0.0.1:8000/property/chart2',
        type: 'post',  // form method, get
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        //data: params,      // 데이터
        success: function (rdata) { // 응답이 온경우
          //console.log('-> ' + rdata.myechart);  // 보통 DIV, SPAN등에 출력
          //console.log('-> ' + rdata.host);  // 보통 DIV, SPAN등에 출력
          //console.log('-> ' + rdata.script_list);  // 보통 DIV, SPAN등에 출력
          myechart = rdata.myechart;
          host = rdata.host;
          script_list = rdata.script_list;
          sl=[];

          for (i = 0; i < script_list.length; i++) {
            console.log(host+'/'+script_list[i]+'.js');
            sl.push(host+'/'+script_list[i]+'.js')
            $.getScript(host+'/'+script_list[i]+'.js');
          }
          
          console.log(script_list.length);
          $('.tab-content #chart2_cont').html(myechart);
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function (request, status, error) { // callback 함수
          console.log(error);
        }
      });
    }

    function pyechart3() { 
      $.ajax({
        url: 'http://127.0.0.1:8000/property/chart3',
        type: 'post',  // form method, get
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        //data: params,      // 데이터
        success: function (rdata) { // 응답이 온경우
          //console.log('-> ' + rdata.myechart);  // 보통 DIV, SPAN등에 출력
          //console.log('-> ' + rdata.host);  // 보통 DIV, SPAN등에 출력
          //console.log('-> ' + rdata.script_list);  // 보통 DIV, SPAN등에 출력
          myechart = rdata.myechart;
          host = rdata.host;
          script_list = rdata.script_list;
          sl=[];

          for (i = 0; i < script_list.length; i++) {
            //console.log(host+'/'+script_list[i]+'.js');
            sl.push(host+'/'+script_list[i]+'.js')
            $.getScript(host+'/'+script_list[i]+'.js');
          }
          
          console.log(sl);
          $('.tab-content #chart3_cont').html(myechart);

        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
        error: function (request, status, error) { // callback 함수
          console.log(error);
        }
      });
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
    
  
    <div class="page-header" style="text-align: center;">

        <ul class="nav nav-pills">
          <li class="nav-item">
            <a class="nav-link active" id='chart1' data-toggle="tab" href="#chart1_cont" style="font-size: 14px">구별 평균 거래금액</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id='chart2' data-toggle="tab" href="#chart2_cont" style="font-size: 14px">구별 거래량</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id='chart3' data-toggle="tab" href="#chart3_cont" style="font-size: 14px">월별 거래량</a>
          </li>
        </ul>
        <div class='menu_line' style="margin: 0px 0px 20px 0px;"></div>
        <div class="tab-content" style="display: flex; justify-content: center; margin: 10px">
          <div class="tab-pane fade show active" id="chart1_cont">

          </div>
          <div class="tab-pane fade" id="chart2_cont">

          </div>
          <div class="tab-pane fade" id="chart3_cont">

            
          </div>
        </div>
      
    </div>
  <!-- <div class='menu_line'></div> 
  <div class="toDoDiv">
  
  
  </div>-->
  </DIV>
  <jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>