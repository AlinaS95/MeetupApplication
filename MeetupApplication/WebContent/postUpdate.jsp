<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="net.meetup.utils.JDBCUtils"%>

<%!String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://localhost:3306/meetup";%>
<%!String user = "root";%>
<%!String psw = "";%>
<%
	String id = request.getParameter("id");
	String person = request.getParameter("person");
	String channel = request.getParameter("channel");
	String category = request.getParameter("category");
	String text = request.getParameter("text");
	String status = request.getParameter("status");
	LocalDate postDate = LocalDate.parse(request.getParameter("postDate"));
	
	if (id != null) {
		Connection con = null;
		PreparedStatement ps = null;
		int socialID = Integer.parseInt(id);
		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(url, user, psw);
			String sql = "Update socialmedia set id=?,person=?,channel=?,category=?,text=?,status=?,postDate=? where id=" + id;
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, person);
			ps.setString(3, channel);
			ps.setString(4, category);
			ps.setString(5, text);
			ps.setString(6, status);
			ps.setDate(7, JDBCUtils.getSQLDate(postDate));

			ps.executeUpdate();
			response.sendRedirect("socialmedia.jsp");
			
		} catch (SQLException sql) {
			request.setAttribute("error", sql);
			out.println(sql);
		}
	}
%>