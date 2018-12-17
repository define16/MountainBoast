package mysql;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class XsdElements {
	  public static void main(String args[]) { 
	        //JSON으로 Parsing할 문자열 데이터
	    	String DBName = "hiking_boast"; //db이름
	    	String url = "jdbc:mysql://localhost:3306/"+DBName;// user테이블을 수정하면
	    	String strUser = "root"; // 계정 id
	    	String strPassword = "1234"; // 계정 패스워드
	    	String strMySQLDriver = "com.mysql.jdbc.Driver"; // 드라이버 이름 따로 만들어줌
	    	Connection con = null;	//db 연결
	    	Statement stmt = null;	//db 삽입시 이용
	    	int cnt = 0;
	    	
        	String URL1 = "D:\\대학교\\3학년 2학기\\웹프로그래밍\\과제\\프로젝트\\data\\mountain\\gpx\\산좌표 (";
        	String URL2 = ").gpx";
        	

  	    	try {
			Class.forName(strMySQLDriver);	//db드라이버설정

            con  = (Connection) DriverManager.getConnection(url,strUser,strPassword); // 연결
            System.out.println("Mysql DB Connection.");
            
            stmt = (Statement) con.createStatement();
            System.out.println("stmt");
            PreparedStatement pstmt = null;	//db삽입시 이용
            
		        try { 
		            // parse the document
		        	
		        	for(int i = 1 ; i < 2920; i++)	{	
		        		String finalurl = URL1 + i + URL2;
			            DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
			            DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
			            Document doc = docBuilder.parse (new File(finalurl));
			            
			            NodeList name = doc.getElementsByTagName("trk");
			            Node nNode = name.item(0);
			            Element name1 = (Element) nNode;

			            String code = getTagValue("name",name1);
			            //System.out.println("이름 : " + code); 
			            String [] code_m = code.split("_");
			            

			            if(code_m.length <= 3) {
			          //  System.out.println(i + "번째 생성전");
//			            System.out.println("산코드 : " + code_m[2]);
//			            System.out.println("산이름 : " + code_m[1]);
//			            System.out.println();
			            int total = 0; 	
			            int tmp_code = Integer.parseInt(( code_m[2]));
			            String tmp_name = new String( code_m[1].getBytes("UTF-8"),"UTF-8");	//utf-8로 변환
			            
			            //테이블 생성 쿼리문
			            String CREATEsql = "CREATE TABLE coordinate_" + tmp_code + "_" + tmp_name + " ( " +
			            "index_m	int(20)			NOT NULL, " +
		                "code_m 	int(20)			NOT NULL, " +
		                "name_m    	varchar(255) 	NULL, " +
		                "row_m		int(20)			NOT NULL, " +
		                "lat_m  		double(100,10) 	NOT NULL, " +
		                "lon_m   		double(100,10)	NOT NULL "
		                +" );";           
			            stmt.executeUpdate(CREATEsql);
			            
			            //System.out.println(i + "번째 생성 성공");
			            
			            for(int k = 0; k < name.getLength(); k++) {
				            Node nNode1 = name.item(k);
				            Element name2 = (Element) nNode1;
				            NodeList list = name2.getElementsByTagName("trkpt"); 
				             
				            for(int j = 0 ; j < list.getLength(); j++)
				            {
				                Element first = (Element)list.item(j);
				                if(first.hasAttributes())
				                {
					                    double lat = Double.parseDouble(first.getAttribute("lat")); 
					                   // System.out.println(j + "번째 lat " + lat); 
					                   double lon = Double.parseDouble(first.getAttribute("lon")); 
					                   // System.out.println(j + "번째 lon " + lon); 
					                   total++;
						                //data Insert
					                   // System.out.println("삽입전");
							            	
								         // 쿼리문을 직접 만들어 준다.
								         String sql = "insert into coordinate_" + tmp_code + "_" + tmp_name + 
								        		 " values('" + total + "','" +  tmp_code + "','" + tmp_name + "','" + k + "','"
								                		+ lat  + "','" +  lon + "')";	
								         // 쿼리문을 삽입 후 데이터 삽입
								         int rss  = stmt.executeUpdate(sql);  //executeUpdate은 int 형이다.

								          //System.out.println(j+"번째 Insert Data");
					                //if문first.hasAttributes()
				               	}
				             }
			            }
			            }
			            
			            else if(code_m.length > 3 && code_m.length < 5){
			            	int total = 0;
			            	//System.out.println(i + "번째 생성 전");
//			            	System.out.println("산코드 : " + code_m[3]);
//			            	System.out.println("산이름 : " + code_m[1] + code_m[2]);
			            	int tmp_code = Integer.parseInt(( code_m[3]));
				            String tmp_name = new String( code_m[1].getBytes("UTF-8"),"UTF-8");	//utf-8로 변환
			            	String tmp_name2 = new String( code_m[2].getBytes("UTF-8"),"UTF-8");	//utf-8로 변환
			            	
				            String CREATEsql = "CREATE TABLE coordinate_" + tmp_code + "_" + tmp_name + " ( " +
						            "index_m	int(20)			NOT NULL, " +
					                "code_m 	int(20)			NOT NULL, " +
					                "name_m    	varchar(255) 	NULL, " +
					                "row_m		int(20)			NOT NULL, " +
					                "lat_m  		double(100,10) 	NOT NULL, " +
					                "lon_m   		double(100,10)	NOT NULL "
					                +" );";           
						            stmt.executeUpdate(CREATEsql);

					           
					//	    System.out.println(i + "번째 생성 성공");
						    for(int k = 0; k < name.getLength(); k++) {
					            Node nNode1 = name.item(k);
					            Element name2 = (Element) nNode1;
					            NodeList list = name2.getElementsByTagName("trkpt"); 
					            //System.out.println(k + "번째 trk");
					            
				            //loop to print data
				            for(int j = 0 ; j < list.getLength(); j++)
				            {
				                Element first = (Element)list.item(j);
				                if(first.hasAttributes())
				                {
				                	//if(cnt%5==0)	{
					                    double lat = Double.parseDouble(first.getAttribute("lat")); 
					                   // System.out.println(j + "번째 lat " + lat); 
					                    double lon = Double.parseDouble(first.getAttribute("lon")); 
					                    //System.out.println(j + "번째 lon " + lon); 
					                    total++;
						                //data Insert
								           // System.out.println("삽입전");
								               // 쿼리문을 직접 만들어 준다.
					                    String sql = "insert into coordinate_" + tmp_code + "_" + tmp_name + " values('" + total + "','" +  tmp_code + "','" + tmp_name + "','" + k + "','"
						                		+ lat  + "','" +  lon + "')";	
						         // 쿼리문을 삽입 후 데이터 삽입
					                    int rss  = stmt.executeUpdate(sql);  //executeUpdate은 int 형이다.
//								                System.out.println(j+"번째 Insert Data");
					                   
					                }
				                
				                }
				            } //for문 (좌표)
					//	    }
						   // System.out.println(total + "총 번째");
						    
			            }
			            
			            else {
			            	System.out.println("4이상 오류!");
			            	System.out.println(i + "번째");
				            System.out.println("산코드 : " + code_m[1] + code_m[2]);
				            System.out.println("산이름 : " + code_m[3]);
			            	System.out.println("4이상 오류!");
			            }       
			            System.out.println(i + " 번째 삽입 성공");
		        	}//for문
		        } 
		        catch (ParserConfigurationException e) 
		        {
		            e.printStackTrace();
		        }
		        catch (SAXException e) 
		        { 
		            e.printStackTrace();
		        }
		        catch (IOException ed) 
		        {
		            ed.printStackTrace();
		        } //try
		        
		        
	            stmt.close();  
	            con.close();  
	            System.out.println("삽입완료");
  	  	} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}	//try
	 }//main
	 
	// 테크 안에 있는 데이터를 가지오는 함수
	  private static String getTagValue(String sTag, Element eElement) {	
		  NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		  
		         Node nValue = (Node) nlList.item(0);
		  
		  return nValue.getNodeValue();
	  }
}
