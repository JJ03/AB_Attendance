<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@page
	import="javax.security.auth.message.callback.PrivateKeyCallback.Request"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
</head>
<body>
	<%
		int login_status = 0; //0: initial value, 1: login success, 2: wrong pwd, 3: id not found
		String ID = request.getParameter("pass_id");
		String PW = request.getParameter("pass_pw");
		
		String str = null;
		String url = "http://192.168.1.6:5000/Attendance/login.jsp";
		
		//if (ObjectUtils.isEmpty(ID) || ObjectUtils.isEmpty(PW)) //0: empty
		if (ID == null || ID=="")
			login_status = 97;
		else if (PW == null || PW == "")
			login_status = 98;
		else {
			login_status = 99;
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
					}

					else { //2: wrong passwd
						login_status = 2;
						//str = "wrong password!!";
						//out.println("<script>alert('" + str + "'); window.location.href='" + url + "';</script>");
					}
				}

				else { //3: ID not found
					login_status = 3;
					str = "ID not found.\nWould you like to join?";

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
		
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result_code", login_status);
		request.setAttribute("jsonObject", jsonObject);
		RequestDispatcher dispatch = request.getRequestDispatcher("json.jsp");
		dispatch.forward(request, response);
		//JSONArray jsonArray = new JSONArray();
		//ArrayList itemObjectList = new ArrayList();
				
		//out.print(jsonObject);
		
	%>
</body>
</html>