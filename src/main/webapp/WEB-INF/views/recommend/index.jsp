<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>HOME</title>
    <link href="{% static '/css/style.css' %}" rel="Stylesheet" type="text/css">

    <script type="text/javascript">
        window.onload = function() {

        }

        function recommend_house(){
          var url = './recommend_house/start/';
          var win = window.open(url, 'AI 서비스', 'width=700px, height=560px');

          var x = (screen.width - 700) / 2;
          var y = (screen.height - 560) / 2;

          win.moveTo(x, y); // 화면 중앙으로 이동
        }

</script>


</head>
<body>
<DIV class="container" style="margin: 50px auto; width: 60%;">
<H1 style="text-align: center; font-size:30px;">추천 시스템</H1>
<H2 style="text-align: center;">a형 임시</H2>
<UL style="margin-left: 50px;">

  <LI style="list-style:none">
      <br>
      <OL style="padding-left: 150px;">

          <!-- 추천 시스템 프로젝트 -->
          <LI style="line-height: 35px;"><A href="javascript: recommend_house()">사용자의 관심 분야 파악(추천 시스템)</A></LI>



      </OL>

  </LI>
</UL>
</DIV>
</body>
</html>

