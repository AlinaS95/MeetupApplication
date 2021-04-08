<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
String taskID=request.getParameter("taskID");
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
Statement st=conn.createStatement();
int i=st.executeUpdate("DELETE FROM tasks WHERE taskID="+taskID);
String message = "Task is deleted";
request.setAttribute("message", message);
request.getRequestDispatcher("list.jsp").forward(request, response);
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>