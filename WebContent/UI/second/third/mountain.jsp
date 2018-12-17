<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<%! private static String getTagValue(String tag, Element eElement) {
    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
    Node nValue = (Node) nlList.item(0);
    if(nValue == null) 
        return null;
    return nValue.getNodeValue();
} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, 
height=device-height">


<title>MountainInfo</title>


<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" />
<link rel="stylesheet" href="cssfile/main.min.css" />
<link rel="stylesheet" href="cssfile/jquery.mobile.icons.min.css" />
<link rel="stylesheet" href="cssfile/font.css" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=HPZwmCJhMW9LwytcQR5k&submodules=geocoder"></script>
</head>

<body>
<jsp:useBean id="db" class="mysql.mysql" scope="page"/>
<jsp:useBean id="data" class="mysql.mountainData" scope="page"/>
<jsp:useBean id="m" class="api.Mountain" scope="page"></jsp:useBean>
<jsp:useBean id="like" class="mysql.LikeAndDislike" scope="page"></jsp:useBean>
<% 
	int like_count;	// 좋아요 갯수
	int dislike_count;	// 싫어요 갯수
	
	String code = request.getParameter("code");
	//int code = 113050202; //test

	like.setSwitch_like(1);

	int switch_like = 1;
	int switch_dislike = 1;


	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	db.connect();
	db.setTableName("Infomountain");
	
	String tableName = db.getTableName();

	stmt = db.getStatement();
	
	// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
	//ResultSet rs = stmt.executeQuery("select * from " + tableName + " where code_m =" + code );
	ResultSet rs = stmt.executeQuery("select * from infomountain join likemountain where " +
			"infomountain.code_m = likemountain.code_m and infomountain.code_m = " + code );
	request.setCharacterEncoding("UTF-8");
	while (rs.next()) {
		data.setName(rs.getString("name_m")) ;
		data.setCource( rs.getString("cource_m"));
		data.setHeight(rs.getDouble("height_m"));
		data.setLevel(rs.getString("level_m"));
		data.setUptime(rs.getDouble("uptime_m"));
		data.setDowntime(rs.getDouble("downtime_m"));
		like.setLike(rs.getInt("like_m")) ;
		like.setDislike( rs.getInt("dislike_m"));
	//}
	
	//ResultSet rs1 = stmt.executeQuery("select * from likemountain" + " where code_m =" + code );

	//request.setCharacterEncoding("UTF-8");
	//while (rs1.next()) {
	//	like.setLike(rs1.getInt("like_m")) ;
	//	like.setDislike( rs1.getInt("dislike_m"));
	}

	like_count = like.getLike();
	dislike_count = like.getDislike();
			
	%>

	<%	//api 가져오기
		String sreach_info = data.getName();
		m.setSreach_info(sreach_info);
		m.infoMountainAPI();
		m.imgMountainAPI();

		String sreachNo_img = m.getSreachNo_img();
		String address = m.getAddress();
		String height = m.getHeight();
		String details = m.getDetails();
		String summary = m.getSummary();
		String image1 = m.getImage1();
		String image2 = m.getImage2();
		String image3 = m.getImage3();
		
		db.disconnect();
	%>
	
<center>
<table  width=100%  style="border:none">
<tr>
	<td colspan="4">
		<ul style="list-style:none">
			<li>
				<img src='http://www.forest.go.kr/images/data/down/mountain/<%=image1 %>' alt='' width=100%/>
			</li>
			<li>
				<img src='http://www.forest.go.kr/images/data/down/mountain/<%=image2 %>' alt='' width=100%/>
			</li>
			<li>
				<img src='http://www.forest.go.kr/images/data/down/mountain/<%=image3 %>' alt='' width=100%/>
			</li>
		</ul>
	</td>
</tr>

<tr>
	<td colspan="4">
		<div id="map" style="width:100%;height:400px;"></div>
	</td>
</tr>

<tr>
	<td colspan="4">
			산이름 : <%= data.getName() %> <br/>
			등산로 :  <%= data.getCource() %> <br/>
			높이 : <%= height %> m <br/>
			난이도 :    <%= data.getLevel() %> <br/>
			올라가는 시간 :   <%= data.getUptime() %> 시간 <br/>
			내려오는 시간 :  <%= data.getDowntime() %> 시간 <br/>
			주소 : <%= address %>

	</td>
</tr>
<tr>
	<td colspan="4">
	<h2> 상세 설명 </h2>
	 <%= details %> <br/>
	 <%= summary %>
	</td>
</tr>
<tr>
	<td>
		좋아요  <a id="like" name="like"><%= like_count %></a>
	</td>
	<td>
		싫어요  <a id="dislike" name="dislike"><%= dislike_count %></a>
	</td>
</tr>
<tr>
	<td>
		<form id="like_form" action="like.jsp" method="POST" >
			<button id="like_btn" onclick="like_onclick();" style="width: 100%"><img src="files/like.png" ></button>
			<input type="text" value="<%= like_count %>" id ="likes" name="likes" data-role = "none" style="display: none;">
			<input type="text" value="<%= code %>" id ="code1" name="code1" style="display: none;" data-role = "none"/>
		</form> 
	</td>
				
	<td>
		<form id="dislike_form" action="dislike.jsp" method="POST" >
			<button id="dislike_btn" onclick="dislike_onclick();" style="width: 100%"><img src="files/dislike.png" ></button>
			<input type="text" value="<%= dislike_count %>" id ="dislikes" name="dislikes" style="display: none;" data-role = "none">
			<input type="text" value="<%= code %>" id ="code2" name="code2" style="display: none" data-role = "none"/>
		</form>
					
	</td>
</tr>
</table>
</center>

<script>
var likecount= <%= like_count%>;
var dislikecount= <%= dislike_count%>;
var count1=<%=switch_like%>;
var count2=<%=switch_dislike%>;

function like_onclick() {

	   if(count1%2 == 1){
		   likecount++;
		   document.getElementById("like").innerHTML = likecount;
		   document.getElementById("likes").value = likecount;
		   alert("좋아요를 누르셨습니다.");
		   document.like_form.url.value=likecount;
		  
	   }
	   else{
		   likecount--;
		   document.getElementById("like").innerHTML = likecount;
		   document.getElementById("likes").value = likecount;
		   alert("좋아요가 해제되었습니다.");
		   document.like_form.url.value=likecount;
		   
		   }
	}

	function dislike_onclick() {
		
		   if(count2%2 == 1){
			   dislikecount++;
			   document.getElementById("dislike").innerHTML = dislikecount;
			   document.getElementById("dislikes").value = dislikecount;
			   alert("싫어요를 누르셨습니다. ㅠ");
			   document.dislike_form.url.value=dislikecount;
		   }
		   else{
			   dislikecount--;
			   document.getElementById("dislike").innerHTML = dislikecount;
			   document.getElementById("dislikes").value = dislikecount;
			   alert("싫어요를 해제합니다. ^^");
			   document.dislike_form.url.value=dislikecount;
			   
		   }

		 
	}
</script>

<%
	double lat = 0;
	double lon = 0;
	int row_m = 0;
	String tmp = data.getName();
	String [] name_tmp = {};
	String loc_tableName = null;
	if(tmp.contains("_")) {
   		name_tmp = tmp.split("_");
	   	if(name_tmp.length == 2){
	   		tmp = name_tmp[0] + name_tmp[1];
	   		loc_tableName = "coordinate_" + code + "_" + name_tmp[0];
	   	}
	}
	else {
	 	loc_tableName = "coordinate_" + code + "_" + tmp;
	}
	//out.println(tableName);
	Statement stmt1 = null;
	Statement stmt2 = null;
	
	db.connect();
	stmt1 = db.getStatement();
	
	ResultSet row = stmt1.executeQuery("select row_m, lat_m, lon_m from " + loc_tableName + " order by index_m desc limit 1"); //executeQuery변경
	
	while (row.next()) {	
		row_m =  row.getInt("row_m") ;
		lat = row.getDouble("lat_m");
		lon = row.getDouble("lon_m");
	}
	db.disconnect();

%>

<script language='javascript'>
$(document).ready(function() {
	$("#likes").hide(); 
    $("#code1").hide(); 
	$("#dislikes").hide(); 
    $("#code2").hide(); 
   	$("#url_send").hide(); 
    $("#name_send").hide(); 
});
	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(<%=lat%>, <%=lon%>),
	    zoom: 8
	});


<% 
//DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
db.connect();
stmt2 = db.getStatement();
request.setCharacterEncoding("UTF-8");

ResultSet rs2;

for(int i=0; i<row_m;i++)	{
	rs2 = stmt2.executeQuery("select * from " + loc_tableName + " where row_m =" + i);
%>

var polyline<%= row_m%> = new naver.maps.Polyline({
 map: map,
 path: [
 <%
 	while (rs2.next()) {	    
 %>
 	new naver.maps.LatLng(<%= rs2.getDouble("lat_m")  %>, <%= rs2.getDouble("lon_m") %>),
 <% 
		}
 %>
	],
 clickable: true,
 strokeColor: '#E51D1A',
 strokeStyle: 'solid',
 strokeOpacity: 0.5,
 strokeWeight: 2
});

naver.maps.Event.addListener(polyline<%= row_m %>, 'mouseover', function() {

 polyline.setOptions({
     strokeColor: '#5347AA',
     strokeStyle: 'longdash',
     strokeOpacity: 4
 });
});

naver.maps.Event.addListener(polyline<%= row_m %>, 'mouseout', function() {

 polyline.setOptions({
     strokeColor: '#E51D1A',
     strokeStyle: 'solid',
     strokeOpacity: 2
 });
});

<% 	
	}
%>

</script>


</body>
</html>