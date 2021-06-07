<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="leiste.css">

<%
	String taskName = request.getParameter("val");
	String wID = request.getParameter("wID");
	if (taskName == null || taskName.trim().equals("")) {
		out.print("<p class='defaultSearch'>Search task!</p>");
	} else {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
			PreparedStatement ps = con.prepareStatement("select * from tasks where taskName like '" + taskName + "%'");
			ResultSet rs = ps.executeQuery();

			if (!rs.isBeforeFirst()) {
				out.println("<p class='defaultSearch'>No Record Found!</p>");
			} else {
				out.print("<table class='searchTable'>");
				while (rs.next()) {
					out.print("<tr><td><a href='list.jsp?wID="+rs.getString("wID")+"'>" + rs.getString(2) + "</a></td><td><a>" + rs.getString(4) + "</a></td><td><a>"
							+ rs.getString(5) + "</a></td></tr>");
				}
				out.print("</table>");
			} //end of else for rs.isBeforeFirst  
			con.close();
		} catch (Exception e) {
			out.print(e);
		}
	} //end of else
%>
