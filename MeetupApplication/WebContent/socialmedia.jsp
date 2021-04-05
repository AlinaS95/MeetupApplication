<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
<script>
	Date.prototype.getWeekNumber = function() {

		var oneJan = new Date(this.getFullYear(), 0, 1);

		// calculating number of days  
		//in given year before given date 

		var numberOfDays = Math.floor((this - oneJan) / (24 * 60 * 60 * 1000));

		// adding 1 since this.getDay() 
		//returns value starting from 0 

		return Math.ceil((this.getDay() + 1 + numberOfDays) / 7);

	}

	function printWeekNumber() {
		var dateInput = document.getElementById("dateInput").value;
		var date = new Date(dateInput);
		var result = date.getWeekNumber();
		document.getElementById("result").innerHTML = +result;
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
		<br>
		<div class="category_socialmedia">Social Media Schedule</div>
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
								<label>Person</label> <input type="text" name="person" />
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
								<label>Category</label> <select name="category">
									<option selected="">Select the category</option>
									<option value="Image Post">Image Post</option>
									<option value="Story">Story</option>
									<option value="Video">Video</option>
								</select>
							</div>
							<div>
								<label>Design</label> <input type="file" id="file-upload-button"
									name="file" />
							</div>
							<div>
								<label>Text</label>
								<textarea type="text" name="text"></textarea>
							</div>
							<button type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<br>
		<p>${message}</p>
		<table class="socialmedia">
			<thead>
				<tr>
					<th style="width: 150px">Week</th>
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
				int i=0;
				while (rs.next()) {
					String person = rs.getString("person");
					String channel = rs.getString("channel");
					String category = rs.getString("category");
					String filename = rs.getString("filename");
					String text = rs.getString("text");
		%>
		<table class="socialmedia">
			<tr>
				<td style="width: 150px;"><p>
						<button onclick="printWeekNumber()">Week Number</button>
					</p> <a id="result"></a></td>
				<td style="hyphens: auto; word-break: break-word; width: 200px;"><%=person%></td>
				<td style="width: 150px;"><%=channel%></td>
				<td style="width: 150px;"><%=category%></td>
				<td style="width: 200px;"><image src="pictures/<%=filename%>" /></td>
				<td style="hyphens: auto; word-break: break-word; width: 250px;"><%=text%></td>
				<td style="width: 150px;">Published</td>
				<td style="width: 185px;"><p align="center"> 
						<input type="date" id="dateInput"></td>
				<td style="width: 150px;"><a href=""><img
						src="pictures/settings.png" alt="Settings"
						style="width: 35px; height: 35px; position: absolute;margin: -17px -45px;"></a> <a href="deletePost.jsp?id=<%=rs.getString("id") %>"><img
						src="pictures/delete2.png" alt="Delete post"
						style="width: 30px; height: 30px; position: absolute;margin: -17px 5px;" /> </a></td>
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
	</div>
</body>
</html>