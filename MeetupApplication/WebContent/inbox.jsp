<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="net.meetup.usermanagement.model.common"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inbox</title>
<link name="viewport" content="width=device-width">
<link rel="stylesheet" type="text/css" href="inbox.css">
<link rel="stylesheet" type="text/css" href="list.css">
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
			<div class="welcome">
				<h3>
					Workspace: <a class="firstname">${login.workspace}</a>
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
					<a href="profile.jsp"><img src="pictures/usericon.png"
						alt="Profil Icon" /></a>
				</div>
			</div>
			<br>
		</div>

		<div class="mainmenu">
			<nav>
				<ul>
					<li><button id="start">
							<img src="pictures/navigation.png" height="50" width="50"
								align="left" alt="navigation">
						</button> </a></li>
					<li><a href="javascript:home()" style="font-weight: bold">Home</a></li>
					<li><a href="javascript:list()">List</a></li>
					<li><a href="javascript:board()">Board</a></li>
					<li><a href="javascript:calendar()">Calendar</a></li>
					<li><a href="javascript:progress()">Progress</a></li>
					<li><a href="javascript:socialmedia()">Social Media</a></li>
				</ul>

				<div class="secondNavigation">
					<ul>
						<li><a class="add"
							onclick="document.getElementById('l_add').style.display='block'"
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

		<h1>Inbox</h1>
		<div class="notifi-item">
			<img src="pictures/notificationring.png" alt="">
		</div>
		<ul id="navigation">
			<li><a onclick="myFunction()">All</a></li>
			<p id="demo"></p>
			<li><a href="news.html">Assigned by me</a></li>
			<li><a href="infos.html">Assigned to me</a></li>
		</ul>
		<br> <br>


	<!-- Messages -->
	<br>
	<b class="editHeader">Messages</b>
	<div class="list_navigation">
		<nav>
			<ul>
				<li><a class="socialmediaPopup"
					onclick="document.getElementById('add_post').style.display='block'"
					style="width: auto;"><img src="pictures/add.png" alt="Add">New
						Message</a></li>
			</ul>
		</nav>
	</div>

	<!-- Pop-Up-Window New Post -->
	<div id="add_post" class="list_addBlock">

		<!-- Window content -->
		<div class="addBlock">
			<div class="popupHeader">
				Add new Message <span
					onclick="document.getElementById('add_post').style.display='none'
					"
					class="close" title="Schließen">&times;</span>
			</div>
			<div class="popupBody_list">
				<div class="popupInfo">
					<form action="UploadInbox" method="post">
						<div>
							<label>Assignee</label> <input type="text" name="assignee"
								required="required" />
						</div>
						<div>
							<label>Title</label> <input type="text" name="title"
								required="required" />
						</div>
						<div>
							<label>Description</label> <input type="text" name="description"
								required="required" />
						</div>
						<div>
							<label>Workspace</label> <input type="text" name="workspace"
								required="required" />
						</div>
						<div>
							<label>Due Date</label> <input type="date" name="dueDate"
								style="margin-left: 20px;" required="required">
						</div>
						<button type="submit">Save</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<hr>
	<br>

	<p style="font-weight: bold">${message}</p>
	
	<%
		try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/meetup", "root", "");
		Statement st = con.createStatement();
		String sql = "SELECT * FROM inbox";
		ResultSet rs = st.executeQuery(sql);
		int i = 0;
		while (rs.next()) {
			String inboxID = rs.getString("inboxID");
			String assignee = rs.getString("assignee");
			String title = rs.getString("title");
			String description = rs.getString("description");
			String workspace = rs.getString("workspace");
			LocalDate dueDate = rs.getDate("dueDate").toLocalDate();
	%>
	<input type="hidden" name="inboxID"
		value='<%=rs.getString("inboxID")%>' />
	
	<div class="inboxbox" name="new message">
	<p>New Message</p><hr>
	
			<a style="hyphens: auto; word-break: break-word; position: absolute; margin: 5px -35px;">To: <%=assignee%></a>
			<a style="hyphens: auto; word-break: break-word; position: absolute; margin: 40px -200px">Title: <%=title%></a>
			<a style="width: 200px; position: absolute; margin: 70px -230px"">Description: <%=description%></a>
			<a style="width: 200px; position: absolute; margin: 100px -223px"">Workspace: <%=workspace%></a>
			<a style="width: 115px; height: 35px; position: absolute; margin: -54px -215px;"><%=dueDate%></a>
			<a href="editInbox.jsp?inboxID=<%=rs.getString("inboxID")%>"><img
					src="pictures/settings.png" alt="Settings"
					style="width: 25px; height: 25px; position: absolute; margin: -55px 200px;"></a>
				<a
				onclick="document.getElementById('delete_info').style.display='block'"
				<%=rs.getString("inboxID")%> style="width: auto;"><img
					src="pictures/delete2.png" alt="Delete post"
					style="width: 15px; height: 15px; position: absolute; margin: -50px 170px;" />
			</a>
	</div>
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
	<div id="delete_info" class="list_addBlock">

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
				String sql = "SELECT * FROM inbox";
				ResultSet rs = st.executeQuery(sql);
				int i = 0;
				while (rs.next()) {
					String inboxID = rs.getString("inboxID");
					String assignee = rs.getString("assignee");
					String title = rs.getString("title");
					String description = rs.getString("description");
					String workspace = rs.getString("workspace");
					LocalDate dueDate = rs.getDate("dueDate").toLocalDate();
			%>
			<div class="popupBody_list">

				<div class="popupInfo">
					<input type="text" name="inboxID"
						value='<%=rs.getString("inboxID")%>' /> <a class="aButtons"
						href="deleteInbox.jsp?inboxID=<%=rs.getString("inboxID")%>">Delete</a>
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

		<div class="inboxbox1">
		<br>
		<h3>Friday Meeting: Project x at 10am</h3>
		<p>
			Hello Mr. Mustermann, <br>I would like to remind you that there
			will be a meeting tomorrow at 10:00 am for project x. It would be
			very nice if you bring all the necessary documents with you. <br>Until
			then and best regards <br>Jana Podschaske
		</p>
	</div>

		</div>

	<script>
		'use strict';
		document.addEventListener("DOMContentLoaded", function() {
			//Polyfill für dialog-Element
			var lastFocus;
			var dialog = document.querySelector('dialog');
			var closeButton = document.getElementById('close-dialog');
			closeButton.addEventListener('click', toggleDialog);
			document.querySelector('#open-dialog').addEventListener('click',
					toggleDialog);

			function toggleDialog(event) {
				if (!dialog.hasAttribute('open')) {
					// show the dialog 
					dialog.setAttribute('open', 'open');
					// after displaying the dialog, focus the closeButton inside it
					closeButton.focus();
					// only hide the background *after* you've moved focus out of the content that will be "hidden" 
					var div = document.createElement('div');
					div.id = 'mybackdrop';
					document.body.appendChild(div);
					if (event)
						lastFocus = event.target;
				} else {
					dialog.removeAttribute('open');
					var div = document.querySelector('#mybackdrop');
					div.parentNode.removeChild(div);
					lastFocus.focus();
				}
			}
			// EventListener für ESC-Taste
			document.addEventListener('keydown', keydown, true);

			function keydown(event) {
				if (event.keyCode == 27) {
					toggleDialog();
				}
			}
		});
	</script>

<script>
function myFunction() {
  var x = document.getElementsByName("new message").length;
  document.getElementById("demo").innerHTML = x;
}
</script>
	
</body>
</html>