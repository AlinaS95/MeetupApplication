<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Deletion</title>
</head>
<body>
<%
	String email=request.getParameter("email");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup","root","");
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("delete from user where email = ?;");
	if(rs.next()){
		out.print("Your account has been deleted!");
	}
	else {
		out.print("Check your Login Credential");
	}
%>
</body>
</html>