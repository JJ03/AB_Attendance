<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv = "Content-Type" content = "text/html; charset = UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			String ID = (String)request.getAttribute("ID");
			String PW = (String)request.getAttribute("PW");
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = "INSERT INTO lists(Email, Passwd) VALUES (?,?);";
			
			try{
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/testdb?autoReconnect=true&useSSL=false", "root", "1234");
				
				if(conn == null)
					throw new Exception("db connection failed");
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, ID);
				pstmt.setString(2, PW);
				pstmt.executeUpdate();
			} 
			finally{
				try{
					pstmt.close();
				}catch(Exception ignored){
				}
				
				try{
					conn.close();
				}catch(Exception ignored){
				}
			}
			
			out.println("New ID created");
			
		%>
	</body>
</html>