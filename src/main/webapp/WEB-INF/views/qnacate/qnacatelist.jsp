<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>http://localhost:9091/</title>
<style type="text/css">
  *{ font-family: Malgun Gothic; font-size: 26px;}
</style>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<script type="text/javascript">
$(function () {
    $('#btn_update_cancel').on('click', cancel);
    $('#btn_delete_cancel').on('click', cancel);
});


function cancel() { // 입력된 데이터를 지우고 초기 생성 form 을 띄우기
   $('#panel_create').css("display", "");
   $('#panel_update').css("display", "none");
   $('#panel_delete').css("display", "none");
}


// 강의자료 코드와 함수명, html id이름은 동일 (로직도 비슷..)
function read_update_ajax(qcateno) {
   $('#panel_create').css("display", "none");
   $('#panel_update').css("display", "");
   $('#panel_delete').css("display", "none");


   // 여기 불안함. 값이 뭔지 확인해야함.
   // *********** 확인결과 ***************
   // form 값을 queryString으로 변환해주는 것임
   // qcateno=&name=&adminid=1
   // params = $('#frm_update').serialize(); 

   var params = "";
   params = 'qcateno=' + qcateno;
   // alert(params); //  테스트 확인

   $.ajax(
   {
    url:'/qnacate/' + qcateno + '/read.do',
    type: 'get',
    cache: false,
    async: true,
    dataType: 'json',
    data: params,
    success: function(rdata) {
      var qcateno = rdata.qcateno;
      var name = rdata.name;
      var adminid = rdata.adminid;

      // form 값을 현재 페이지에 list로 뿌려진 특정 카테고리 정보를 가져와 담기.
      var frm_update = $('#frm_update');
      $('#qcateno_update', frm_update).val(qcateno);
      $('#name_update', frm_update).val(name);
      $('#adminid_update', frm_update).val(adminid);

    },  // end success;

    error: function(request, status, error) {
      console.log(error);
      // 에러 말고 다른걸 처리할 수 있는 방법이 없을지 생각해보기.
    }
   }
  );  // ajax END
}

// 리조트 예제에서는 categrp -> cate -> content 계층이고
// 프로젝트에서는 Qnacate -> Qna 계층이기 때문에 한 번의 ajax만 호출.
function read_delete_ajax(qcateno) {

    $('#panel_update').css("display", "none");
    $('#panel_create').css("display", "none");
    $('#panel_delete').css("display", "");



   // 여기 불안함. 값이 뭔지 확인해야함.
   // *********** 확인결과 ***************
   // form 값을 queryString으로 변환해주는 것임
   // qcateno=&name=&adminid=1
   // params = $('#frm_delete').serialize(); 
   var params = "";
   params = 'qcateno=' + qcateno;

   // alert(params); //  테스트 확인

    $.ajax(
    {
      url: '/qnacate/read_delete',
      type: 'get',
      cache: false,
      async: true,
      dataType: 'json',
      data: params,
      success: function(rdata) {
        var qcateno = rdata.qcateno;
        var name = rdata.name;
        var adminid = rdata.adminid;
        var cnt = rdata.cnt;

        var frm_delete = $('#frm_delete');
        $('#qcateno_delete', frm_delete).val(qcateno);

        $('#frm_delete_name').html(name);
        $('#frm_delete_adminid').html(adminid);

        if (cnt > 0) { // Qna가 존재한다면.

          $('#frm_delete_cnt_panel').html( name + ' 카테고리 ' + cnt + '건의 QnA 발견');
          $('#frm_delete_cnt').show();

          // A 태그 data-pk 속성에 삭제할 qcateno pk 저장
          $('#a_delete_qna_by_qcateno').attr('data-pk', qcateno)

        } else {
          $('#frm_delete_cnt').hide();
        }
      }, // end success;
      error: function(request, status, error) {
        console.log(error);
      }
    }
  );  // ajax END
}


function list_by_qcateno() {
    
}


//delete_cate_by_qcateno

function delete_qna_by_qcateno() {
  let sw = confirm('관련된 모든 QnA 게시글이 삭제됩니다. 삭제이후 복구할 수 없습니다.\n 삭제하시겠습니까?');

  if (sw == true) {
    let qcateno = $('#a_delete_qna_by_qcateno').attr('data-pk'); // a tag data-pk 속성값을 let변수에 저장.
    var params="";
    params = 'qcateno=' + qcateno;

    $.ajax(
    {
      url: '/qna/delete_by_qcateno.do',
      type: 'post',
      cache: false,
      async: true,
      dataType: 'json',
      data: params,
      success: function(rdata) {
        var cnt = rdata.cnt;
        var qcateno = rdata.qcateno;


        if (cnt > 0) {
          alert('관련 카테고리' + cnt + '건을 삭제하였습니다.');

          var frm_delete = $('#frm_delete');

          $('#a_delete_qna_by_qcateno').hide();
          $('#frm_delete_cnt_panel').html('카테고리 삭제하기');
          $('#count_by_all_cateno').hide();

        } else {
          alert('관련 QnA글 삭제에 실패하였습니다.\n카테고리 항목으로 들어가 삭제하시거나\n전체 관리자에게 문의하십시오.');
        }
      }, // end success;
      error: function(request, status, error) {
        console.log(error);
      }
    }); // ajax END
  }    
}


</script>

</head>
<body>

    <jsp:include page="/WEB-INF/views/menu/top.jsp" flush='false' />
    <DIV class='title_line'> 주택관리 시스템 QnA Category 관리 (관리자 전용) </DIV>


    
<DIV class='content_body'>
  <!-- 신규 등록 -->

      <ASIDE class="aside_right">
        <A href="javascript:location.reload();">새로고침</A>
         <span class='menu_divide' >│</span> 
        <A href='./list.do'>목록</A>
      </ASIDE> 

      <div class='menu_line'></div>
      <br>
  
  
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='/qnacate'>
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">      
    
      <label>카테고리 이름</label>
      <input type='text' name='name' id='name' value='새 카테고리 이름' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>담당 관리자 번호</label>
      <select name='adminid' id='adminid_create'>
        <option value='1' selected="selected">전체 관리자</option>
        <option value='1'>상품관련 관리자</option>
        <option value=''>홈페이지 관리자</option>
      </select>

 <!--수정해야함!   <select name="qcateno"> <%-- db에서 동적으로 카테고리 선택 --%>
                   <c:forEach var="qnacateVO" items="${list }" varStatus="info">
                    <option value="${qnacateVO.qcateno }" ${qnacateVO.name=='상품' ? "selected='selected'" : "" } >${qnacateVO.name }</option>
                   </c:forEach>   
              </select> -->


<!--       <label>형식</label>
      <select name='visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select> -->
       
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록</button>
      <button type="button" onclick="cancel();" class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>
  </DIV>
   

  <DIV id='panel_update' 
          style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; 
                    text-align: center; display: none;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='/qnacate/update.do'>
      <input type='hidden' name='qcateno' id='qcateno_update' value=''>
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">      

      <label>카테고리 이름</label>
      <input type='text' name='name' id='name_update' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">

      <label>담당 관리자 번호</label>
      <select name='adminid' id='adminid_update'>
        <option value='1' selected="selected">전체 관리자</option>
        <option value='1'>상품관련 관리자</option>
        <option value='1'>홈페이지 관리자</option>
      </select>


 <!--수정해야함!   <select name="qcateno"> <%-- db에서 동적으로 카테고리 선택 --%>
                   <c:forEach var="qnacateVO" items="${list }" varStatus="info">
                    <option value="${qnacateVO.qcateno }" ${qnacateVO.name=='상품' ? "selected='selected'" : "" } >${qnacateVO.name }</option>
                   </c:forEach>   
              </select> -->

<!--   
         <label>형식</label>
      <select name='visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select> -->
       
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">저장</button>
      <button type="button" id='btn_update_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>
  </DIV>
  

  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
          width: 100%; text-align: center; display: none;'>
    <div class="msg_warning">카테고리 그룹을 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='/qnacate/delete.do'>
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
      <input type='hidden' name='qcateno' id='qcateno_delete' value=''>
        
      <label>카테고리 이름</label>: <span id='frm_delete_name'></span>  
      <label>담당 관리자 번호</label>: <span id='frm_delete_adminid'></span>
      
     
      <div id='frm_delete_cnt' style='color: #FF0000; font-weight: bold; display: none; margin: 10px auto;'>

        <span id='frm_delete_cnt_panel'></span>     
        <br>
        <span id='count_by_all_cateno'>관련 카테고리의 글이 존재합니다 모두 삭제해주세요 -></span>
        
        <A id='a_delete_qna_by_qcateno' href="javascript:delete_qna_by_qcateno();" data-pk='' >『관련 QnA 삭제하기(복구불가)』</A>

      </div>
       
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">삭제</button>
      <button type="button" id='btn_delete_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>

  </DIV>
    
    <DIV class='content_body'>
      <TABLE class='table table-striped'>
        <colgroup>
          <col style='width: 20%;'/>
          <col style='width: 20%;'/>
          <col style='width: 35%;'/>
          <col style='width: 25%;'/>    
        </colgroup>
       
        <thead>  
        <TR>
          <TH class="th_bs">카테고리<br> 이름 </TH>
          <TH class="th_bs">문의개수</TH>
          <TH class="th_bs">담당 관리자</TH>
          <TH class="th_bs">기타</TH>
        </TR>
        </thead>
        
        <tbody>
        <c:forEach var="qnacateVO" items="${list }">
          <c:set var="qcateno" value="${qnacateVO.qcateno }" />
          <c:set var="name" value="${qnacateVO.name }" />  
          <c:set var="adminid" value="${qnacateVO.adminid }" />
          <%-- cnt 변수 생성하기. --%>
          <%-- visible 변수. --%>
       
          <TR>
            <TD class="td_bs"><a href="/qnacate/read_one.do?qcateno=${qcateno}&name=${name}">${name }</a></TD>
            <TD class="td_bs"><a href="/qnacate/read_one.do?qcateno=${qcateno}&name=${name}">추가예정</a></TD>
            <TD class="td_bs"><a href="/qnacate/read_one.do?qcateno=${qcateno}&name=${name}">${adminid}</a></TD>                  
            <TD class="td_bs">
              <a href="javascript: read_update_ajax(${qcateno })"><IMG src='/qnacate/images/update.png' width = "20px" height="20px" title='수정'></a>
              <a href="javascript: read_delete_ajax(${qcateno })"><IMG src='/qnacate/images/delete.png'  width = "20px" height="20px" title='삭제'></a>
            </TD>         
          </TR>   
        </c:forEach> 
        </tbody>
       
      </TABLE>
    </DIV>
    
  <jsp:include page="/WEB-INF/views/menu/bottom.jsp" flush='false' />
 
</body>
</html>

