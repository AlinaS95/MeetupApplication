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
					<li><a href="admin.jsp">Admin Center</a></li>
					<li><a href="adminUser.jsp" style="margin-left:165px; font-weight:bold">User</a></li>
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
		<br> <b>User List</b>
		<div class="admin_navigation">
			<nav>
				<ul>
					<li><a class="sortPosts"
						onclick="document.getElementById('posts_sort').style.display='block'"
						style="width: auto;"><img src="pictures/sort.png" alt="Sort">Sort</a></li>
					<li><a class="filterDate"
						onclick="document.getElementById('date_filter').style.display='block'"
						style="width: auto;"><img src="pictures/filter.png"
							alt="Settings">Filter</a></li>
				</ul>
			</nav>
		</div>
		<hr>
		<br>
		<!-- User -->
		<table class="user">
			<thead>
				<tr>
					<th style="width: 250px">First Name</th>
					<th style="width: 250px">Last Name</th>
					<th style="width: 250px">Email</th>
					<th style="width: 250px">Company</th>
					<th style="width: 250px">Workspace</th>
					<th style="width: 150px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM user";
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String userID = rs.getString("userID");
					String firstName = rs.getString("firstName");
					String lastName = rs.getString("lastName");
					String email = rs.getString("email");
					String company = rs.getString("company");
					String workspace = rs.getString("workspace");
		%>
		<input type="hidden" name="userID" value='<%=rs.getString("userID")%>' />
		<table class="user">
			<tr>
				<td style="width: 250px;"><%=firstName%></td>
				<td style="width: 250px;"><%=lastName%></td>
				<td style="width: 250px;"><%=email%></td>
				<td style="width: 250px;"><%=company%></td>
				<td style="width: 250px;"><%=workspace%></td>
				<td style="width: 150px;"><a
					href="editUser.jsp?userID=<%=rs.getString("userID")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 30px; height: 30px; position: absolute; margin: -20px -48px;"></a>
					<a
					onclick="document.getElementById('delete_info').style.display='block'"
					<%=rs.getString("userID")%> style="width: auto;"><img
						src="pictures/delete2.png" alt="Delete post"
						style="width: 24px; height: 24px; position: absolute; margin: -18px 0px;" />
				</a></td>
			</tr>
			</tbody>
		</table>
		<%
			}
			} catch (Exception e) {
				out.println(e);
			}
		%>
		<br>
		<hr>
		<br>

		<!-- Pop-Up-Window Delete Info -->
		<div id="delete_info" class="user_popupBlock">

			<!-- Window content -->
			<div class="popupBlock">
				<div class="popupHeader">
					<img src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; margin: -4px -2px;" /> Delete
					User <span
						onclick="document.getElementById('delete_info').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<%
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
						Statement st = con.createStatement();
						String sql = "SELECT * FROM user";
						ResultSet rs = st.executeQuery(sql);
						int i = 0;
						while (rs.next()) {
							String userID = rs.getString("userID");
							String firstName = rs.getString("firstName");
							String lastName = rs.getString("lastName");
							String email = rs.getString("email");
							String company = rs.getString("company");
							String workspace = rs.getString("workspace");
				%>
				<div class="popupBody_user">

					<div class="popupInfo">
						<input type="text" name="userID"
							value='<%=rs.getString("userID")%>' /> <a class="aButtons"
							href="deleteUser.jsp?userID=<%=rs.getString("userID")%>">Delete</a>
						<br>
					</div>
				</div>
				<%
					}
					} catch (Exception e) {
						out.println(e);
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>