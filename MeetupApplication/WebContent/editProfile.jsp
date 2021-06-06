<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="profile.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" type="text/css" href="editor.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
	function myFunction() {
		var x = document.getElementById("settingsText");
		if (x.style.display === "none") {
			x.style.display = "block";
		} else {
			x.style.display = "none";
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
					Welcome <a class="firstname">${login.firstName}</a>
				</h3>
				<a class="favorites"
					onclick="document.getElementById('p_favorites').style.display='block'"
					style="width: auto;"><img src="pictures/favorite.png"
					alt="Favorites"></a> <a class="status"
					href="javascript:progress()"><img
					src="pictures/greenCircle.png" alt="Status"></a>
			</div>
			<br>
			<div class="secondblock">
				<div class="searchbox">
					<span class="searchicon"><img src="pictures/search.png"></span>
					<input type="search" id="search" placeholder="Search..." />
				</div>
				<div class="user">
					<a href="profile.jsp"><img src="pictures/${login.fileName}"
						alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a href="javascript:menue()"><img
							src="pictures/navigation.png" alt="Menu"></a></li>
					<li><a href="home.jsp">Home</a></li>
					<li><a href="javascript:list()">List</a></li>
					<li><a href="javascript:board()">Board</a></li>
					<li><a href="calendar.jsp">Calendar</a></li>
					<li><a href="javascript:progress()">Progress</a></li>
					<li><a href="socialmedia.jsp">Social Media</a></li>
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
				<input type="hidden" name="wID" value="<%=rs.getString("wID") %>"/>
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
						href="changePassword.jsp?userID=${login.userID}">Change Password</a>
				</div>
				<br> <a class="aButtons" href="profile.jsp?wID=${login.WID}"
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
