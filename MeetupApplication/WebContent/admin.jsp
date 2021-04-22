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
<title>Admin</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="<%=common.url%>profile.css">
<link rel="stylesheet" type="text/css" href="<%=common.url%>admin.css">
<link rel="stylesheet" type="text/css" href="<%=common.url%>leiste.css">
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
					Welcome <a class="firstname">${admin.firstName}</a><br>
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
					<a href="admin.jsp"><img src="pictures/usericon.png"
						alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>
		<div class="mainmenu">
			<nav>
				<ul>
					<li><a href="admin.jsp" style="font-weight:bold">Admin Center</a></li>
					<li><a href="adminUser.jsp" style="margin-left:165px">User</a></li>
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
		<div class="profile_title">Admin Center</div>
		<br>
		<div class="profile_overview" style="height:250px">
			<div class="profile_icon">
				<img src="pictures/usericon.png" alt="user" />
			</div>
			<br style="margin-bottom: 15px"> <a class="profile_info"><img
				src="pictures/infoicon.png" alt="information" />Admin:<a>${admin.firstName}
			</a></a><br> <br> <a>${admin.email}</a>
		</div>
		<br> <br>
		<div class="logout">
			<a href="adminLogin.jsp"><img src="pictures/logout.png"
				alt="Logout" />Logout</a>
		</div>
	</div>
</body>
</html>