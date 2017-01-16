<%@page import="com.sun.corba.se.impl.protocol.giopmsgheaders.Message"%>
<%@page
	import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int login_status = 0; //1: login success, 2: wrong pwd, 3: id not found
		String ID = request.getParameter("input_id");
		String PW = request.getParameter("input_pwd");
		String str = null;
		String url = "http://192.168.0.29:8080/Attendance/login.jsp";

		if (ID == "" || PW == "") {
			str = "Insert data!";
			out.println("<script>alert('" + str + "'); window.location.href='" + url + "';</script>");
		} else {
			Connection conn = null;
			Statement stmt = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/testdb?autoReconnect=true&useSSL=false", "root", "1234");

				if (conn == null)
					throw new Exception("db connection failed");

				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM lists WHERE Email = '" + ID + "';");

				if (rs.next()) { //existing ID
					String Email = rs.getString("Email");
					String Passwd = rs.getString("Passwd");
					if (PW.equals(Passwd)) { 	//1: login success
						login_status = 1;
						out.println("login_status : "+login_status);
					}

					else { //2: wrong passwd
						login_status = 2;
						str = "wrong password!!";
						out.println("<script>alert('" + str + "'); window.location.href='" + url + "';</script>");
					}
				}

				else { //3: ID not found
					login_status = 3;
					str = "ID not found.\nWould you like to join?";
					out.println(str);

					request.setAttribute("ID", ID);
					request.setAttribute("PW", PW);

					RequestDispatcher dispatcher = request.getRequestDispatcher("join.jsp");
					dispatcher.forward(request, response);
				}
			} finally {
				try {
					stmt.close();
				} catch (Exception ignored) {
				}

				try {
					conn.close();
				} catch (Exception ignored) {
				}
			}
		}
	%>
</body>
</html>