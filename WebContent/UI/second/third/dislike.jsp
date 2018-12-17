<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>like</title>
</head>
<body>
<jsp:useBean id="dislike" class="mysql.LikeAndDislike" scope="page"></jsp:useBean> <!-- getter setter -->
<jsp:useBean id="db" class="mysql.mysql" scope="page"/>
<% request.setCharacterEncoding("UTF-8"); %>
 <!-- 싫어요 개수 -->
<% String dislikes = request.getParameter("dislikes");
	int dislike_count = Integer.parseInt(dislikes);
	dislike.setDislike(dislike_count);
	String code = request.getParameter("code2");
%> 

<%   
int dislike_count1 =  dislike.getDislike();

Statement stmt = null;
PreparedStatement pstmt = null;

db.connect();
db.setTableName("likemountain");

String ttest = db.getTableName();

stmt = db.getStatement();
int dislike_=  dislike_count1;

// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
    String sql = "update likemountain set dislike_m='"+ dislike_ + "' where code_m = " + code;
    int rss  = stmt.executeUpdate(sql);  //executeUpdate은 int 형이다.    
   ResultSet rs = stmt.executeQuery("select * from likemountain order by dislike_m desc");
%>

<script>
	var url = "mountain.jsp?code=";
	var code = <%=code%>;
	window.location = url + code;
</script>
</body>
</html>