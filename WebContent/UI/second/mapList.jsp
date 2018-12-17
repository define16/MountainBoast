<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MapList</title>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" />
<link rel="stylesheet" href="cssfile/main.min.css" />
<link rel="stylesheet" href="cssfile/jquery.mobile.icons.min.css" />
<link rel="stylesheet" href="cssfile/font.css" />

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=HPZwmCJhMW9LwytcQR5k&submodules=geocoder"></script>
</head>
<body>

<jsp:useBean id="db" class="mysql.mysql" scope="page"/>
<jsp:useBean id="m" class="api.Mountain" scope="page"></jsp:useBean>
<jsp:useBean id="loc" class="mysql.mountainLocation" scope="page"></jsp:useBean>

<%
	String code = request.getParameter("code");
	//String code = "113050202"; //test
	String name = request.getParameter("name");
	//String name = "북한산";
		if(name.contains("_")) {
	   		String [] name_tmp = name.split("_");
		   	if(name_tmp.length == 2){
		   		name = name_tmp[0];
		   	}
		}

	int row_m = 0 , num = 0;

	double lat = 0;
	double lon = 0;

	String tableName = "coordinate_" + code + "_" + name;
//	out.println(tableName);
	Statement stmt1 = null;
	Statement stmt2 = null;
	PreparedStatement pstmt = null;
	
	db.connect();
	stmt1 = db.getStatement();

	ResultSet row = stmt1.executeQuery("select row_m, lat_m, lon_m from " + tableName + " order by index_m desc limit 1"); //executeQuery변경
	
	while (row.next()) {	
		row_m =  row.getInt("row_m") ;
		lat = row.getDouble("lat_m");
		lon = row.getDouble("lon_m");
	}
	db.disconnect();
%>
	
<div id="map" style="width:100%;height:400px;"></div>

<script>
var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(<%=lat%>, <%=lon%>),
    zoom: 8
});
<% 
//DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)

db.connect();
stmt2 = db.getStatement();
request.setCharacterEncoding("UTF-8");

ResultSet rs;

for(int i=0; i<row_m;i++)	{
	rs = stmt2.executeQuery("select * from " + tableName + " where row_m =" + i);
%>

var polyline<%= row_m%> = new naver.maps.Polyline({
 map: map,
 path: [
 <%
 	while (rs.next()) {	    
 %>
 	new naver.maps.LatLng(<%= rs.getDouble("lat_m")  %>, <%= rs.getDouble("lon_m") %>),
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
<% 
	db.disconnect();
%>
</body>
</html>