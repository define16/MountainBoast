<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<html>
<head>

<title>50대명산</title>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, 
height=device-height">
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
<jsp:useBean id="db1" class="mysql.mysql" scope="page"/>
<jsp:useBean id="db2" class="mysql.mysql" scope="page"/>
<jsp:useBean id="m" class="api.Mountain" scope="page"></jsp:useBean>
<jsp:useBean id="loc" class="mysql.mountainLocation" scope="page"></jsp:useBean>
<jsp:useBean id="data" class="mysql.mountainData" scope="page"/>
<jsp:useBean id="like" class="mysql.LikeAndDislike" scope="page"></jsp:useBean>
<% 
//좋아요 기준으로 순서 정렬 
// 이후 데이터 출력 조인써서 한번에 처리
//코드 값을 가져와서 입력.

String sql = "select * from infomountain join likemountain where infomountain.code_m = "
+ "likemountain.code_m order by like_m desc limit 50";

int rank_m = 1;
Statement stmt = null;

PreparedStatement pstmt = null;

db.connect();


stmt = db.getStatement();

// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
ResultSet rs2 = stmt.executeQuery(sql);

request.setCharacterEncoding("UTF-8");



 %>
	<center>
		<% 
		while(rs2.next()) {
				
		%>
		<table style="border:none" width="350px">
			<tr>
				<td colspan="2"><%= rank_m %> 위</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<iframe name="Map_area"  src="mapList.jsp?code=<%=rs2.getInt("code_m")%>&name=<%= rs2.getString("name_m")%>"  seamless="true"  width="350px" height="400px" 
					frameborder=0 framespacing=0 marginheight=0 marginwidth=0 vspace=0></iframe> 
			 	</td>
			</tr>

			<tr>
				<td colspan="2">
					산 명 : <%=  rs2.getString("name_m") %> <br>
					코스 명 : <%= rs2.getString("cource_m") %><br>
					난이도 : <%= rs2.getString("level_m") %><br>
				</td>
			</tr>
			<tr>
				<td>좋아요 : <%=rs2.getInt("like_m")%></td><td>싫어요 : <%=rs2.getInt("dislike_m")%></td>
			</tr>
			<tr>
				<td colspan="2">
					<button id="" onClick="location.href='third/mountain.jsp?code=<%= rs2.getString("code_m") %>'">더보기</button>
				</td>
			</tr>
		</table>
		<br/>

		<% 		
		rank_m++; 
			}

		%>
	 </center>
 <%
		db.disconnect();
 %>
 <SCRIPT language="JavaScript">
 if (self.name != 'reload') {
         self.name = 'reload';
         self.location.reload(true);
     }
     else self.name = ''; 
</SCRIPT>

</body>
</html>