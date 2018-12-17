<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, 
height=device-height">

<title>약초정보</title>

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
	db.setTableName("herbinfo");
	
	String tableName = db.getTableName();

	stmt = db.getStatement();

	// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
	ResultSet rs = stmt.executeQuery("select * from " + tableName);

	request.setCharacterEncoding("UTF-8");

	 
	if (!rs.next()) {
	out.println("해당하는 정보가 없습니다");
	}else{
	rs.previous();
	}
	%>

	
<div data_role="content">
<h1>약초 목록</h1>

	<ul data-role="listview"> 
<% 
while (rs.next()) {
	
String name_h = rs.getString("name_h");
%>

		<li>
			<a href="third/plant.jsp?name=<%= name_h %>" > <%= name_h %> </a>
	 	</li>
	 	 	<%	}	%>

 	</ul>

</div>
<%
	db.disconnect();
%>
</body>
</html>