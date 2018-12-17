package mysql;

import java.sql.*;

public class mysql {
	String DBName = "hiking_boast"; //db이름
	String url = "jdbc:mysql://localhost:3306/"+DBName;// user테이블을 수정하면
	String strUser = "root"; // 계정 id
	String strPassword = "1234"; // 계정 패스워드
	String strMySQLDriver = "com.mysql.jdbc.Driver"; // 드라이버 이름 따로 만들어줌
	Connection con = null;	//db 연결
	Statement stmt = null;	//db 삽입시 이용
	PreparedStatement pstmt  = null;
	String updatesql = null;
	

	String tableName = null;
	String[] parameta = null;

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	public String[] getParameta() {
		return parameta;
	}

	public void setParameta(String[] prameta) {
		this.parameta = prameta;
	}

	public Statement getStatement() {
		return stmt;
	}
	public PreparedStatement getPreparedStatement() {
		return pstmt;
	}
	public String getUpdatesql() {
		return updatesql;
	}

	public void setUpdatesql(String updatesql) {
		this.updatesql = updatesql;
	}

/////////////////////////////////////////////////////////////////////////////////////////	
	public mysql() {
        try
        {
        	Class.forName(strMySQLDriver);	//db드라이버설정

          
        } catch (Exception e) {        //try
            System.out.println(e.getMessage());
        }    
	}
	
	public void connect() {
		  try {
			con  = (Connection) DriverManager.getConnection(url,strUser,strPassword);
	          System.out.println("Mysql DB Connection.");
	          stmt = con.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 연결
		
	}
	
	public void disconnect() {
		if(stmt != null)
		{
			try {
				stmt.close();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		if(con != null)
		{
			try {
				con.close();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}
	
	public void updatedata() {
		 try {
			pstmt=con.prepareStatement(updatesql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	
}
