<%@ page import="java.sql.*"%>
<%
	Class.forName("com.mysql.jdbc.Driver");
%>

<HTML>
<HEAD>
<TITLE>Joining Tables</TITLE>
</HEAD>

<BODY>
	<H1>Joining Tables</H1>

	<%
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");

		Statement statement = connection.createStatement();
		String query = "SELECT user.firstName, user.email, tasks.taskName "
				+ "FROM user INNER JOIN tasks ON user.userID = tasks.taskID";

		ResultSet resultset = statement.executeQuery(query);
	%>

	<TABLE BORDER="1">
		<TR>
			<TH>First Name</TH>
			<TH>Email</TH>
			<TH>Task Name</TH>
		</TR>
		<%
			while (resultset.next()) {
		%>
		<TR>
			<TD><%=resultset.getString(1)%></TD>
			<TD><%=resultset.getString(2)%></TD>
			<TD><%=resultset.getString(3)%></TD>
		</TR>
		<%
			}
		%>
	</TABLE>
</BODY>
</HTML>