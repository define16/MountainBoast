<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="like" class="mysql.LikeAndDislike" scope="page"></jsp:useBean> <!-- getter setter -->
<jsp:useBean id="db" class="mysql.mysql" scope="page"/>
<% request.setCharacterEncoding("UTF-8"); %>
<!--  test1 은 산의 시작 위치 표시 ,, test0 는 나의 현재 위치  -->

 <!-- 좋아요 개수 -->
<% String likes = request.getParameter("likes");
	int like_count = Integer.parseInt(likes);
	like.setLike(like_count);
	
	String code = request.getParameter("code1");
	
	int switch_like = like.getSwitch_like();
	int switch_dislike = like.getSwitch_dislike();
	
	//like.setSwitch_like(switch_like+1);
	like.setSwitch_dislike(switch_dislike+1);

%> 


<%   
int like_count1 = like.getLike();

Statement stmt = null;
PreparedStatement pstmt = null;

db.connect();
db.setTableName("likemountain");

String ttest = db.getTableName();

stmt = db.getStatement();
int like_=  like_count1;

// DB에 들어있는 정보를 가져와서 rs객체로저장 (출력)
    String sql = "update likemountain set like_m='"+ like_ + "' where code_m = " +code;
             int rss  = stmt.executeUpdate(sql);  //executeUpdate은 int 형이다.
             
   
             
//   ResultSet rs = stmt.executeQuery("select * from likemountain order by like_m desc");
   %>

<script>
	var url = "mountain.jsp?code=";
	var code = <%=code%>;
	window.location = url + code;

</script>
</body>
</html>