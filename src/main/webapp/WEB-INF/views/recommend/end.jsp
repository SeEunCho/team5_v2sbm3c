<%@ page contentType="text/html; charset=UTF-8" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>관심분야 등록</title>
    {% load static %}
    <link href="{% static '/css/style.css' %}" rel="Stylesheet" type="text/css">
    <script type="text/JavaScript"
                 src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">                 

    <script type="text/javascript">
        $(function() {
            $('#btn_previous').on('click', function() { history.back(); });   // 이전
            $('#btn_close').on('click', function() { window.close(); });      // 윈도우 닫기
        });
    </script>

    <style>
        *{
            text-align: center;
        }

        .td_image{
            vertical-align: middle;
            padding: 5px;
            cursor: pointer;
        }

    </style>
    
</head>
<body>
<DIV class="container">
    <H2>참여해주셔서 감사합니다.</H2>
    <H2>추천</H2>

    <DIV id='panel' style='margin: 30px auto; width: 90%;'>
        {% if index == 0 %}
            <TABLE style='margin: 0px auto;'>
                <TR>
                <TD class='td_image'>
                    <img id='img1' src="{% static '/recommend_house/images/v11.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img2' src="{% static '/recommend_house/images/v21.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img3' src="{% static '/recommend_house/images/v31.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img4' src="{% static '/recommend_house/images/v41.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="{% static '/recommend_house/images/v51.jpg' %}" style='float:left; height: 200px'>
                </TD>
                </TR>          
            </TABLE>
        {% elif index == 1 %}
            <TABLE style='margin: 0px auto;'>
                <TR>
                <TD class='td_image'>
                    <img id='img1' src="{% static '/recommend_house/images/v12.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img2' src="{% static '/recommend_house/images/v22.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img3' src="{% static '/recommend_house/images/v32.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img4' src="{% static '/recommend_house/images/v42.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="{% static '/recommend_house/images/v52.jpg' %}" style='float:left; height: 200px'>
                </TD>
                </TR>          
            </TABLE>
        {% elif index == 2 %}
            <TABLE style='margin: 0px auto;'>
                <TR>
                <TD class='td_image'>
                    <img id='img1' src="{% static '/recommend_house/images/v13.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img2' src="{% static '/recommend_house/images/v23.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img3' src="{% static '/recommend_house/images/v33.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img4' src="{% static '/recommend_house/images/v43.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="{% static '/recommend_house/images/v53.jpg' %}" style='float:left; height: 200px'>
                </TD>
                </TR>          
            </TABLE>
        {% elif index == 3 %}
            <TABLE style='margin: 0px auto;'>
                <TR>
                <TD class='td_image'>
                    <img id='img1' src="{% static '/recommend_house/images/v14.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img2' src="{% static '/recommend_house/images/v24.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img3' src="{% static '/recommend_house/images/v34.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img4' src="{% static '/recommend_house/images/v44.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="{% static '/recommend_house/images/v54.jpg' %}" style='float:left; height: 200px'>
                </TD>
                </TR>
            </TABLE>
        {% elif index == 4 %}
            <TABLE style='margin: 0px auto;'>
                <TR>
                <TD class='td_image'>
                    <img id='img1' src="{% static '/recommend_house/images/v15.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img2' src="{% static '/recommend_house/images/v25.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img3' src="{% static '/recommend_house/images/v35.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img4' src="{% static '/recommend_house/images/v45.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="{% static '/recommend_house/images/v55.jpg' %}" style='float:left; height: 200px'>
                </TD>
                </TR>
            </TABLE>
        {% else %}
            <TABLE style='margin: 0px auto;'>
                <TR>
                <TD class='td_image'>
                    <img id='img1' src="{% static '/recommend_house/images/v16.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img2' src="{% static '/recommend_house/images/v26.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img3' src="{% static '/recommend_house/images/v36.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img4' src="{% static '/recommend_house/images/v46.jpg' %}" style='float:left; height: 200px'>
                </TD>
                <TD class='td_image'>
                    <img id='img5' src="{% static '/recommend_house/images/v56.jpg' %}" style='float:left; height: 200px'>
                </TD>
                </TR>
            </TABLE>
        {% endif %}
    </DIV>
    
    <form id='frm' name='frm' action='' method='GET'>
        <br>
        <DIV style="text-align:center;">
            <button type='button' id='btn_previous' class="btn btn-primary">이전</button>
            <button type='button' id='btn_close' class="btn btn-primary">종료</button>
        </DIV>
    </form>
</DIV>
</body>
</html>

