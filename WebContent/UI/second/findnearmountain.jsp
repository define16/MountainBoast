<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="webProject2017.Mylocation_temp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
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
	request.setCharacterEncoding("UTF-8"); 

 	String lat = request.getParameter("lat");
 	String lng = request.getParameter("lng");


 	Statement stmt = null;

 	db.connect();
 	stmt = db.getStatement();
    String sql = "update temp_nowlocation set lat_tmp='"+ lat + "', lon_tmp='"+ lng +"' where num=1";
    int rss  = stmt.executeUpdate(sql);  //executeUpdate은 int 형이다.

 	db.disconnect();

 	//"http://localhost:8008/webProject2017/UI/second/nearestmountain.jsp";
   %>
<script>
	var url = "nearestmountain.jsp";
	window.location = url;

</script>
</body>
</html>