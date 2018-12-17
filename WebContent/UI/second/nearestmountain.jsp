<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="webProject2017.In5km"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>근처 산</title>

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" />
<link rel="stylesheet" href="cssfile/main.min.css" />
<link rel="stylesheet" href="cssfile/jquery.mobile.icons.min.css" />
<link rel="stylesheet" href="cssfile/font.css" />

</head>
<body>
<jsp:useBean id="loc" class="webProject2017.nearestMountain" scope="page"/>
<jsp:useBean id="db" class="mysql.mysql" scope="page"/>
<% 
Statement stmt1 = null;
Statement stmt2 = null;
double lat = 37.5666805;
double lon = 126.9784147;
double dist = 0.0; // 거리

ArrayList<In5km> in5klist = new ArrayList<In5km>();

db.connect();
stmt1 = db.getStatement();

ResultSet rs = stmt1.executeQuery("select lat_tmp, lon_tmp from temp_nowlocation"); //executeQuery변경

while (rs.next()) {	
	lat = rs.getDouble("lat_tmp");
	lon = rs.getDouble("lon_tmp");
}
db.disconnect();



db.connect();
stmt2 = db.getStatement();
ResultSet rs2 = stmt2.executeQuery("select * from findmountain");


%>
<center>z
<table style="border:none">
	<tr>
		<td colspan="2"> 
			<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=HPZwmCJhMW9LwytcQR5k&submodules=geocoder"></script>
	         <div id="map" style="width:100%; height:400px;"></div>
		</td>
	</tr>
	
	<tr>
		
		<td>        
		
	         <button id="" onclick="start();"> 현재 위치 </button>
	        
		</form>
		</td>
			  
		<td> 
			<form id="location_form" action="findnearmountain.jsp" method="POST" >
			 <button id="" onclick="start();"> 산 찾기 </button>
 			<input type="text" name="lat" id="lat" value="" style="display: none" data-role = "none"/>
			<input type="text" name="lng" id="lng" value="" style="display: none" data-role = "none"/>
			
		</td>
		
	</tr>
	
	<tr>
		<td colspan="2"> 
			<ol>
			<% 
			int j = 0;

			String name;

			while(rs2.next()) {
				loc.setMy_lat(lat);
				loc.setMy_lon(lon);
				dist = loc.calDistance(rs2.getDouble("lat_m"),rs2.getDouble("lon_m"));
				name = rs2.getString("name_m");
				if(dist <= 5) {
					if(name.contains("_")) {
				   		String [] name_tmp = name.split("_");
					   	if(name_tmp.length == 2){
					   		name = name_tmp[0] + name_tmp[1];
					   	}
					   	
					   	
					}
			 %>
				<li>
					산 이름 : <%= rs2.getString("name_m") %> <br>				
					현재 위치와 거리 : <%=dist %> km
					<input type="button" id="see" value="자세히" onClick="location.href='third/mountain.jsp?code=<%= rs2.getString("code_m") %>'">
				</li>
			<%	
						In5km in5km = new In5km();
						in5km.setCode(Integer.parseInt(rs2.getString("code_m")));
						in5km.setName(name);
						in5klist.add(in5km);
					} 
				}
			db.disconnect();%>
			</ol>
		</td>
	</tr>

</table>
</center>
 <script type="text/JavaScript" >
 
 var map = new naver.maps.Map('map', {
     center: new naver.maps.LatLng(<%= lat%>, <%= lon %>),
     zoom: 5,
     mapTypeId: naver.maps.MapTypeId.NORMAL
 });

 function onSuccessGeolocation(position) {
    var infowindow = new naver.maps.InfoWindow();
     var location = new naver.maps.LatLng(position.coords.latitude,
                                          position.coords.longitude);
 
     map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
     map.setZoom(10); // 지도의 줌 레벨을 변경합니다.
 
     infowindow.setContent('<div style="padding:20px;">' +
         '현재 위치입니다.</div>');
     infowindow.open(map, location);

 
     
     document.getElementById("lat").value = location.lat();
     document.getElementById("lng").value = location.lng();

 }
 
 function onErrorGeolocation() {
    var infowindow = new naver.maps.InfoWindow();
     var center = map.getCenter();
 
     infowindow.setContent('<div style="padding:20px;">' +
         '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');
 
     infowindow.open(map, center);
 }
 
 function start() {
    if (navigator.geolocation) {
         navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
     } else {
         var center = map.getCenter();
 
          infowindow.open(map, center);
     }
    
 }
 
 
 function searchCoordinateToAddress(latlng) {
     var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);

     infoWindow.close();

     naver.maps.Service.reverseGeocode({
         location: tm128,
         coordType: naver.maps.Service.CoordType.TM128
     }, function(status, response) {
         if (status === naver.maps.Service.Status.ERROR) {
             return alert('Something Wrong!');
         }

         var items = response.result.items,
             htmlAddresses = [];

         for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
             item = items[i];
             addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';

             htmlAddresses.push((i+1) +'. '+ addrType +' '+ item.address);
             htmlAddresses.push('&nbsp&nbsp&nbsp -> '+ item.point.x +','+ item.point.y);
         }

         infoWindow.setContent([
                 '<div style="padding:10px;min-width:200px;line-height:150%;">',
                 '<h4 style="margin-top:5px;">검색 좌표 : '+ response.result.userquery +'</h4><br />',
                 htmlAddresses.join('<br />'),
                 '</div>'
             ].join('\n'));

         infoWindow.open(map, latlng);
     });
 }
 <% 

String code = request.getParameter("code");
	//String code = "113050202"; //test

	int row_m = 0 , num = 0;

	for(In5km in5km : in5klist ){
	String tableName = "coordinate_" + in5km.getCode() + "_" + in5km.getName();
//	out.println(tableName);
	Statement stmt4 = null;
	Statement stmt5 = null;
	PreparedStatement pstmt = null;
	
	db.connect();
	stmt4 = db.getStatement();
	
	ResultSet row = stmt4.executeQuery("select row_m, lat_m, lon_m from " + tableName); //executeQuery변경

	while (row.next()) {	
		row_m =  row.getInt("row_m") ;
		lat = row.getDouble("lat_m");
		lon = row.getDouble("lon_m");
	}
	
db.connect();
stmt5 = db.getStatement();
request.setCharacterEncoding("UTF-8");

ResultSet rs3;

for(int k=0; k < row_m; k++)	{
	rs3 = stmt5.executeQuery("select * from " + tableName + " where row_m =" + k);
%>

var polyline<%= row_m%> = new naver.maps.Polyline({
map: map,
path: [
<%
	while (rs3.next()) {	    
%>
	new naver.maps.LatLng(<%= rs3.getDouble("lat_m")  %>, <%= rs3.getDouble("lon_m") %>),
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
	}
%>
 
 </script>
 
 <%

	Statement stmt3 = null;

	db.connect();
	stmt3 = db.getStatement();
 	String sql = "update temp_nowlocation set lat_tmp=37.5666805, lon_tmp=126.9784147 where num=1";
 	int rss  = stmt3.executeUpdate(sql);  //executeUpdate은 int 형이다.

	db.disconnect();
 %>
</body>
</html>