package Db;
import java.sql.*;
public class Dbutil {
	Connection conn;
	Statement stmt;
	ResultSet rs;
	int rs2;
	public Connection connect() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");//加载mysql驱动
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbwork?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf-8&useSSL=false", "root", "welcome2019");
		return conn;
	}
	
	public ResultSet query(String sql) throws ClassNotFoundException{
        try {
        	conn=connect();
        	stmt=conn.createStatement();
            rs = stmt.executeQuery(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }

	public int update(String sql) throws ClassNotFoundException{
        try {
            conn =connect();
            stmt = conn.createStatement();
            rs2 = stmt.executeUpdate(sql);  
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
        return rs2;
    }

    public int delete(String sql) throws ClassNotFoundException{
        try {
            conn = connect();
            stmt = conn.createStatement();
            rs2 = stmt.executeUpdate(sql);
            return rs2;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

	 public void close(){
	        try {
	            if(rs!=null) {
	                rs.close();
	            }
	            if(stmt!=null) {
	                stmt.close();
	            }
	            if(conn!=null) {
	                conn.close();
	            }

	        } catch (SQLException e) {
	            // TODO: handle exception
	        }
	    }
}
