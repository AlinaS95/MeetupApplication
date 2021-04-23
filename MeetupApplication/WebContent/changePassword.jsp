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
<link rel="stylesheet" type="text/css" href="socialmedia.css">
<link rel="stylesheet" type="text/css" href="editor.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
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
					<input type="search" id="search" placeholder="Search..." />
				</div>
				<div class="user">
					<a href="javascript:profile()"><img src="pictures/usericon.png"
						alt="Profil Icon" /></a>
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
		<div class="editHeader">Change Password</div>
		<hr>
		<br>
		<div class="editBody">
			<form action="changePasswordAction.jsp" method="post">
				<div>
					<label style="margin-left:-30px">Email</label><input type="text" name="email" 
					required="">
				</div>
				<div>
					<label style="margin-left:-100px">New Password</label><input type="password" name="password"
					required="">
				</div>
				<div>
					<label style="margin-left:-110px">Reply Password</label><input type="password" name="password"
					required="">
				</div>
				<br>  <a class="aButtons"
					href="adminUser.jsp" style="margin-left:30px">Back</a><button
					class="aButtons" type="submit">Change Password</button>
			</form>
		</div>
		<hr>
	</div>
</body>
</html>
