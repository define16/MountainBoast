<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, 
height=device-height">

<title>식물정보</title>

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile.structure-1.4.5.min.css" />
<link rel="stylesheet" href="cssfile/main.min.css" />
<link rel="stylesheet" href="cssfile/jquery.mobile.icons.min.css" />
<link rel="stylesheet" href="cssfile/font.css" />

</head>
<body>
<jsp:useBean id="ih" class="api.infoherb" scope="page"></jsp:useBean>
<jsp:useBean id="herbapi" class="api.Herb" scope="page"></jsp:useBean>

<%
	String addr = "http://openapi.forest.go.kr/openapi/service/mclltInfoService/getMclltSearch?";
	String sreach_type = "st=3&sw=";	// 1. 식물일반명(유사검색) 2. 식물종학명(유사검색) 3. 식물일반명(일치검색) 4. 식물종학명(일치검색) 
	String sreach_herb =  request.getParameter("name");
	String serviceKey = "&serviceKey=vj4dxuSsj2rbjVI5s7bf1E0El21porvaChQRh5ggyetZiMvDs6UABEYKDA9pi7gpvI5tKW8WSysUOtBmux2M2w%3D%3D";
	int pageNo = 1; //&pageNo=54 까지
	String data[] = null;
			
	 try { 
     	sreach_herb = URLEncoder.encode(sreach_herb, "UTF-8");
     	
     		addr = addr + sreach_type + sreach_herb + serviceKey;
//     		addr = addr + sreach_type + serviceKey + + "&numOfRows=1" + "&pageNo=" + page; //1개씩 출력
//     		addr = addr + serviceKey +"&numOfRows=534"; //전제 출력
     		
     		// parse the document
     		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
     		DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
     		Document doc = dBuilder.parse(addr);
     		// root tag 
     		doc.getDocumentElement().normalize();
     		//System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result

     		NodeList nList = doc.getElementsByTagName("item");
     		
     		for(int temp = 0; temp < nList.getLength(); temp++){		
     			Node nNode = nList.item(temp);
     			if(nNode.getNodeType() == Node.ELEMENT_NODE){
     								
     				Element eElement = (Element) nNode;
     				
    				ih.setName(getTagValue("mclltSpecsNm", eElement));
    				ih.setPlantClsscNm(getTagValue("plantClsscNm", eElement)); 
    				ih.setMclltSfrmdNm( getTagValue("mclltSfrmdNm", eElement));
    				ih.setPlantFamlNm (getTagValue("plantFamlNm", eElement));
    				ih.setPlantEclgDscrt (getTagValue("plantEclgDscrt", eElement));
    				ih.setMclltDistrDscrt (getTagValue("mclltDistrDscrt", eElement));
    				ih.setUseway (getTagValue("usMthodDscrt", eElement));
    				ih.setEatway (getTagValue("mclltDoseMthodDscrt", eElement));
    				ih.setImage1 (getTagValue("mclltPnrmImageFileNm", eElement));
    				ih.setImage2 (getTagValue("mclltUsRgnImageFileNm", eElement));
    				ih.setImage3 (getTagValue("mdciUsImageFileNm", eElement));

       				}	// for end
     		}	// if end
     	}
     catch (Exception e) 
     {
         e.printStackTrace();
     } //try


%>

<table style="border:none">
	<tr>
		<td colspan="2">
			<img src="<%= ih.getImage1() %>" width="100px">
			<img src="<%= ih.getImage2() %>" width="100px">
			<img src="<%= ih.getImage3() %>" width="100px">
		</td>
		
		<td colspan="2">
			<ul>
				<li>이름 : <%= ih.getName() %></li>
				<li>약재명 :  <%= ih.getPlantClsscNm() %></li>
				<li>식물과명   <%= ih.getMclltSfrmdNm() %></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			특징 및 설명 <br>
			식물생태설명  :  <%= ih.getPlantEclgDscrt() %> <br>     				
			분포설명 :  <%= ih.getMclltDistrDscrt() %> <br>
			이용방법  :  <%= ih.getUseway() %> <br>
			복용방법 :  <%= ih.getEatway() %> <br>
		</td>
	</tr>
</table>
</body>
</html>