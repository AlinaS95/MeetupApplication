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
<title>Social Media</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="socialmedia.css">
<link rel="stylesheet" type="text/css" href="editor.css">
<link rel="stylesheet" type="text/css" href="leiste.css">
<link rel="icon" type="image/png" href="pictures/meetup_logo.png">
<script type="text/javascript" src="methods.js"></script>
<script type="text/javascript" src="socialmedia.js"></script>
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

	<div class="background2">
		<br>
		<div class="editHeader">Edit Post</div>
		<hr>
		<br>
		<div class="editBody">
			<%
				String id = request.getParameter("id");
				String driver = "com.mysql.jdbc.Driver";
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
					String sql = "select * from socialmedia where id=" + id;
					rs = statement.executeQuery(sql);
					while (rs.next()) {
			%>
			<form action="UpdatePost" method="post">
				<input type="hidden" name="id" value="<%=rs.getString("id")%>">
				<div>
					<label>Person</label><input type="text" name="person"
						value='<%=rs.getString("person")%>' />
				</div>
				<div class="selected">
					<label>Channel</label><select name="channel"><%=rs.getString("channel")%>
						<option selected=""><%=rs.getString("channel")%></option>
						<option value="Facebook">Facebook</option>
						<option value="Instagram">Instagram</option>
						<option value="Xing">Xing</option>
						<option value="LinkedIn">LinkedIn</option>
					</select>
				</div>
				<div class="selected">
					<label>Category</label> <select name="category"><%=rs.getString("category")%>
						<option selected=""><%=rs.getString("category")%></option>
						<option value="Image Post">Image Post</option>
						<option value="Story">Story</option>
						<option value="Video">Video</option>
					</select>
				</div>
				<div>
					<label style="margin-left:-133px">Status</label> <select name="status"><%=rs.getString("status")%>
						<option style="font-weight:bold"selected=""><%=rs.getString("status")%></option>
						<option value="In Progress">In Progress</option>
						<option value="Published">Published</option>
					</select>
				</div>
				<div>
					<label style="margin-left: -50px;">Date</label><input type="date"
						name="postDate" style="margin-left: 5px"
						value='<%=rs.getDate("postDate").toLocalDate()%>' />
				</div>
				<div>
					<label style="position: absolute; margin: 2px -140px;">Text</label>
					<textarea name="text"
						style="position: absolute; margin: 2px -95px;"><%=rs.getString("text")%></textarea>
				</div>
				<br> <br> <br> <a class="aButtons"
					href="socialmedia.jsp">Back</a>
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
