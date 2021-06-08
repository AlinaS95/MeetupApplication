<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="net.meetup.utils.JDBCUtils"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="editor.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<!-- Search Tasks -->
<script>
	var request = new XMLHttpRequest();
	function searchInfo() {
		var taskName = document.vinform.taskName.value;
		var url = "search.jsp?val=" + taskName;

		try {
			request.onreadystatechange = function() {
				if (request.readyState == 4) {
					var val = request.responseText;
					document.getElementById('taskOutput').innerHTML = val;
				}
			}//end of function  
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}
</script>
</head>
<body>
	<div class="background1">
		<div class="headliner_block">
			<div class="logo">
				<a href="javascript:home()"><img src="pictures/meetup_logo.png"
					alt="Home"></a>
			</div>
			<div class="firstBox">
				<h3>
					Admin: <a class="workspace">${admin.firstName}</a>
				</h3>
				<a class="information"
					onclick="document.getElementById('p_info').style.display='block'"
					style="width: auto;"><img src="pictures/infoicon.png"
					alt="Information"></a> <a class="status"
					href="javascript:progress()"><img
					src="pictures/greenCircle.png" alt="Status"></a>
			</div>
			<br>
			<div class="secondblock">
				<div class="searchbox">
					<span class="searchicon"><img src="pictures/search.png"></span>
					<form name="vinform">
						<input id="search" type="text" name="taskName"
							onkeyup="searchInfo()">
					</form>
					<span id="taskOutput"></span>
				</div>
				<div class="user">
					<a href="profile.jsp?wID=${login.WID}"><img
						src="pictures/usericon.png" alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a href="admin.jsp">Admin Center</a></li>
					<li><a href="adminUser.jsp"
						style="margin-left: 165px; font-weight: bold">User</a></li>
					<li><a href="">Workspaces</a></li>
					<li><a href="">Settings</a></li>
				</ul>
				<div class="secondNavigation">
					<ul>
						<li><a class="add Task"
							onclick="document.getElementById('task_add').style.display='block'"
							style="width: auto;"><img src="pictures/add.png" alt="Add"></a></li>
						<li><a class="profile_settings"
							onclick="document.getElementById('p_settings').style.display='block'"
							style="width: auto;"><img src="pictures/settings.png"
								alt="Settings"></a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>

	<div class="background2">
		<br>
		<div class="editHeader">Edit User</div>
		<hr>
		<br>
		<div class="editBody">
			<%
				String userID = request.getParameter("userID");
				String driver = "com.mysql.cj.jdbc.Driver";
				String connectionUrl = "jdbc:mysql://localhost:3306/";
				String database = "meetup";
				String userid = "root";
				String password = "";
				try {
					Class.forName(driver);
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				Connection connection = null;
				Statement statement = null;
				ResultSet rs = null;
			%>
			<%
				try {
					connection = DriverManager.getConnection(connectionUrl + database, userid, password);
					statement = connection.createStatement();
					String sql = "select * from user where userID=" + userID;
					rs = statement.executeQuery(sql);
					while (rs.next()) {
			%>
			<form action="UpdateUser" method="post">
				<input type="hidden" name="userID"
					value="<%=rs.getString("userID")%>" />
				<div>
					<label>First Name</label><input type="text" name="firstName"
						value='<%=rs.getString("firstName")%>' />
				</div>
				<div>
					<label>Last Name</label><input type="text" name="lastName"
						value='<%=rs.getString("lastName")%>' />
				</div>
				<div>
					<label style="margin-left: 40px">Email</label><input type="text"
						name="email" value='<%=rs.getString("email")%>' />
				</div>
				<div>
					<label style="margin-left: 10px">Company</label><input type="text"
						name="company" value='<%=rs.getString("company")%>' />
				</div>
				<div>
					<label>Workspace</label><input type="text" name="workspace"
						value='<%=rs.getString("workspace")%>' />
				</div>
				<div style="margin: 5px 0px">
					<label style="margin-left: -80px">Password</label><a
						class="aButtons" style="font-weight: bold"
						href="changePassword.jsp">Change Password</a>
				</div>
				<br> <a class="aButtons" href="adminUser.jsp"
					style="margin-left: 10px">Back</a>
				<button type="submit">Update</button>
			</form>

			<%
				}
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</div>
		<br>
		<hr>
	</div>
</body>
</html>
