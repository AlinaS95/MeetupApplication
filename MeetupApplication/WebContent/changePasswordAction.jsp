<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Password</title>
</head>
<body>
	<%
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String wID = request.getParameter("wID");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement ps = con.prepareStatement("update user set password=PASSWORD(?) where email=?");
			ps.setString(2, email);
			ps.setString(1, password);
			int i = ps.executeUpdate();
			if (i > 0) {
				response.sendRedirect("profile.jsp?wID="+wID);
			} else {
				response.sendRedirect("changePassword.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>