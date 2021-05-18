<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Social Media</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="socialmedia.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<script type="text/javascript" src="socialmedia.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>
	<div class="background1">
		<div class="headliner_block">
			<div class="logo">
				<a href="home.jsp?wID=${login.WID}"><img src="pictures/meetup_logo.png"
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
					<a href="profile.jsp?wID=${login.WID}"><img src="pictures/${login.fileName}"
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
					<li><a href="home.jsp?wID=${login.WID}"><dfn class="tooltip">
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
					<li><a href="javascript:progress()"><dfn class="tooltip">
								Progress <span role="tooltip" style="font-weight: normal">Here
									you can find your project and team status</span>
							</dfn></a></li>
					<li><a href="socialmedia.jsp" style="font-weight: bold"><dfn
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
					class="close" title="Schließen">&times;</span>
			</div>
			<div class="popupBody"></div>
		</div>
	</div>

	<div class="background2">
		<br> <div class="header2">Social Media Schedule</div>
		<div class="socialmedia_navigation">
			<nav>
				<ul>
					<li><a class="sortPosts"
						onclick="document.getElementById('posts_sort').style.display='block'"
						style="width: auto;"><img src="pictures/sort.png" alt="Sort">Sort</a></li>
					<li><a class="filterDate"
						onclick="document.getElementById('date_filter').style.display='block'"
						style="width: auto;"><img src="pictures/filter.png"
							alt="Settings">Filter</a></li>
					<li><a class="socialmediaPopup"
						onclick="document.getElementById('add_post').style.display='block'"
						style="width: auto;"><img src="pictures/add.png" alt="Add">New
							Post</a></li>
				</ul>
			</nav>
		</div>

		<!-- Pop-Up-Window New Post -->
		<div id="add_post" class="socialmedia_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					Add new Post <span
						onclick="document.getElementById('add_post').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<div class="popupBody_SocialMedia">
					<div class="popupInfo">
						<form action="UploadPost" method="post"
							enctype="multipart/form-data">
							<div>
								<label>Person</label> <input type="text" name="person"
									required="required" />
							</div>
							<div>
								<label>Channel</label> <select name="channel">
									<option selected="">Select the channel</option>
									<option value="Facebook">Facebook</option>
									<option value="Instagram">Instagram</option>
									<option value="Xing">Xing</option>
									<option value="LinkedIn">LinkedIn</option>
								</select>
							</div>
							<div>
								<label>Category</label> <select name="category"
									style="margin-left: -2px">
									<option selected="">Select the category</option>
									<option value="Image Post">Image Post</option>
									<option value="Story">Story</option>
									<option value="Video">Video</option>
								</select>
							</div>
							<div>
								<label>Design</label> <input type="file" id="file-upload-button"
									name="file" required="required" />
							</div>
							<div>
								<label>Status</label> <select name="status"
									style="margin-left: 22px">
									<option value="In Progress">In Progress</option>
									<option value="Published">Published</option>
								</select>
							</div>
							<div>
								<label>Date</label> <input type="date" name="postDate"
									style="margin-left: 33px;" required="required">
							</div>
							<div>
								<label style="position: absolute">Text</label>
								<textarea name="text"></textarea>
							</div>
							<button type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
		</div>

		<hr>
		<br>
		
		<p style="font-weight:bold">${message}</p>
		<table class="socialmedia">
			<thead>
				<tr>
					<th style="width: 200px">Person</th>
					<th style="width: 150px">Channel</th>
					<th style="width: 150px">Category</th>
					<th style="width: 200px">Design</th>
					<th style="width: 250px">Text</th>
					<th style="width: 150px">Status</th>
					<th style="width: 185px">Date</th>
					<th style="width: 150px">Settings</th>
				</tr>
			</thead>
		</table>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
				Statement st = con.createStatement();
				String sql = "SELECT * FROM socialmedia";
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String id = rs.getString("id");
					String person = rs.getString("person");
					String channel = rs.getString("channel");
					String category = rs.getString("category");
					String filename = rs.getString("filename");
					String status = rs.getString("status");
					LocalDate postDate = rs.getDate("postDate").toLocalDate();
					String text = rs.getString("text");
		%>
		<input type="hidden" name="id" value='<%=rs.getString("id")%>' />
		<table class="socialmedia">
			<tr>
				<td style="hyphens: auto; word-break: break-word; width: 200px;"><%=person%></td>
				<td style="width: 150px;"><%=channel%></td>
				<td style="width: 150px;"><%=category%></td>
				<td style="width: 200px;"><img src="pictures/<%=filename%>" /><a
					href="editImage.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 25px; height: 25px;"></a></td>
				<td style="hyphens: auto; word-break: break-word; width: 250px;"><%=text%></td>
				<td style="width: 150px;"><%=status%></td>
				<td style="width: 185px;"><p align="center"><%=postDate%></td>
				<td style="width: 150px;"><a
					href="editPost.jsp?id=<%=rs.getString("id")%>"><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute; margin: -17px -45px;"></a>
					<a
					onclick="document.getElementById('delete_info').style.display='block'"
					<%=rs.getString("id")%> style="width: auto;"><img
						src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; position: absolute; margin: -17px 5px;" />
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
		<div id="delete_info" class="socialmedia_addBlock">

			<!-- Window content -->
			<div class="addBlock">
				<div class="popupHeader">
					<img src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; margin: -4px -2px;" /> Delete
					Post <span
						onclick="document.getElementById('delete_info').style.display='none'
					"
						class="close" title="Schließen">&times;</span>
				</div>
				<%
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
						Statement st = con.createStatement();
						String sql = "SELECT * FROM socialmedia";
						ResultSet rs = st.executeQuery(sql);
						int i = 0;
						while (rs.next()) {
							String id = rs.getString("id");
							String person = rs.getString("person");
							String channel = rs.getString("channel");
							String category = rs.getString("category");
							String filename = rs.getString("filename");
							String status = rs.getString("status");
							LocalDate postDate = rs.getDate("postDate").toLocalDate();
							String text = rs.getString("text");
				%>
				<div class="popupBody_SocialMedia">

					<div class="popupInfo">
						<input type="text" name="id" value='<%=rs.getString("id")%>' /> <a
							class="aButtons" href="deletePost.jsp?id=<%=rs.getString("id")%>">Delete</a>
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