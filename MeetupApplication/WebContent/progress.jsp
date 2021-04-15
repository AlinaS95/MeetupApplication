<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Progress</title>

<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="stylesheet" type="text/css" href="progress.css">
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
					Workspace: <a class="workspace">${login.workspace}</a>
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
					<li><a href="javascript:menue()"><img
							src="pictures/navigation.png" alt="Menu"></a></li>
					<li><a href="home.jsp"><dfn class="tooltip">
								Home <span role="tooltip" style="font-weight: normal">You
									can find the home area here </span>
							</dfn></a></li>
					<li><a href="javascript:list()"><dfn class="tooltip">
								List <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and create them</span>
							</dfn> </a></li>
					<li><a href="javascript:board()"> <dfn class="tooltip">
								Board <span role="tooltip" style="font-weight: normal">Here
									you can find your tasks and their processing status </span>
							</dfn>
					</a></li>
					<li><a href="calendar.jsp"><dfn class="tooltip">
								Calendar <span role="tooltip" style="font-weight: normal">You
									can find your calendar here </span>
							</dfn></a></li>
					<li><a href="javascript:progress()" style="font-weight: bold"><dfn class="tooltip">
								Progress <span role="tooltip" style="font-weight: normal">Here
									you can find your project and team status</span>
							</dfn></a></li>
					<li><a href="socialmedia.jsp"><dfn
								class="tooltip">
								Social Media <span role="tooltip" style="font-weight: normal">Here
									you can find everything about your social media tasks</span>
							</dfn></a></li>
				</ul>
				<div class="secondNavigation">
					<ul>
						<li><a class="add"
							onclick="document.getElementById('add').style.display='block'"
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
	<!-- Pop-Up-Window -->
	<div id="l_add" class="navigation_addBlock">

		<!-- Window content -->
		<div class="addBlock">
			<div class="popupHeader">
				Add<span
					onclick="document.getElementById('l_add').style.display='none'"
					class="close" title="Schlie�en">&times;</span>
			</div>
			<div class="popupBody"></div>
		</div>
	</div>



	<h4>
		This Project is </h4><a style="position:absolute;margin:-48px 135px" class="workspace">${login.workspace}</a>


	<div class="box1">
		Overdue Task<br>
		<a> <%
 	try {
 		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
 		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
 		Statement st = con.createStatement();
 		String strQuery = "SELECT COUNT(*) FROM tasks";
 		ResultSet rs = st.executeQuery(strQuery);
 		String Countrow = "";
 		while (rs.next()) {
 			Countrow = rs.getString(1);
 			out.println(Countrow);
 		}
 	} catch (Exception e) {
 		e.printStackTrace();
 	}
 %></a>
	</div>

	<div class="box2">
		Incompleted Task<br>
		<a> <%
 	try {
 		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
 		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
 		Statement st = con.createStatement();
 		String strQuery = "SELECT COUNT(*) FROM tasks";
 		ResultSet rs = st.executeQuery(strQuery);
 		String Countrow = "";
 		while (rs.next()) {
 			Countrow = rs.getString(1);
 			out.println(Countrow);
 		}
 	} catch (Exception e) {
 		e.printStackTrace();
 	}
 %></a>
	</div>

	<div class="box3">
		Completed Task<br>
		<a> <%
 	try {
 		Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
 		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
 		Statement st = con.createStatement();
 		String strQuery = "SELECT COUNT(*) FROM tasks";
 		ResultSet rs = st.executeQuery(strQuery);
 		String Countrow = "";
 		while (rs.next()) {
 			Countrow = rs.getString(1);
 			out.println(Countrow);
 		}
 	} catch (Exception e) {
 		e.printStackTrace();
 	}
 %></a>
	</div>
	<h5>Project Status</h5>

	<div class="projectstatus">
		<div id="myProgress">
			<div id="myBar"></div>
		</div>
	</div>

	<h6>Team Status</h6>
	<div class="teamstatus"></div>
</body>
</html>