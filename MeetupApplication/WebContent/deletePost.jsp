<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String id=request.getParameter("id");
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
Statement st=conn.createStatement();
int i=st.executeUpdate("DELETE FROM socialmedia WHERE id="+id);
response.sendRedirect("socialmedia.jsp");
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>