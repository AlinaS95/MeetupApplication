<%@page import=" java.util.*"%>
<%@page import=" java.sql.*"%>
<%@page import=" java.io.PrintWriter"%>
<%@page import=" java.sql.Connection "%>
<%@page import=" java.sql.DriverManager"%>
<%@page import=" java.sql.PreparedStatement "%>
<%@page import=" java.sql.ResultSet"%>
<%@page import=" javax.swing.*"%>

<div id="content">
	<div class="box">

		<%
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				try {
					System.out.println("DB2 driver is loaded successfully");
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
					if (con != null) {
						System.out.println("DB2 Database Connected");
					} else {
						System.out.println("Db2 connection Failed ");
					}
				} catch (SQLException ex) {
				}
				try {

					String s = "yes";
					pstmt = con.prepareStatement("select count(*) from notification where status=? and ts<now() ");
					pstmt.setString(1, s);
					rs = pstmt.executeQuery();
					rs.first();
					String count;
					count = rs.getString(1);
					int count1 = Integer.parseInt(count);

					pstmt = con.prepareStatement("select * from notification where status=? and ts<now() ");
					pstmt.setString(1, s);
					rs = pstmt.executeQuery();
					rs.first();
		%>
		<font face=Times New Roman size=4px><i>You have <%=count1%>
				New Notifications.
		</i></font>
	</div>

	<div class="box">
		<font face=Times New Roman size=4px><h1>
				<b><center>Notifications</center></b>
			</h1>
			<p>
				<%
					for (int i = 0; i < count1; i++) {
				%>
				<select name="ocms"><br />
					<b><br>Notification <%=i + 1%> :</b>
				<br>
					<option>Posts:<%=rs.getString("post")%></option>
					<option>PostId:<%=rs.getString("postid")%></option>
					<option>UserId:
						<%=rs.getString("userid")%></option>
					<option>Username:
						<%=rs.getString("username")%></option>
					<option>status:
						<%=rs.getString("status")%></option>

				</select>
				<%
					rs.next();
							}
						} catch (SQLException ex) {
						}

					} catch (ClassNotFoundException e) {
						System.out.println("Please include Classpath  Where your DB2 Driver is located");
						e.printStackTrace();
						// return conn;
					}
				%>


			</p> </font> <br>
	</div>
	<br class="clearfix" />
</div>
<div id="sidebar"></div>
<br class="clearfix" />