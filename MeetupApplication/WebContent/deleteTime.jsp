<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
			try {
				String userID = request.getParameter("userID");
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM workingtime WHERE userSID=" + userID;
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String id = rs.getString("id");
					String userSID = rs.getString("userSID");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
				<td style="width: 100x;"><input type="hidden"
					name="userSID" value='<%=rs.getString("userSID")%>' /></td>
		<%
			}
			} catch (Exception e) {
				out.println(e);
			}
		%>

<%
	String id = request.getParameter("id");
	String userSID = request.getParameter("userSID");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
		Statement st = conn.createStatement();
		int i = st.executeUpdate("DELETE FROM workingtime WHERE id=" + id);
		response.sendRedirect("timeTracker.jsp?userID="+userSID);
	} catch (Exception e) {
		System.out.print(e);
		e.printStackTrace();
	}
%>