<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String userID=request.getParameter("userID");
String wID = request.getParameter("wID");
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
Statement st=conn.createStatement();
int i=st.executeUpdate("DELETE FROM user WHERE userID="+userID);
request.getRequestDispatcher("profile.jsp?="+wID).forward(request, response);
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>