<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, 
height=device-height">
<link href="https://fonts.googleapis.com/css?family=Khand:600" rel="stylesheet">
<%
/*
   추가 사항
   
   1. 산첫페이지에 나오는 산이름을 텍스트로 적고 url 연결 v
   2. 풋터를 만들고 아래 만든이 적기v
   3. 말하기 버튼 클릭하면 말하기 버튼이 중지 버튼으로 변환 다시 시작하면 새로운 텍스트 필드에 적기
   4. 응급상황 탭에서 현재 좌표보기 눌렀을 때 위에 현 위치라고 나오게 하기
*/
%>

<title>Hiking Boast</title>

   
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" />
<link rel="stylesheet" href="cssfile/main.min.css" />
<link rel="stylesheet" href="cssfile/jquery.mobile.icons.min.css" />
<link rel="stylesheet" href="cssfile/font.css" />

<style>
#content {
   margin:5px;
   padding:10;
}
</style>
</head>

<body onresize="parent.resizeTo(500,400)" onload="parent.resizeTo(500,400)">
<jsp:useBean id="like" class="mysql.LikeAndDislike" scope="page"></jsp:useBean> <!-- getter setter -->
<%

%>

   <div data-role="header" data-position="fixed" data-id="headernav" data-position="inline">

      <form method=get action="dbsearch.jsp">
         <input data-type="search" name="search" id="search" placeholder="검색하고 싶은 산이름을 넣으세요." />
      </form>
      
   </div>
   <div data-role="header">   
      <!-- ></div><-->
            
      
      <div data-role="navbar">
         <div align=right>
         <table>
         
         <tr>
         <textarea id="result" placeholder="말하기버튼을 누르고 말하시면 텍스트가 나옵니다."></textarea>
         
            <td><label data-inline="true" style="margin-right:90px; font-family: 'Khand', sans-serif; font-size: 26px;">S P E R O</label></td>
            <td><a data-inline="true" href="#" id="listen" onclick="startConverting();" class="ui-btn ui-icon-power ui-btn-icon-right">말하기</a></td>
            <td><a data-inline="true" href="#" id="speak" class="ui-btn ui-icon-audio ui-btn-icon-right" >듣기</a></td>
            
         </tr>
         
         
         </table>
         </div>
         <ul>
            <li><input type="button" value="홈"  onclick="location.href='mainUI.jsp'"></li>
            <li><a href="mountain.html" target="MainDisplay_area"  class="ui-btn-active ui-state-persist" >산</a></li>
            <li><a href="emergency.html"  target="MainDisplay_area"> 응급상황 </a></li>
            <li><a href="information.html" target="MainDisplay_area"> 생생정보 </a></li>
         </ul>
      </div>
      
      
   </div>
   
   
   <div id="content"><span>
      <center>
          <iframe name="MainDisplay_area"  src="mountain.html"  seamless="true"  width=100% height="800px" frameborder=0 framespacing=0 
          marginheight=0 marginwidth=0  vspace=0></iframe> 
      </center>
   </span></div>
   
      <div data-role="footer" data-position="fixed" data-position="inline">
      <p> 융합소프트웨어학과 조준형</p>
      </div>
   <script src="../stt/stt.js"></script>   
   <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
   <script src="//cdnjs.cloudflare.com/ajax/libs/materialize/0.95.1/js/materialize.min.js"></script>
   <script>
      window.onfocus=function(){
      }
      window.onload=function(){
       window.focus(); // 현재 window 즉 익스플러러를 윈도우 최상단에 위치
      window.moveTo(0,0); // 웹 페이지의 창 위치를 0,0 (왼쪽 최상단) 으로 고정
      window.resizeTo(400,800); // 웹페이지의 크기를 가로 1280 , 세로 800 으로 고정(확장 및 축소)

      }
      
      
      $(function(){
           if ('speechSynthesis' in window) {
             speechSynthesis.onvoiceschanged = function() {
               var $voicelist = $('#voices'); //

               if($voicelist.find('option').length == 0) {
                 speechSynthesis.getVoices().forEach(function(voice, index) {
                   var $option = $('<option>')
                   .val(index)
                   .html(voice.name + (voice.default ? ' (default)' :''));

                   $voicelist.append($option);
                 });

                 $voicelist.material_select();
               }
             }

      
       $('#speak').click(function(){
            var text = $('#result').val();
            var msg = new SpeechSynthesisUtterance();
            var voices = window.speechSynthesis.getVoices();
            msg.voice = voices[$('#voices').val()];
            msg.text = text;

            msg.onend = function(e) {
              console.log('Finished in ' + event.elapsedTime + ' seconds.');
            };

            speechSynthesis.speak(msg);
          })
        } else {
          $('#modal1').openModal();
        }
      });
   </script>
</body>
</html>