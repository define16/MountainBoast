package mysql;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class mysql_input_json_data {

	    public static void main(String[] args) {
	        //JSON으로 Parsing할 문자열 데이터
	    	String DBName = "hiking_boast"; //db이름
	    	String url = "jdbc:mysql://localhost:3306/"+DBName;// user테이블을 수정하면
	    	String strUser = "root"; // 계정 id
	    	String strPassword = "1234"; // 계정 패스워드
	    	String strMySQLDriver = "com.mysql.jdbc.Driver"; // 드라이버 이름 따로 만들어줌
	    	Connection con = null;	//db 연결
	    	Statement stmt = null;	//db 삽입시 이용

	        String URL1 = "D:\\대학교\\3학년 2학기\\웹프로그래밍\\과제\\프로젝트\\data\\mountain\\json\\등산 (";
	        String URL2 = ").json";	//url이름
	        
            try
            {
            	Class.forName(strMySQLDriver);	//db드라이버설정

                con  = (Connection) DriverManager.getConnection(url,strUser,strPassword); // 연결
                System.out.println("Mysql DB Connection.");
                
                stmt = (Statement) con.createStatement();
                System.out.println("stmt");
                PreparedStatement pstmt = null;	//db삽입시 이용
                
		    	for(int i=1; i < 2878; i++) {	//2878개의 json데이터을 입력시작
		    		System.out.println("for문작동");
			        String URL = URL1 + i + URL2;
			        
			        JSONParser jsonParser = new JSONParser();	//json파싱 시작
			    	 
		    
			        try {
			        	Object obj = jsonParser.parse(new FileReader(URL));	//주소값 지정
			            JSONObject jsonObj = (JSONObject) obj;	//json은 오브젝트 형식이라서 오브젝트로 선언한다.
			            JSONArray memberArray = (JSONArray) jsonObj.get("features");	//features의 데이터를 배열 형태로 불러온다
			            //[]이것이 json에서 배열의 형태
			            
		                JSONObject features_Obj = (JSONObject) memberArray.get(0);	//0번째
		                JSONObject  attributes = (JSONObject) features_Obj.get("attributes");
		                
//////////////////////////////////출력 TEST/////////////////////////////////////////////
//		                System.out.println(i + "번째 파일----------------------------");
//		                System.out.println("(산코드)"+attributes.get("MNTN_CODE"));
//		       		 	System.out.println("(산이름)"+attributes.get("MNTN_NM"));
//		       		 	System.out.println("(등산로명)"+attributes.get("PMNTN_NM"));
//		       		 	System.out.println("(등산로길이)"+attributes.get("PMNTN_LT"));
//		       		 	System.out.println("(난이도)"+attributes.get("PMNTN_DFFL"));
//		       		 	System.out.println("(산행시간)"+attributes.get("PMNTN_UPPL"));
//		       		 	System.out.println("(하행시간)"+attributes.get("PMNTN_GODN"));
//		                System.out.println("----------------------------"); // 산정보
		                
		                System.out.println("삽입전");
		                //data Insert
		                String tmp = attributes.get("MNTN_NM").toString();	//오브젝트에서 문자열로 변환
		                tmp =  new String( tmp.getBytes("UTF-8"),"UTF-8");	//utf-8로 변환
		                String tmp1 = attributes.get("PMNTN_NM").toString();
		                tmp1 =  new String( tmp1.getBytes("UTF-8"),"UTF-8");
		                String tmp2 = attributes.get("PMNTN_DFFL").toString();
		                tmp2 =  new String( tmp2.getBytes("UTF-8"),"UTF-8");
		                


		               // 쿼리문을 직접 만들어 준다.
		                String sql = "insert into Infomountain values('" +  attributes.get("MNTN_CODE") + "','" + tmp + "','"
		                		+ tmp1  + "','" +  attributes.get("PMNTN_LT") + "','" +  tmp2 + "','" 
		                		+ attributes.get("PMNTN_UPPL") + "','" +  attributes.get("PMNTN_GODN") + "')";	
		                // 쿼리문을 삽입 후 데이터 삽입
		                int rss  = stmt.executeUpdate(sql);
		                String sql2 = "insert into likemountain values('"+ attributes.get("MNTN_CODE") + "','" + 0 + "','" + 0 + "')";
		                int rss2  = stmt.executeUpdate(sql2);  //executeUpdate은 int 형이다.
		                

		                System.out.println(i+"번째 Insert Data");

         
	 /*
	                //산 좌표 (세계 좌표)
	                JSONObject  geometry = (JSONObject) features_Obj.get("geometry");
	                
	                JSONArray  paths_Array1 = (JSONArray) geometry.get("paths");
	                JSONArray  paths_Array2 = (JSONArray) paths_Array1.get(0);
	                for (int i = 0; i < paths_Array2.size(); i++)	{
	                	JSONArray  geo = (JSONArray) paths_Array2.get(i);
	                	//System.out.println("paths_Arra : "+ geo);
	                	//for(int j = 0; j < geo.size(); j++)	{
	                		System.out.println(i+ " 번 paths_Arra0 : "+ (double) geo.get(0));
	                		System.out.println(i+ " 번 paths_Arra1 : "+ (double) geo.get(1));
	                	//}
	                
	                }
		*/
	
		    	} catch (IOException e) {
		    		e.printStackTrace();
		    	} catch (ParseException e) {
		    		e.printStackTrace();
		    	}   
			 }//for문	
	            stmt.close();  
	            con.close();  
	            
        } catch (Exception e) {        //try
            System.out.println(e.getMessage());
        }  

	    }//main
	    
	
}//class
