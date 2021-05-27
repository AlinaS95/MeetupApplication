<%@ page import="java.sql.*"%>

<HTML>
<HEAD>
<TITLE>Fetching Data From a Database</TITLE>
</HEAD>

<BODY>
	<H1>Fetching Data From a Database</H1>

	<%
		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
		Statement st = con.createStatement();

		String kw = request.getParameter("kw");

		ResultSet rs = st.executeQuery("select * from workingtime where kw = '" + kw + "'");

		if (!rs.next()) {
			out.println("Sorry, could not find that week. ");
		} else {
	%>

	<TABLE BORDER="1">
		<TR>
			<TH>KW</TH>

		</TR>
		<TR>
			<TD><%=rs.getString(2)%></TD>
			<TD><%=rs.getString(3)%></TD>
			<TD><%=rs.getString(4)%></TD>
			<TD><%=rs.getString(5)%></TD>
			<TD><%=rs.getString(6)%></TD>
			<TD><%=rs.getString(7)%></TD>
		</TR>
	</TABLE>
	<BR>
	<%
		}
	%>
	<a href="time.jsp">back</a>
</BODY>
</HTML>