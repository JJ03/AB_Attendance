<%@ page import="org.json.simple.JSONObject"%>
<% 
JSONObject jsonObject = (JSONObject)request.getAttribute("jsonObject");
out.print(jsonObject);
%>