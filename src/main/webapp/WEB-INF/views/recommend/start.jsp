<%-- <%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>관심분야 등록</title>
    <link href="{% static '/css/style.css' %}" rel="Stylesheet" type="text/css">
    <script type="text/JavaScript"
                 src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <script type="text/javascript">
      $(function() { // 자동 실행
        $('#btn_forward').on('click', function() { location.href='/recommend/form1.do'; });
        $('#btn_close').on('click', function() { window.close(); });     // 윈도우 닫기
      });

      function send() {
          var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
          // alert('params: ' + params);  // 수신 데이터 확인
          $.ajax({
            url: 'http://localhost:8000/recommend_house/start/',  // Spring Boot -> Django 호출
            type: 'get',  // get or post
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,      // 데이터
            success: function(rdata) { // 응답이 온경우
              // alert(rdata.index);
              if (rdata.index == 0) {        // 개발 관련 도서 추천 필요
                  $('#dev').css('display','');
              } else if(rdata.index == 1) { // 해외 여행 관련 도서 추천 필요
                  $('#trip').css('display','');
              } else {                            // 소설 관련 도서 추천 필요
                  $('#novel').css('display','');
              } 

              $('#panel').html("");  // animation gif 삭제
              $('#panel').css('display', 'none'); // 숨겨진 태그의 출력

              // --------------------------------------------------
              // 분류 정보에 따른 상품 이미지 SELECT
              //  --------------------------------------------------
            },
            // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
            error: function(request, status, error) { // callback 함수
              console.log(error);
            }
          });

          // $('#panel').html('처리중입니다....');  // 텍스트를 출력하는 경우
          $('#panel').html("<img src='/images/ani04.gif' style='width: 10%;'>");
          $('#panel').show(); // 숨겨진 태그의 출력
        }
    </script>
</head>
<body>
<DIV class="container">
    <H1 style="text-align: center; font-size:30px;">관심분야 등록</H1>

    <DIV style="text-align:center; margin: 50px auto;">
        관심 분야를 등록하시면 추천 서비스를 이용하실수 있습니다.<br><br>
    </DIV>

    <DIV style="text-align:center; margin: 50px auto;">
        <button type='button' id='btn_forward'>관심분야 등록하기</button>
        <button type='button' id='btn_close'>취소</button>
    </DIV>

</DIV>
</body>
</html> --%>