<%@ page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, 
height=device-height">

<title>Mountian List</title>


<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" />
<link rel="stylesheet" href="cssfile/main.min.css" />
<link rel="stylesheet" href="cssfile/jquery.mobile.icons.min.css" />
<link rel="stylesheet" href="cssfile/font.css" />

</head>
<body>
<jsp:useBean id="db" class="mysql.mysql" scope="page"/>
<% 
Statement stmt = null;
db.connect();
request.setCharacterEncoding("UTF-8");
db.setTableName("infomountain");

String search = request.getParameter("search");
//String search = "수";
String tableName = db.getTableName();

stmt = db.getStatement();

// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
ResultSet rs = stmt.executeQuery("select * from " + tableName + " where name_m LIKE '%" + search + "%'");

request.setCharacterEncoding("UTF-8");



if(search==null){
	search = " ";
}
 
if (!rs.next()) {
out.println("해당하는 정보가 없습니다");
}else{
rs.previous();
}
%>
	<div data-role="header" data-position="fixed" data-id="headernav">

		<h1> 검색 내역</h1>
	</div>
	<ul data-role="listview" data-inset="true"> 
	<% 
	//객체의 값이 있으면 TRUE
	while (rs.next()) {
	
	String name_m = rs.getString("name_m");
	String code_m = Integer.toString(rs.getInt("code_m"));
	%>
	
		<li>
			<a rel="external" href="second/third/mountain.jsp?code=<%= code_m %>"> <% out.println(name_m); %></a> 
	 	</li>
	 	
	 	<% } %> 		
 	</ul>

<% 
 db.disconnect();
%>



</body>
</html>